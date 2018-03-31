% plot raw data and model predictions for an example subject, as in Figure
% 5

clear all;
close all;
addpath(genpath('./helper_functions'));
addpath(genpath('./model_fitting'));
addpath(genpath('./equations'));

%% load data
load('./data/exp1_data.mat');
subj                    = responseData(:,1);
contrastValues          = sort(unique(responseData(:,3)),'ascend')';
presentedPaddleAngle    = responseData(:,5);
reportedPaddleAngle     = responseData(:,6);

% subject to plot
sbj         = 6;
viewDist    = 45; % 45 cm

% grab data for this subject
thisDistance    = responseData(:,2) == viewDist;
subjNums        = unique(subj(thisDistance));
thisSubj        = responseData(:,1) == sbj;

%% compute fit

% compute mean stimulus speed in this experiment for the average prediction model
[~, s ]     = cart2pol(responseData(:,7)',responseData(:,8)');
stimSpeed   = mean(s);

% fit prior and noise parameters
fitted = do_fitting(responseData(thisSubj,:),'isoprior');

sig_prior = fitted.prshat(4);
sig_noise = fitted.prshat(1:3);

% left and right eye x coordinates
xL  = -3.2; % in cm
xR  = 3.2;
a   = xR - xL; % ipd


%% visualize

% directions of stimulus
dir                 = linspace(-pi,pi,46); % from -180 to 180 in steps of 8deg, radian units (matching format of cart2pol)
dir                 = dir(1:end-1);         % remove pi/-pi redundancy
dir_stim            = mod(dir,2*pi);         % convert -pi:pi to 0:2*pi to match stimulus coordinates
dir_stimdeg         = dir_stim'*(180/pi);    % convert to degrees [0:360] 0 = rightward, increasing counter clockwise
[dir_stimdeg,IX]    = sort(dir_stimdeg);    % sort them

% convert stimulus direction/speed to vx,vz (right,away = positive)
[vx,vz] = pol2cart(dir,stimSpeed);

% sort according to direction
vx = vx(IX);
vz = vz(IX);

% range of velocities in x and z to define MAP sampling over
vxrange             = linspace(-(stimSpeed + sig_prior*3),(stimSpeed + sig_prior*3),50);
vzrange             = linspace(-(stimSpeed + sig_prior*3),(stimSpeed + sig_prior*3),50);
[vxs_all,vzs_all]   = meshgrid(vxrange, vzrange);

% what is the direction for each x/z velocity?
dirMAT = cart2pol(vxs_all,vzs_all);
dirMAT = mod(dirMAT,2*pi);
dirMAT = dirMAT*(180/pi);

% prior
mu_pr    = 0;    % mean velocity in world
var_pr   = sig_prior^2;  % variance in world

xdeg = 0;

figure; hold on;
suptitle(['prior sigma = ' num2str(fitted.prshat(4),3)] );

% for each contrast value
for p=1:length(contrastValues)
    
    % get indices
    thisCont    = responseData(:,3) == contrastValues(p);
    
    % retinal angle measurement variance
    var_b = sig_noise(p)^2;
    
    % stimulus location
    z0 = viewDist;       % z coordinate
    x0 = z0*tand(xdeg);  % x coordinate
    
    % object distance from each eye
    hL      = eq_object_distance(xL,x0,z0);
    hR      = eq_object_distance(xR,x0,z0);
    
    % sensory measurement noise covariance matrix
    M_cov_li = eq_measurement_noise_covariance_mat(xR,xL,a,x0,z0,hL,hR,var_b);
    
    % prior covariance matrix
    C_cov_pr = [var_pr 0 ; 0 var_pr];
    
    % posterior covariance matrix
    cov_post = inv(inv(M_cov_li) + inv(C_cov_pr));
    
    % shrinkage matrix
    A_shrink = cov_post/M_cov_li;
    
    % covariance of the sampling distribution of the MAP
    cov_MAP = A_shrink*M_cov_li*(A_shrink');
    
    % ensure that cov_MAP is exactly symmetric
    cov_MAP = (cov_MAP + cov_MAP.') / 2;
    
    % for each motion direction in the world
    for iw = 1:length(dir)
        
        % combine vx and vz into a vector
        vw = [vx(iw) ; vz(iw)];
        
        % compute the MAP in x and z
        mu_post(iw,:) = A_shrink*vw;
        
        % sampling distribution of the MAP
        MAPsam = mvnpdf([vxs_all(:) vzs_all(:)],mu_post(iw,:),cov_MAP);
        MAPsam = reshape(MAPsam,size(vxs_all,1),size(vxs_all,2));
        
        % compute probability density of all possible direction responses for this
        % motion direction in the world
        
        % repeat stimulus so that ksdensity is correct at the edges
        dirMAT_tmp      = [dirMAT(dirMAT > 315)-360 ; dirMAT(:) ; dirMAT(dirMAT < 45)+360];
        dir_stimdeg_tmp = [dir_stimdeg(dir_stimdeg > 315)-360 ; dir_stimdeg ; dir_stimdeg(dir_stimdeg < 45)+360];
        MAPsam_tmp      = [MAPsam(dirMAT > 315) ; MAPsam(:) ; MAPsam(dirMAT < 45)];
        
        % compute probabilty density of responses
        [dir_prob_tmp,~] = ksdensity(dirMAT_tmp, dir_stimdeg_tmp, 'Weights',MAPsam_tmp);
        dir_prob(:,iw)  = dir_prob_tmp(dir_stimdeg_tmp >= 0 & dir_stimdeg_tmp < 360);

    end
    
    % panels for figure 5
    subplot(1,3,4-p); hold on; title({['cont = ' num2str(fitted.contr_levels(p))],['noise sigma = ' num2str(fitted.prshat(p),3)]});
    ph = pcolor(dir_stimdeg,dir_stimdeg,dir_prob);
    set(ph,'EdgeColor','None')
    colormap gray
    h(1) = plot(responseData(thisSubj & thisCont,5), responseData(thisSubj & thisCont,6),'o','MarkerFaceColor', 'r','MarkerEdgeColor','r','MarkerSize', 4);
    plot([0,360],[0,360],'--k') % Diagonal reference line
    set(gca,'xtick',[0 90 180 270 360],'ytick',[0 90 180 270 360]);
    axis equal; axis([0 360 0 360]); box on;
    xlabel('Stimulus direction (deg)'); ylabel('Reported direction (deg)');

end

