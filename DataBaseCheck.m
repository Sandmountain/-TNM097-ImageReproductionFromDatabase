%% Image load
rgbImage = imread("image (4).jpg");
rgbImage2 = imread("image (7).jpg");

%% Metod 1 medelvärde (Problem när (255,0,0) = (0,255,0))
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

[L,cent] = imsegkmeans(rgbImage,2);
l_mean = mode(mode(L));

thisImage = labeloverlay(rgbImage,L);
imshow(thisImage)

i = 1:32;
j = 1:32;

l_mask(i,j) = (L(i,j) == l_mean);

b = 1;
for k = 1:32
    for l = 1:32
        if(l_mask(k,l) == 1)
            values(b,:) = rgbImage(k,l,:);
            b = b + 1;
        end
    end
end

meanValueOfImageR = mean(values(1:b-1, 1));
meanValueOfImageG = mean(values(1:b-1, 2));
meanValueOfImageB = mean(values(1:b-1, 3));

%% Metod 3 Labjämförelse
 m = 516;
 I=imread('image (1).jpg');
 [r n p]=size(I);  % Your Images are either 2D or 3D
 Manifold=zeros(r,n,p,m); % 3D with singleton or 4D 
 for x=1:m
 filename=strcat('image (',num2str(x),').jpg');
 Manifold(:,:,:,x)=rgb2lab(imread(filename));
 end
 
%%
newMatrix(:,:,:,1) = Manifold(:,:,:,1);

nrImages = 1;

for j = 1:m
    difference = mean2(sqrt((Manifold(:,:,1,1)-Manifold(:,:,1,j)).^2+(Manifold(:,:,2,1)-Manifold(:,:,2,j)).^2+(Manifold(:,:,3,1)-Manifold(:,:,3,j)).^2));
    if( difference > 25)
        newMatrix(:,:,:,nrImages) = Manifold(:,:,:,j);
        nrImages = nrImages+1;
    end
    
end
%% Mindre för varje iteration... en funktion av detta?
for l = 1: nrImages - 1;
    for m = 1:m
    difference = mean2(sqrt((newMatrix(:,:,1,l)-Manifold(:,:,1,j)).^2+(newMatrix(:,:,2,l)-Manifold(:,:,2,j)).^2+(newMatrix(:,:,3,l)-Manifold(:,:,3,j)).^2));
end   


%%


for i = 1:m-1
   for j = 2:(m-2-i)
       for k = 1:size(nyMatis,4)
           if(nyMatris)
            difference = mean2(sqrt((nyMatris(:,:,1,k)-Manifold(:,:,1,j)).^2+(Manifold(:,:,2,k)-Manifold(:,:,2,j)).^2+(Manifold(:,:,3,i)-Manifold(:,:,3,j)).^2));
           end
       end
   end
end

 
difference = mean2(sqrt((labImage1(:,:,1,1:x)-labImage2(:,:,1,1:x)).^2+(labImage1(:,:,2)-labImage2(:,:,2)).^2+(labImage1(:,:,3)-labImage2(:,:,3)).^2));
 
 
labImage1 = rgb2lab(rgbImage);
labImage2 = rgb2lab(rgbImage2);

difference = mean2(sqrt((labImage1(:,:,1)-labImage2(:,:,1)).^2+(labImage1(:,:,2)-labImage2(:,:,2)).^2+(labImage1(:,:,3)-labImage2(:,:,3)).^2));

%mean(mean(difference))


%image = kmeans(double(rgbImage),3);