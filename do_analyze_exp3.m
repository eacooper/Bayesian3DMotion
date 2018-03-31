% load and plot summaries of data from Experiment 3

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

load('./data/exp3_data.mat');
subj                    = responseData(:,1);                            % subject indices
vDist                   = sort(unique(responseData(:,2)),'descend');    % unique viewing distances
ecc                     = unique(responseData(:,4));
presentedPaddleAngle    = responseData(:,5);
reportedPaddleAngle     = responseData(:,6);

% number of subjects
nSubjects = length(unique(subj));


% for each eccentricity
for e = 1:length(ecc)
    
    % grab the data we want
    theseData = find(responseData(:,4) == ecc(e));
    
    for s = 1:nSubjects
        
        % indices for this subject
        subjData = find(subj == s);
        subjData = intersect(subjData,theseData);
        
        % compute lateral bias & percent direction confusions for each subject (takes in deg, returns radians)
        subMeanSignedError(s,e) = compute_lateral_bias(presentedPaddleAngle(subjData),reportedPaddleAngle(subjData));
        
        % compute percent direction confusions
        [sub_z_rev(s, e), sub_x_rev(s, e)] = compute_direction_confusions( presentedPaddleAngle(subjData), reportedPaddleAngle(subjData) );
        
    end
    
end

% calculate lateral bias  & direction confusions across subjects

% center (0deg)
meanSignedError(1) = mean(subMeanSignedError(:,2)); % group
semSignedError(1) = std(subMeanSignedError(:,2))./sqrt(nSubjects);

mean_zrev(1) = mean(sub_z_rev(:,2));
sem_zrev(1) = std(sub_z_rev(:,2))./sqrt(nSubjects);

mean_xrev(1) = mean(sub_x_rev(:,2));
sem_xrev(1) = std(sub_x_rev(:,2))./sqrt(nSubjects);

% periphery (+/-20deg)
meanSignedError(2) = mean([subMeanSignedError(:,1); subMeanSignedError(:,3)]); % group
semSignedError(2) = std([subMeanSignedError(:,1); subMeanSignedError(:,3)])./sqrt(nSubjects);

mean_zrev(2) = mean([sub_z_rev(:,1); sub_z_rev(:,3)]);
sem_zrev(2) = std([sub_z_rev(:,1); sub_z_rev(:,3)])./sqrt(nSubjects);

mean_xrev(2) = mean([sub_x_rev(:,1); sub_x_rev(:,3)]);
sem_xrev(2) = std([sub_x_rev(:,1); sub_x_rev(:,3)])./sqrt(nSubjects);

% average lateral bias and direction confusion plots
plot_exp3(meanSignedError,semSignedError,mean_zrev,sem_zrev,mean_xrev,sem_xrev);
