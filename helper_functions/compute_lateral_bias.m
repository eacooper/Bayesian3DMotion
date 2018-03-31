function [meanSignedError, settingError] = compute_lateral_bias(dir,hat_dir)
%
% calculate lateral bias
% input in degrees, output in radians


dir_radians = (pi/180).*dir;
hat_dir_radians = (pi/180).*hat_dir;

for traj=1:length(dir)
    
        % because of the way circ_dist signs errors, we need to ensure that negative 
        % values correspond to lateral bias and postive values correspond to medial bias
        % so away-right and toward-left errors are sign inverted
        if dir_radians(traj) < 0
            error('Unexpected input');
    
        elseif dir_radians(traj) < (pi/2) % if the presented angle is away and rightward ...
            settingError(traj) = -circ_dist(dir_radians(traj), hat_dir_radians(traj));
    
        elseif dir_radians(traj) < pi % if the presented angle is away and leftward ...
            settingError(traj) = circ_dist(dir_radians(traj), hat_dir_radians(traj));
    
        elseif dir_radians(traj) < (3*pi/2) % if the presented angle is toward and leftward ...
            settingError(traj) = -circ_dist(dir_radians(traj), hat_dir_radians(traj));
    
        elseif dir_radians(traj) < 2*pi % if the presented angle is toward and rightward ...
            settingError(traj) = circ_dist(dir_radians(traj), hat_dir_radians(traj));
    
        else
            error('Unexpected input');
    
        end
    
    
end


meanSignedError = circ_mean(settingError'); % combine over trials
