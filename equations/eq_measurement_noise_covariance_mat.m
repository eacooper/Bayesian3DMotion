function cov_mat = eq_measurement_noise_covariance_mat(xR,xL,a,xpos,zpos,hL,hR,var_b)
%
% noise covariance of sensory measurements 
% [x xz ;
%  xz z]
%

cov_mat = [eq_variance_vx(xR,xL,a,xpos,zpos,hL,hR,var_b) eq_covariance_vxvz(xR,xL,a,xpos,zpos,hL,hR,var_b);...
    eq_covariance_vxvz(xR,xL,a,xpos,zpos,hL,hR,var_b) eq_variance_vz(a,hL,hR,var_b)];