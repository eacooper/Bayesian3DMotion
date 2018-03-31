function [z_rev, x_rev] = compute_direction_confusions(presentedPaddleAngle, reportedPaddleAngle)
%
% calculate proportion of towards/away and left/right direction confusions

% initialize at zero
correctDirection        = 0;
correctDirectionLateral = 0;

% for each trial
for tr=1:length(reportedPaddleAngle)
    
    % towards/away
    if reportedPaddleAngle(tr)<180 && presentedPaddleAngle(tr)<180  % both are receding
        correctDirection = correctDirection + 1;
    elseif reportedPaddleAngle(tr)>180 && presentedPaddleAngle(tr)>180 % both are approaching
        correctDirection = correctDirection + 1;
    else
        correctDirection = correctDirection;
    end
    
    % left/right
    if (reportedPaddleAngle(tr)>90 && reportedPaddleAngle(tr)<270) && ...
            (presentedPaddleAngle(tr)>90 && presentedPaddleAngle(tr)<270)  % both are left
        correctDirectionLateral = correctDirectionLateral + 1;
    elseif (reportedPaddleAngle(tr)<90 || reportedPaddleAngle(tr)>270) && ...
            (presentedPaddleAngle(tr)<90 || presentedPaddleAngle(tr)>270)  % both are right
        correctDirectionLateral = correctDirectionLateral + 1;
    else
        correctDirectionLateral = correctDirectionLateral;
    end
end

% how many were incorrect?
z_rev = 1 - (correctDirection / length(reportedPaddleAngle));
x_rev = 1 - (correctDirectionLateral / length(reportedPaddleAngle));