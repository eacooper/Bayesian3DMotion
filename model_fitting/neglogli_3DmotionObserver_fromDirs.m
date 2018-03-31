function neglogli = neglogli_3DmotionObserver_fromDirs(prs,thetahat,vstim,cInd,dd,priorType)
%
% Compute negative log-likelihood of motion direction estimates thetahat
% from true stimuli vstim.
%
% Inputs:
%        prs [m x 1] parameters: [noise variances; prior variances]
%          (# noise variances = # contrasts)
%   thetahat [N x 1] - list of subject's direction estimates
%      vstim [N x 2] - list of true x and z velocities for each stimulus
%       cInd [N x 1] - contrast index for each stimulus (integer)
%         dd [struct] - has fields:
%                       .ncontr = # contrasts
%                       .xsep = 1/2 distance between the eyes
%                       .dist = distance to the object.

minli = 1e-12;

% extract parameters
ncontrs     = dd.ncontr;                    % number of contrasts in experiment
nselist     = (prs(1:ncontrs)).^2;          % noise variance for each contrast

switch priorType
    
    case 'isoprior'
        
        vprior      = reshape((prs(ncontrs+1:end)),1,[]).^2;    % prior variance
        
    case 'flatprior'
        
        vprior = 1e16;
        
    otherwise
        
        error('invalid prior');
        
end

% repeat the prior variance for isotropic prior
vprior = [vprior,vprior];

    
% Compute likelihood variances from geometry
vnse        = nselist(cInd); % noise variance for each trial
x           = dd.xsep;
z           = dd.dist;
hh          = (x^2+z^2).^2/2;
varxzfactor = hh./[z^2,x^2];
varli       = vnse*varxzfactor;


% compute posterior for each trial
BLSwts  = bsxfun(@times, vprior, 1./bsxfun(@plus,varli,vprior));  % shrinkage factor
mupost  = vstim.*BLSwts;
vpost   = (bsxfun(@times,varli,vprior)./bsxfun(@plus,varli,vprior)).*BLSwts;

% compute negative log likelihood
neglogli = -sum(log(max(minli,bivarnormthetapdf(thetahat,mupost,vpost))));
