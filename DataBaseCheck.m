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
 
blackList = zeros(1,(size(Manifold,4)));

for p = 1: 1:(size(Manifold,4))-1
    for q = 1: 1:(size(Manifold,4))-1
        if(blackList(p) == 1)
            %Jämför inte någon som är blacklistad
            break;
        elseif(p == q)
            %do nothing
        else
           difference = mean2(sqrt((Manifold(:,:,1,p)-Manifold(:,:,1,q)).^2+(Manifold(:,:,2,p)-Manifold(:,:,2,q)).^2+(Manifold(:,:,3,p)-Manifold(:,:,3,q)).^2));
           if(difference > 20)
               if(blackList(q) == 1)
                   continue;        
               else
                   blackList(q) = 2;               
               end               
           elseif(blackList(q) == 0 || blackList(q) == 2)
               blackList(q) = 1;
               
           end         
        end
    end
end

nrImages = sum(blackList(:) == 2);
