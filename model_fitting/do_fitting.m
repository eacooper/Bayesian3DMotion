function fitted = do_fitting(responseData,priorType)
%
% fit prior and noise parameters (responseData should contain data matrix
% for one subject, one distance, all contrasts -- assumes 3 contrast levels)
%
% output structured fitted:
%
%       init and final loss
%       contr_levels = michelson contrast for each condition
%       prshat = noise estimate for each contr level + prior

% initialize parameters of the prior and likelihood
signse0 = [.01; .01; .01];  % noise in single-eye velocity estimates for each contrast (7.5, 15, 60)

switch priorType
    
    case 'isoprior'
        
        sigpri0 = 5;                % prior std in x and z (isotropic)
        
    case 'flatprior'
        
        sigpri0 = 1e16;
        
    otherwise
        
        error('invalid prior type');
end

% Set up fitting
prs0        = [ signse0 ; sigpri0 ]; % initial parameters
vstim       = [responseData(:,7) , responseData(:,8)];  % true stimulus velocities in x and z

% create vector labeling which contrast was shown on which trial
contrs                  = responseData(:,3);
fitted.contr_levels     = unique(contrs);

% convert contrast values to categorical labels 1, 2, 3...
contrs(contrs == 1 | contrs == 0.6) = 3;
contrs(contrs == 0.15) = 2;
contrs(contrs == 0.075) = 1;

% build up dd structure for fitting
dd.ncontr = 3; % number of different contrasts
dd.xsep   = 3.2; % 1/2 ipd

% viewing distance
dist = unique(responseData(:,2));

if length(dist) < 1
    error('trying to fit more than one viewing distance at once');
else
    dd.dist = dist;
end

% grab response direction data 0 == rightward, CCW to 360
dd.ahat = responseData(:,6);

% convert to radians
dd.ahat = dd.ahat*(pi/180);

% Make anonymous function for negative log-likelihood
floss = @(prs)(neglogli_3DmotionObserver_fromDirs(prs,dd.ahat,vstim,contrs,dd,priorType));

% Evaluate loss at initial parameters
fitted.init_loss = floss(prs0);

%% run optimization

% Set the optimization parameters
opts    = optimset('display','iter','tolx',1e-13,'maxfunevals',1e5,'largescale', 'off');
prshat  = fminunc(floss,prs0,opts);

fitted.prshat  = abs(prshat); % force all params to be positive

%% get negloglikelihood of data given prshat estimates
fitted.final_loss = neglogli_3DmotionObserver_fromDirs(prshat,dd.ahat,vstim,contrs,dd,priorType);








