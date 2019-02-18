function [rgbValueOfImage] = Kmeans(rgbImage)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[L,cent] = imsegkmeans(rgbImage,2);
l_mean = mode(mode(L));

i = size(rgbImage,1) -1 ;
j = size(rgbImage,1) -1;

l_mask(i,j) = (L(i,j) == l_mean);

b = 1;
for k = 1:size(rgbImage,1) - 1
    for l = 1:size(rgbImage,2) - 1
        if(l_mask(k,l) == 1)
            values(b,:) = rgbImage(k,l,:);
            b = b + 1;
        end
    end
end

rgbValueOfImage(:,1) = mean(values(1:b-1, 1));
rgbValueOfImage(:,2) = mean(values(1:b-1, 2));
rgbValueOfImage(:,3) = mean(values(1:b-1, 3));

end

