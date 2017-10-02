function [x, y, xTrain, yTrain] = LoadData(initOptions)
% Takes initOptions object from main mapping script and loads the desired
% data to the Workspace.
% Written by Alex Faustino

switch initOptions.env
    case {'C', 'c'}
        switch initOptions.plat
            case {'U', 'u'}
                addpath('data_set\csl\ugv')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('GT_Mag.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('GT_Mag.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('GT_Mag.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('GT_Mag.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            case {'S', 's'}
                addpath('data_set\csl\wlk')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('GT_Mag.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('GT_Mag.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('GT_Mag.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('GT_Mag.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            otherwise
                error('Invalid platform type')
        end
    case {'L', 'l'}
        switch initOptions.plat
            case {'U', 'u'}
                addpath('data_set\loomis\ugv')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('GT_Mag.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('GT_Mag.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('GT_Mag.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('GT_Mag.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            case {'S', 's'}
                addpath('data_set\loomis\wlk')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('GT_Mag.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('GT_Mag.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('GT_Mag.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('GT_Mag.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            otherwise
                error('Invalid platform type')
        end
    case {'T', 't'}
        switch initOptions.plat
            case {'U', 'u'}
                addpath('data_set\talbot\ugv')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('GT_Mag.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('GT_Mag.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('GT_Mag.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('GT_Mag.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            case {'S', 's'}
                addpath('data_set\talbot\wlk')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('GT_Mag.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('GT_Mag.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('GT_Mag.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('GT_Mag.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = GT_Mag(:,1:3); y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            otherwise
                error('Invalid platform type')
        end
    otherwise
        error('Invalid environment')
end

end

