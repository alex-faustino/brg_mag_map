% This script is a modified copy of the original Mapping_Baseline script
% used for the MagPIE IPIN paper; it computes the map of the norm of the
% magnetometer measurements from training data
%   Originally written by: David Hanley
%   Modifications by: Alex Faustino

clear
close all

%% Load Data
% Absolute path to platform data directory
addpath('Z:\Desktop\BRG\MagPIE\Data Set\CSL First Floor\UGV')
% addpath('\\ad.uillinois.edu\engr\instructional\afausti2\Desktop\BRG\MagPIE\Data Set\Talbot Third Floor\UGV')
load('GT_Mag.mat')
load('x.mat')
load('y.mat')
load('xTrain.mat')
load('yTrain.mat')
load('xDevel.mat')
load('yDevel.mat')
load('xTest.mat')
load('yTest.mat')

% Absolute path for GPML matlab directory
addpath('Z:\Desktop\BRG\GP for Machine Learning\gpml-matlab\gpml-matlab-v4.0-2016-10-19')
% addpath('\\ad.uillinois.edu\engr\instructional\afausti2\Desktop\BRG\GP for Machine Learning\gpml-matlab\gpml-matlab-v4.0-2016-10-19')

%% Startup GPML
startup

%% Find initial guesses for hyperparameters

mu_y = mean(y);
sig_y = std(y);

y_stats = sprintf('Mean of targets (y): %.4f\nStandard deviation of targets: %.4f',mu_y,sig_y);
disp(y_stats)

%% Set Covariance Function and Initialize Hyperparameters

% Setup priors
pd = {@priorDelta};     % Fixes hyperparameter
pg = {@priorGauss, mu_y, 1};      % Gaussian prior

% Mean function
% mean = {@meanSum,{@meanConst, @meanLinear}};
% hyp.mean = [mu_y; 1; 1; 1];
% prior.mean = {pg, [], [], []};      % Gaussian prior on offset, none for linear
mean = {@meanConst};
hyp.mean = mu_y;
prior.mean = {pg};
% 
% Covariance function
% cov = {@covSEiso};    % Squared exponential covariance function
% cov = {@covSEard};    % SE with auto relevance detection (ARD)
cov = {@covMaternard, 3};       % Matern kernel with ARD
hyp.cov = [1e-4; 1e-4; 1e-4; 0.495];
% prior.cov = {pd,pd,pd,[]};  % Fix characteristic length scale

% Likelihood function
lik = {@likGauss};        % Gaussian Likelihood Function
hyp.lik = log(0.495);   % Log of noise std deviation (sigma n)
% prior.lik = {pd};    % Fix noise std deviation hyperparameter

%% Sparse approximation for the full GP of the training set

% Subset of Regressors
% nu = floor(5e-4*length(x(:,1)));   % Number of inducing points
nu = 150;
iu = randperm(length(x(:,1)));
iu = iu(1:nu);
u = x(iu,:);
hyp.xu = u; % Optimize inducing inputs jointly with hyperparameters

% Sparse covariance function
covfuncF = {'apxSparse',cov,u};

% Sparse likelihood function
% 0.0 -> VFE, 1.0 -> FITC
inf = @(varargin) infGaussLik(varargin{:}, struct('s', 1.0));
infP = {@infPrior,inf,prior};
%% Optimize Hyperparameters
                                    
% Compute hyperparameters by minimizing negative log marginal likelihood
% w.r.t. hyperparameters
tic 
disp('Optimizing hyperparameters...')
hyp = minimize(hyp, @gp, -100, infP, mean, covfuncF, lik, xTrain, yTrain);
toc

% Print results to console
sig_n = sprintf('Inferred noise standard deviation is: %.4f', exp(hyp.lik));
disp(sig_n)
mu_inf = sprintf('Inferred Mean is: %.4f', hyp.mean);
disp(mu_inf)
l_inf = sprintf('Inferred characteristic length scale is: %.4e', hyp.cov(1));
disp(l_inf)
sig_inf = sprintf('Inferred signal standard deviation is: %.4f', hyp.cov(4));
disp(sig_inf)
nlml = gp(hyp, infP, mean, covfuncF, lik, xTrain, yTrain);
nlml_x = sprintf('Negative log probability of training data: %.6e', nlml);
disp(nlml_x)

%% Predict values for test data

tic
disp('Predicting mean and variance for test data...')
[m, s2] = gp(hyp, infP, mean, covfuncF, lik, xTrain, yTrain, xDevel);
% [m, s2] = gp(hyp, inf, mean, covfuncF, lik, xTrain, yTrain, xTest);
toc

std = s2.^(1/2);
%% Determine Mahalanobis Distance Between Predictions and Full Data

develMD = mahal([xDevel m],[x y]);
MD.max = max(develMD);
MD.min = min(develMD);
MD.mean = sum(develMD)/length(develMD);
MD.med = median(develMD);

% testMD = mahal([xTest m],[x y]);
% MD.max = max(testMD);
% MD.min = min(testMD);
% MD.mean = sum(testMD)/length(testMD);
% MD.med = median(testMD);

disp(MD)

% Qualitatively evalute of predictions by plotting MD against expected Chi
% square distribution
chi2pd = makedist('Gamma','b',2);   % Chi^2 special case of Gamma
qqplot(develMD,chi2pd)
% qqplot(testMD,chi2pd)

% Absolute difference between prediction and observation

diffPredict = abs(yDevel - m);
diff.max = max(diffPredict);
diff.min = min(diffPredict);
diff.mean = sum(diffPredict)/length(diffPredict);
diff.med = median(diffPredict);

disp(diff)
%% Plot

% Predicted mean with +/- 1 std deviation
figure(2)
plot3(x(:,1),x(:,2),y,'.')
hold on;
scatter3(xDevel(:,1),xDevel(:,2),m)
hold on;
% scatter3(xDevel(:,1),xDevel(:,2),s2)
scatter3(xDevel(:,1),xDevel(:,2),m-2*std)
hold on;
scatter3(xDevel(:,1),xDevel(:,2),m+2*std)

% Difference between predictions and observations
figure(3)
scatter3(xDevel(:,1),xDevel(:,2),diffPredict)