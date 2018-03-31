function var_vz = eq_variance_vz(a,hL,hR,var_b)
%
% a = ipd
% hL/hR = object distance to each eye
% var_b = retinal angle variance

var_vz = ( 1./(a.^2) ) .* ( (hL.^4) + (hR.^4) ) .* var_b;