% This script matches Ground Truth locations and orientations to a
% corresponding magnetometer measurement
%   Written by: David Hanley

cd 'Training'
Trials = dir('Trial*');
numTrials = length(Trials);

GT_Mag = zeros(1,10);
for k=1:numTrials
    newTrainPath = sprintf('Trial %d',k);
    cd(newTrainPath)
    
    trialFiles = dir('*.txt');
    if (length(trialFiles) >= 5)
        GT = dlmread(trialFiles(3).name,'\t',1,0);
        Mag = dlmread(trialFiles(5).name,'\t',1,0);
    end
    Time = Mag(:,1);
    Positions = GT(:,2:4);
    Orientations = GT(:,5:8);
    
    GT_Magtemp = zeros(length(Time),10);
    addpath('../..')
    for i = 1:length(Time)
        index = find_closest_index( GT(:,1), Time(i) );
        GT_Magtemp(i,:) = [Positions(index,:), Orientations(index,:), Mag(i,2:4)];
    end
    GT_Mag = [GT_Mag; GT_Magtemp];
    
    cd ..
end

GT_Mag(1,:) = [];

cd ..

save('GT_Mag.mat','GT_Mag')

figure(1)
plot3(GT_Mag(:,1),GT_Mag(:,2),sqrt(sum(GT_Mag(:,8:10).^2,2)),'.')
xlabel('x-pos (m)')
ylabel('y-pos (m)')
zlabel('Norm of Mag (\muT)')
grid on;