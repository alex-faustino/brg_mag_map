% This script divides a MagPIE data set of size (N,10), where N is the
% number of data points collected, in to K subsets. Where K is the number
% of sets desired for cross validation.
% 
% Each subset consists of an x matrix containg 2D positions (in
% meters) and a y vector containing the selected magnetometer
% measurement (in micro Tesla) taken at that position.
% 
% Run in same directory where GT_Mag.mat is located.
% 
% Written by Alex Faustino

load('GT_Mag.mat')

platform = input('(U)gv or (S)martphone: ','s');

% Transform measurements to proper frame
x = GT_Mag(:,1:3);
mag = zeros(3,length(GT_Mag(:,1)));
theta = pi*25/180;

% Walking orientation
RAstar_A = [1          0           0;
            0 cos(theta) -sin(theta);
            0 sin(theta)  cos(theta)];
        
% UGV orientation
RA_T = [1  0  0;
        0  0  1; 
        0 -1  0];
    
for i = 1:length(GT_Mag(:,1))
    DCM = quat2dcm([GT_Mag(i,7), GT_Mag(i,4:6)]);
    switch platform
        case {'S','s'}
            mag(:,i) = DCM*RAstar_A*GT_Mag(i,8:10)';
        case {'U','u'}
            mag(:,i) = DCM*RA_T*GT_Mag(i,8:10)';
        otherwise
            error('Invalid platform')
    end
end

choice = input('Choose Map Type\n(1 = Norm, 2 = x-direction, 3 = y-direction, 4 = z-direction): ');
if choice == 1
    % Norm Map
    y = sqrt(sum(GT_Mag(:,8:10).^2,2));
    yType = 'norm';
    yFileName = sprintf('y_%s.mat',yType);
    save(yFileName, 'y')
elseif choice == 2
    % X-axis Map
    y = mag(1,:)';
    yType = 'xdir';
    yFileName = sprintf('y_%s.mat',yType);
    save(yFileName, 'y')
elseif choice == 3
    % Y-axis Map
    y = mag(2,:)';
    yType = 'ydir';
    yFileName = sprintf('y_%s.mat',yType);
    save(yFileName, 'y')
elseif choice == 4
    % Z-axis Map
    y = mag(3,:)';
    yType = 'zdir';
    yFileName = sprintf('y_%s.mat',yType);
    save(yFileName, 'y')
else
    error('Invalid Input');
end

numCV = input('Choose number of cross validation sets\n(recommended 3-10): ');

% Initialize data and subset plots
subplot(floor(numCV/2),floor(numCV/2)+1,1)
plot3(x(:,1),x(:,2),y,'.')
xlabel('x (m)')
ylabel('y (m)')
zlabel('meas (/mu T)')
title('Whole Data Set')
grid on;

% Create and save subsets of data
subdata = randperm(length(x(:,1)));
xTrain = cell(1,numCV);
yTrain = cell(1,numCV);
numPerSet = floor(length(x(:,1))/numCV);

for i=1:numCV
    trainData = subdata((i-1)*numPerSet+1:i*numPerSet);
    xTemp = x(trainData,:);
    yTemp = y(trainData);
    xTrain{1,i} = xTemp;
    yTrain{1,i} = yTemp;
    
    % Plot subset
    setTitle = sprintf('Training Data Set %d',i);
    subplot(floor(numCV/2),floor(numCV/2)+1,i+1)
    plot3(xTemp(:,1),xTemp(:,2),yTemp,'.')
    xlabel('x (m)')
    ylabel('y (m)')
    zlabel('meas (/mu T)')
    title(setTitle)
    grid on;
end

% Save subsets
xName = sprintf('xTrain_%s.mat',yType);
yName = sprintf('yTrain_%s.mat',yType);
save(xName, 'xTrain')
save(yName, 'yTrain')

