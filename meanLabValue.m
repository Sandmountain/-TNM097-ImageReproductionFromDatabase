function [meanValue] = meanLabValue(LabPixels4x3)
%   Function to calculate the mean lab_value for a 2x2 pixel area
%   
meanValue = [mean(LabPixels4x3(:,1)) , mean(LabPixels4x3(:,2)) , mean(LabPixels4x3(:,3))];
end

