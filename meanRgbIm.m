function [acctualColorRgb] = meanRgbIm(rgbImage)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rgbChannel(:,:,1) = rgbImage(:, :, 1);
rgbChannel(:,:,2) = rgbImage(:, :, 2);
rgbChannel(:,:,3) = rgbImage(:, :, 3);
 
% Get means
meanR = mean(rgbChannel(:,:,1));
meanG = mean(rgbChannel(:,:,2));
meanB = mean(rgbChannel(:,:,3));

%Find largest
if(mean(meanR) > mean(meanG) && mean(meanB))    
    acctualColorRgb(:,:,1) = max(meanR);
    acctualColorRgb(:,:,2) = min(meanG);
    acctualColorRgb(:,:,3) = min(meanB);
end
if(mean(meanG) > mean(meanR) && mean(meanB))
    acctualColorRgb(:,:,1) = min(meanR);
    acctualColorRgb(:,:,2) = max(meanG);
    acctualColorRgb(:,:,3) = min(meanB);
end
if(mean(meanB) > mean(meanR) && mean(meanG)) 
    acctualColorRgb(:,:,1) = min(meanR);
    acctualColorRgb(:,:,2) = min(meanG);
    acctualColorRgb(:,:,3) = max(meanB);   
end

end

