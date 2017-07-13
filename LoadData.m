function [x, y, xTrain, yTrain] = LoadData(initOptions)
% Takes initOptions object from main mapping script and loads the desired
% data to the Workspace.
% Written by Alex Faustino

switch initOptions.env
    case {'C', 'c'}
        switch initOptions.plat
            case {'U', 'u'}
                addpath('Data Set\CSL First Floor\UGV')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('x.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('x.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('x.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('x.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            case {'S', 's'}
                addpath('Data Set\CSL First Floor\WLK')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('x.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('x.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('x.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('x.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = x; y = y; 
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
                addpath('Data Set\Loomis First Floor\UGV')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('x.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('x.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('x.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('x.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            case {'S', 's'}
                addpath('Data Set\Loomis First Floor\WLK')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('x.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('x.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('x.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('x.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = x; y = y; 
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
                addpath('Data Set\Talbot Third Floor\UGV')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('x.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('x.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('x.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('x.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    otherwise
                        error('Invalid measurement type')
                end
            case {'S', 's'}
                addpath('Data Set\Talbot Third Floor\WLK')
                switch initOptions.meas
                    case {'N', 'n'}
                        load('x.mat'), load('y_norm.mat'), 
                        load('xTrain_norm.mat'), load('yTrain_norm.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'X', 'x'}
                        load('x.mat'), load('y_xdir.mat'), 
                        load('xTrain_xdir.mat'), load('yTrain_xdir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Y', 'y'}
                        load('x.mat'), load('y_ydir.mat'), 
                        load('xTrain_ydir.mat'), load('yTrain_ydir.mat')
                        x = x; y = y; 
                        xTrain = xTrain; yTrain = yTrain;
                    case {'Z', 'z'}
                        load('x.mat'), load('y_zdir.mat'), 
                        load('xTrain_zdir.mat'), load('yTrain_zdir.mat')
                        x = x; y = y; 
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

