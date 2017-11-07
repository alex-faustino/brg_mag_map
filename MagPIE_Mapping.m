% This script is a modified copy of the original Mapping_Baseline script
% used for the MagPIE IPIN paper; it computes the map of the norm of the
% magnetometer measurements from training data using the SKI method KISS-GP
% (Wilson et al. 2015). It displays scatter plots of each validation set
% with a 95% confidence interval plotted over the training targets.
% Written by: Alex Faustino

initOptions.env = input('Select mapping environment. (C)SL first floor, (L)oomis Lab first floor, or (T)albot Lab third floor: ','s');
initOptions.plat = input('Select platform. (U)GV or (S)marthphone: ','s');
initOptions.meas = 'n'; %input('Select type of magnetometer measurement. (N)orm, (x) component, (y) component, or (z) component: ','s');

% Number of inducing points
nu = input('Number of inducing points: ');
    
[x, y, xTrainFull, yTrainFull] = LoadData(initOptions);

% Absolute path for GPML matlab directory
addpath('\\ad.uillinois.edu\engr\instructional\afausti2\Desktop\BRG\GP for Machine Learning\gpml-matlab\gpml-matlab-v4.0-2016-10-19')

% Startup GPML
startup

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cross validation sets
numCVSets = numel(xTrainFull);

% Empty metric value vectors
runTimes = zeros(numCVSets,1);
meanRelErr = zeros(numCVSets,1);
meanAbsErr = zeros(numCVSets,1);
metricVals = zeros(numCVSets,1);
meanVar = zeros(numCVSets,1);

for l=1:numCVSets
    xDevel = xTrainFull{1,l};
    yDevel = yTrainFull{1,l};
    
    [xDevel,iaDevel,icDevel] = unique(xDevel,'rows');
    yDevel = yDevel(iaDevel);
    
    firstTrainSet = true;
    for m=1:numCVSets
        if (m~=l)
            if (firstTrainSet)
                xTrain = xTrainFull{1,m};
                yTrain = yTrainFull{1,m};
                firstTrainSet = false;
            else
                xTrain = [xTrain; xTrainFull{1,m}];
                yTrain = [yTrain; yTrainFull{1,m}];
            end
        end
    end
    
    % Remove duplicate locations
    [xTrain,iaTrain,icTrain] = unique(xTrain,'rows');
    yTrain = yTrain(iaTrain);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Set Covariance Function and Initialize Hyperparameters

    % Use targets to determine initial hyperparameter values
    mu_y = sum(y)/length(y);
    sig_y = std(y);

    y_stats = sprintf('Mean of targets (y): %.4f\nStandard deviation of targets: %.4f',mu_y,sig_y);
    disp(y_stats)

    % Setup priors
    pd = {@priorDelta};     % Fixes hyperparameter
    pg = {@priorGauss, mu_y, sig_y^2};      % Gaussian prior

    % Mean function
    mean = {@meanConst};
    hyp.mean = mu_y;
    prior.mean = {pg};

    % Covariance function
    cov = {{@covSEard},{@covSEard}};    % SE with auto relevance detection (ARD)

    % Likelihood function
    lik = {@likGauss};        % Gaussian Likelihood Function

    % Hyperparameters for cov and lik
    hyp.lik = log(0.495);   % Log of noise std deviation (sigma n)
    hyp.cov = log([1e-1; 1e-1; 1e-1; sig_y]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Sparse approximation for the full GP of the training set
    
    equalSourcePointError = true;
    while(equalSourcePointError)
        try
            % Subset of Regressors
            iu = randperm(length(xTrain(:,1)));
            iu = iu(1:nu);
            u = x(iu,:);
            hyp.xu = u; % Optimize inducing inputs jointly with hyperparamters
            xg = {u(:,1), u(:,2)};    % Plain Kronecker structure

            errmsg = CheckEqSourcePt(x, xg);

            if isempty(errmsg)
                equalSourcePointError = false;
            else
                error(errmsg)
            end
        catch ME
            disp('Equal source point error. Attempting new subset...')
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Optimize Hyperparameters 

    % Kernel approximation
    covg = {'apxGrid',cov,xg};
    opt.cg_maxit = 500;
    opt.cg_tol = 1e-6;
    opt.ndcovs = 25;    % ask for sampling-based (exact) derivatives
    opt.s = 1.0;        % 0.0 -> VFE, 1.0 -> FITC

    % Inference shortcut
    inf = @(varargin) infGrid(varargin{:}, opt);
    infP = {@infPrior,inf,prior};

    % Construct a grid covering the training data
    xg = apxGrid('create',xTrain(:,1:2),true,[nu nu]);

    % Compute hyperparameters by minimizing negative log marginal likelihood
    % w.r.t. hyperparameters
    tic 
    disp('Optimizing hyperparameters...')
    hyp = minimize(hyp, @gp, -100, infP, mean, covg, lik, xTrain(:,1:2), yTrain);

    % Print results to console
    sig_n = sprintf('Inferred noise standard deviation is: %.4f', exp(hyp.lik));
    disp(sig_n)
    mu_inf = sprintf('Inferred Mean is: %.4f', hyp.mean);
    disp(mu_inf)
    l_inf = sprintf('Inferred characteristic length scale is: %.4e', exp(hyp.cov(1)));
    disp(l_inf)
    sig_inf = sprintf('Inferred signal standard deviation is: %.4f', exp(hyp.cov(2)));
    disp(sig_inf)
    nlml = gp(hyp, infP, mean, covg, lik, xTrain(:,1:2), yTrain);
    nlml_x = sprintf('Negative log probability of training data: %.6e', nlml);
    disp(nlml_x)
    toc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Predict values for test data

    % Run inference
    disp('Running inference...')
    tic 
    [post,nlZ,dnlZ] = infGrid(hyp, mean, covg, lik, xTrain(:,1:2), yTrain, opt);
    toc

    % Construct grid of test data
    [xs,ns] = apxGrid('expand',xDevel(:,1:2));

    tic
    disp('Predicting mean and variance for test data...')
    [fmu,fs2,ymu,ys2] = post.predict(xs);
    runtime = toc;
    disp(runtime)
    
    runTimes(l,1) = runtime;

    % Get standard deviation from variance
    meanVar(l,1) = sum(fs2)/length(fs2);
    fs = fs2.^(1/2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Relative error between prediction and observation
    relDiffPredict = abs((yDevel - ymu)./yDevel);
    mre.max = max(relDiffPredict);
    mre.min = min(relDiffPredict);
    mre.mean = sum(relDiffPredict)/length(relDiffPredict);
    mre.med = median(relDiffPredict);

    disp(mre)

    meanRelErr(l,1) = mre.mean;

    % Absolute error between prediction and observation
    absDiffPredict = abs(yDevel - ymu);
    mae.max = max(absDiffPredict);
    mae.min = min(absDiffPredict);
    mae.mean = sum(absDiffPredict)/length(absDiffPredict);
    mae.med = median(absDiffPredict);

    disp(mae)

    meanAbsErr(l,1) = mae.mean;

    % Find number of data values outside of 95% of predicted probability mass,
    % mean +/- 2 standard deviations
    numNotIn95 = 0;

    for i=1:length(yDevel)
        if (yDevel(i,1) > (ymu(i,1) + 2*fs(i,1)) || yDevel(i,1) < (ymu(i,1) - 2*fs(i,1)))
            numNotIn95 = numNotIn95 + 1;
        end
    end

    metricVals(l,1) = numNotIn95/length(yDevel);

    % Predicted mean with +/- 2 std deviation
    figure(l)
    plot3(x(:,1),x(:,2),y,'.')
    hold on;
    scatter3(xDevel(:,1),xDevel(:,2),ymu)
    hold on;
    % scatter3(xDevel(:,1),xDevel(:,2),s2)
    scatter3(xDevel(:,1),xDevel(:,2),ymu-2*fs)
    hold on;
    scatter3(xDevel(:,1),xDevel(:,2),ymu+2*fs)

end
% End CV loop
