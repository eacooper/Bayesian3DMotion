% calculate and illustrate noise covariance and uncertainty ratios for x/z
% motion, as in Figure 3

clear all;
close all;
addpath(genpath('./equations'));

%% SET UP

% left and right eye x coordinates
xL  = -3.2;
xR  = 3.2;
a   = xR - xL;

% object x/z coordinates in cm (left handed coordinate system, origin at cyclopean eye)
xrange  = -50:0.1:50;
zrange  = 0:0.1:100;
[xs,zs] = meshgrid(xrange, zrange);

% object distance from each eye
hL      = eq_object_distance(xL,xs,zs);
hR      = eq_object_distance(xR,xs,zs);

% retinal angle variance
var_b   = 0.01;

%% Uncertainy in vx and vz as a function of location

% vx and vz variance (n^2)
var_vx = eq_variance_vx(xR,xL,a,xs,zs,hL,hR,var_b);
var_vz = eq_variance_vz(a,hL,hR,var_b);

% uncertainty
unc_vx = sqrt(var_vx);
unc_vz = sqrt(var_vz);

% ratio of variance (n^2) in z to x equation
vz_vx_ratio = eq_vz_vx_ratio(xL,xR,xs,zs,hL,hR);

vz_vx_unc_ratio = sqrt(vz_vx_ratio);


%% compute and plot covariance ellipses

% unit circle
theta   = 0:360;
r       = 1;
xi      = r*cosd(theta);
yi      = r*sind(theta);

% for each location in space
for xpos = xrange(1:50:end)
    for zpos = zrange(101:100:end)
        
        hL1      = eq_object_distance(xL,xpos,zpos);
        hR1      = eq_object_distance(xR,xpos,zpos);
        
        % sensory measurement noise covariance matrix
        cov_mat = eq_measurement_noise_covariance_mat(xR,xL,a,xpos,zpos,hL1,hR1,1);
        
        figure(1); hold on;
        plotellipse([xpos;zpos], cov_mat, 0.002, 'k-', 'linewidth', 1);
        axis equal image; box on;
    end
end


% covariance ellipses
figure(1); title('noise covariance');
xlabel('x0 (cm)'); ylabel('z0 (cm)');

%% plot uncertainty in x and z
figure(2); hold on;

subplot(2,1,1); hold on; title('uncertainty in x');
ch1 = contourf(xrange,zrange,log10(unc_vx),linspace(-4/2,7/2,20),'linecolor','none');
xlabel('x0 (cm)'); ylabel('z0 (cm)');
axis equal image;
colormap(gray(512));
hcb = colorbar;
caxis([-3/2 6/2]);
set(hcb,'YTick',[]);
ylabel(hcb,'log(n)');

subplot(2,1,2); hold on; title('uncertainty in z');
ch2 = contourf(xrange,zrange,log10(unc_vz),linspace(-4/2,7/2,20),'linecolor','none');
xlabel('x0 (cm)'); ylabel('z0 (cm)');
axis equal image;
colormap(gray(512));
hcb2 = colorbar;
caxis([-3/2 6/2]);
set(hcb2,'YTick',[]);
ylabel(hcb2,'log(n)');


% ratio plot
figure(3); hold on; title('ratio');
ch3 = contourf(xrange,zrange,log10(vz_vx_unc_ratio),20,'linecolor','none');
caxis([-log10(max(abs(vz_vx_unc_ratio(:)))) log10(max(abs(vz_vx_unc_ratio(:))))]);
caxis([-3/2 3/2]);
caxis([-2 2]);
axis equal image;
hcb3 = colorbar;
set(hcb3,'YTick',[-2:1:2])
ylabel(hcb3,'log(nz/nx)');
