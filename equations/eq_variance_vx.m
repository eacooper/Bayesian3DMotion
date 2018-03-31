function var_vx = eq_variance_vx(xR,xL,a,x0,z0,hL,hR,var_b)
%
% xR/L = x coordinate of eye
% a = ipd
% x0 = x coordinate of object
% z0 = z coordinate of object
% hL/hR = object distance to each eye
% var_b = retinal angle variance

var_vx = ( 1./( (z0.^2)*(a.^2) ) ) .* ( (x0-xR).^2 .* (hL.^4) + (x0-xL).^2 .* (hR.^4) ) .* var_b;