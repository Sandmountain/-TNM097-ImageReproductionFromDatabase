function [optimalVal,index] = deltaElab(OrignalImageUnresized,ImageDataBase)
% Function that calculates the DeltaE value between two LAB values.
%   Detailed explanation goes here

scaleFactor = size(ImageDataBase,1) / size(OrignalImageUnresized,1);

OrignalImage(:,:,1) = imresize(OrignalImageUnresized(:,:,1),scaleFactor);
OrignalImage(:,:,2) = imresize(OrignalImageUnresized(:,:,2),scaleFactor);
OrignalImage(:,:,3) = imresize(OrignalImageUnresized(:,:,3),scaleFactor);

for i = 1:size(ImageDataBase,4)
    deltaE(i) = mean2(sqrt((OrignalImage(:,:,1)-ImageDataBase(:,:,1,i)).^2+(OrignalImage(:,:,2)-ImageDataBase(:,:,2,i)).^2+(OrignalImage(:,:,3)-ImageDataBase(:,:,3,i)).^2));
end
    [optimalVal , index]= min(deltaE);
end

