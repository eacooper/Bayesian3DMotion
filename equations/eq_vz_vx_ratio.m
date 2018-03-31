function vz_vx_ratio = eq_vz_vx_ratio(xL,xR,x0,z0,hL,hR)
%
% xR/L = x coordinate of eye
% x0 = x coordinate of object
% z0 = z coordinate of object
% hL/hR = object distance to each eye

vz_vx_ratio = (z0.^2) .* ( ( ( (hL.^4) + (hR.^4) ) ./ ( (x0-xR).^2 .* (hL.^4) + (x0-xL).^2 .* (hR.^4) ) ) );
