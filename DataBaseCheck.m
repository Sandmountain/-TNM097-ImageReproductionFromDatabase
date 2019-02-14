Igreen = imread("image (581).jpg");
Ired = imread("image (567).jpg");

Igreen_lab = rgb2lab(Igreen);
Ired_lab = rgb2lab(Ired);

[L,cent] = imsegkmeans(Ired,3);
l_mean = mode(mode(L));
thisImage = labeloverlay(Ired,L);
imshow(thisImage)
%difference = sqrt((Igreen_lab(:,:,1)-Ired_lab(:,:,1)).^2+(Igreen_lab(:,:,2)-Ired_lab(:,:,2)).^2+(Igreen_lab(:,:,3)-Ired_lab(:,:,3)).^2);
%mean(mean(difference))

%gren = mean2(Igreen);
%red = mean2(Ired);

%% Metod 1
% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
 
% Get means
meanR = mean(redChannel);
meanG = mean(greenChannel);
meanB = mean(blueChannel);

%Find largest
if(mean(meanR) > mean(meanG) && mean(meanB))    
    acctualColorR = max(meanR);
    acctualColorG = min(meanG);
    acctualColorB = min(meanB);
end
if(mean(meanG) > mean(meanR) && mean(meanB))
    acctualColorR = min(meanR);
    acctualColorG = max(meanG);
    acctualColorB = min(meanB);
end
if(mean(meanB) > mean(meanR) && mean(meanG)) 
    acctualColorR = min(meanR);
    acctualColorG = min(meanG);
    acctualColorB = max(meanB);   
end


%imhist((acctualColorR,acctualColorG,acctualColorB))

%% Metod 2 Datamining
[L,centers] = imsegkmeans(rgbImage,3);
B = labeloverlay(rgbImage,L);
%%


%image = kmeans(double(rgbImage),3);