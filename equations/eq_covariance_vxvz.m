function cova = eq_covariance_vxvz(xR,xL,a,x0,z0,hL,hR,var_b)
%
% xR/L = x coordinate of eye
% a = ipd
% x0 = x coordinate of object
% z0 = z coordinate of object
% hL/hR = object distance to each eye
% var_b = retinal angle variance

cova = ( 1./( (z0)*(a.^2) ) ) .* ( (x0-xR) .* (hL.^4) + (x0-xL) .* (hR.^4) ) .* var_b;