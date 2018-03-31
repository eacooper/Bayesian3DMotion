% load and plot summaries of data from Experiment 1

clear all;
close all;
addpath(genpath('./helper_functions'));

% load data
% 1.  subject number
% 2.  viewing distance in cm
% 3.  target contrast (Michelson)
% 4.  stimulus eccentricity in degrees (left is negative)
% 5.  stimulus direction (deg) - 0 == rightward, CCW to 360
% 6.  response direction (deg) - 0 == rightward, CCW to 360
% 7.  stimulus speed in x (cm/s leftward is negative)
% 8.  stimulus speed in z (cm/s towards is negative)

load('./data/exp2_data.mat');
subj                    = responseData(:,1);                            % subject indices
vDist                   = sort(unique(responseData(:,2)),'descend');    % unique viewing distances
contrastValues          = sort(unique(responseData(:,3)),'ascend')';    % unique contrast values
presentedPaddleAngle    = responseData(:,5);
reportedPaddleAngle     = responseData(:,6);


% for each subject
for s = 1:3
    
    % for each contrast value
    for p=1:length(contrastValues)
        
        % grab the data we want
        theseData = find(subj == s & responseData(:,3) == contrastValues(p));
        
        % compute mean signed error for each subject (takes in deg, returns radians)
        [subMeanSignedError(s, p), settingError] = compute_lateral_bias(presentedPaddleAngle(theseData), reportedPaddleAngle(theseData));
        
        % compute percent direction confusions
        [sub_z_rev(s, p), sub_x_rev(s, p)] = compute_direction_confusions( presentedPaddleAngle(theseData), reportedPaddleAngle(theseData) );
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% average lateral bias and direction confusion plots

% calculate lateral bias  & direction confusions across subjects
mBias = mean(subMeanSignedError); % group
semBias = std(subMeanSignedError)./sqrt(3);

mZrev = mean(sub_z_rev); 
semZrev = std(sub_z_rev)./sqrt(3);

mXrev = mean(sub_x_rev); 
semXrev = std(sub_x_rev)./sqrt(3);

% Plot lateral bias
plot_lateral_bias(mBias,semBias,1);

% plot direction confusions
plot_direction_confusion(mZrev,semZrev,mXrev,semXrev,1);
