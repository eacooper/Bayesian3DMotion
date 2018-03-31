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

load('./data/exp1_data.mat');
subj                    = responseData(:,1);                            % subject indices
vDist                   = sort(unique(responseData(:,2)),'descend');    % unique viewing distances
contrastValues          = sort(unique(responseData(:,3)),'ascend')';    % unique contrast values
presentedPaddleAngle    = responseData(:,5);                            
reportedPaddleAngle     = responseData(:,6);


% for each viewing distance
for d = 1:length(vDist)
    
    % initialize outcome measures
    subMeanSignedError = [];
    sub_z_rev = [];
    sub_x_rev = [];
   
    % for each contrast value
    for p=1:length(contrastValues)
        
        % grab the data we want
        theseData = find(responseData(:,2) == vDist(d) & responseData(:,3) == contrastValues(p));

        % compute lateral bias & percent direction confusions for each subject (takes in deg, returns radians)
        
        subjsDist = unique(subj(theseData));
        
        for s = 1 : numel(subjsDist)
            
            % indices for this subject
            subjData = find(subj == subjsDist(s));
            subjData = intersect(subjData,theseData);
            
            % compute mean signed error (lateral bias)
            % Will convert from deg to rad
            [subMeanSignedError(s,p), settingError] = compute_lateral_bias(presentedPaddleAngle(subjData),reportedPaddleAngle(subjData)); 
            
            % compute percent direction confusions
            [sub_z_rev(s, p), sub_x_rev(s, p)] = compute_direction_confusions( presentedPaddleAngle(subjData), reportedPaddleAngle(subjData) ); 
            
        end
    end
    
    % calculate lateral bias  & direction confusions across subjects
    meanSignedError(d,:) = mean(subMeanSignedError); % group
    semSignedError(d,:) = std(subMeanSignedError)./sqrt(numel(subjsDist));
    
    mean_zrev(d,:) = mean(sub_z_rev);
    sem_zrev(d,:) = std(sub_z_rev)./sqrt(numel(subjsDist));
    
    mean_xrev(d,:) = mean(sub_x_rev);
    sem_xrev(d,:) = std(sub_x_rev)./sqrt(numel(subjsDist));

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lateral bias and direction confusion plots

% plot lateral bias - Fig 6
plot_lateral_bias(meanSignedError, semSignedError,1);

% plot direction confusions - Fig 7
plot_direction_confusion(mean_zrev,sem_zrev,mean_xrev,sem_xrev,1);
