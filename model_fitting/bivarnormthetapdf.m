function L = bivarnormthetapdf(thetahat,mus,vars)
% L = bivarnormthetapdf(thetahat,mus,vars)
% 
% Computes the marginal pdf of the angle ("thetahat") under a bivariate
% normal distribution with mean mus = [mux muz]; and marginal variances
% vars = [varx, varz].
%
% INPUTS:
%   thetahat [N x 1] - list of angles
%         mus [N x 2] - mean in x and z
%       vars [2 x 1] - variance in x and z 
%
% OUTPUTS:
%         L [1 x 1] - negative log-likelihood for each datapoint
%
% NOTE: turns out this pdf has a name "Offset Normal Distribution". This
% version is now out of date.

mux = mus(:,1);
muz = mus(:,2);
varx = vars(:,1);
varz = vars(:,2);

A = cos(thetahat).^2./varx + sin(thetahat).^2./varz;
B = cos(thetahat).*mux./varx + sin(thetahat).*muz./varz;
C = mux.^2./varx + muz.^2./varz;

ptm1    = B./(A.*sqrt(2*pi*varx.*varz.*A)).*normcdf(B./sqrt(A)).*exp(.5*(B.^2./A-C));
ptm2    = 1./(A*2*pi.*sqrt(varx.*varz)).*exp(-.5*C);
L       = ptm1+ptm2;

