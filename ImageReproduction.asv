%% Image Reproduction
% välj bäst SSIM, kolla 32x32 område - hitta bästa kandidat (genom SSIM)
% och jämför alla närliggande bilder
nrOfPixels = 1;
RecreatedImageValues = rgb2lab(imresize(imread('obama.jpg'),1/nrOfPixels));

%Lab_Image = rgb2lab(orignalImage);

%Gör om databasen till RGB
ImageDateBase_RGB = lab2rgb(ImageDataBase_LAB);

%indexmatrisen för vilken bild i datorbasen som hör till vilket pixelområde
idx = ones(size(RecreatedImageValues,1),size(RecreatedImageValues,2));

for a = 1:size(RecreatedImageValues,1)
    for b = 1:size(RecreatedImageValues,2)
        Value_L = RecreatedImageValues(a,b,1);
        Value_A = RecreatedImageValues(a,b,2);
        Value_B = RecreatedImageValues(a,b,3);
        
        difference = mean2(sqrt((Value_L-L_Data(1)).^2 + (Value_A-A_Data(1)).^2 + (Value_B-B_Data(1)).^2));
        for findImage = 1:size(L_Data,1)
            NewDifference = mean2(sqrt((Value_L-L_Data(findImage)).^2 + (Value_A-A_Data(findImage)).^2 + (Value_B-B_Data(findImage)).^2));
            if(NewDifference < difference)          % Hittar minsta differansen
                difference = NewDifference;         % Ekvivalent? med min(pixel,bild)      
                idx(a,b) = findImage;               % Sparar index för bilden
                
%                 Kod för att inte ha samma bilder eftervarandra.
%                 if(b ~= 1 && idx(a,b-1) ~= findImage) 
%                    
%                 elseif(b == 1)
%                     idx(a,b) = findImage;
%                 else
%                     continue;
%                 end
            end
        end
    end
end

newImageRangeX = 1:31:(size(idx,1)*32);     %Sätter upp storleken på slutbilden
newImageRangeY = 1:31:(size(idx,2)*32);
newImage = zeros(size(idx,1),size(idx,2),3);

for u = 1:size(idx,1)
    for v = 1:size(idx,2)    
        newImage(newImageRangeX(u):newImageRangeX(u+1),newImageRangeY(v):newImageRangeY(v+1),:) = ImageDateBase_RGB(:,:,:,idx(u,v));   
    end
end

imshow(newImage)


%% TODO 
% 
% [X] Optimera databas utifrån en bild
% [X] Lägga till kvalitétsmått
% [~] Lägga till ett annat mått vid nästan helt lika bilder
% [X] Göra GUI
% [X] Göra Databas lite större och bättre omfång.

% Prata om scrubben om databasen, HVS, 
% x/\E+(1-x)*(1-SSIM)    //Låg värde på x, färg dålig, bra struktur (Välj
% det minsta)
% x = 0.2, 0.5, 0.8 (32 x 32 område)-> välj de bilder ifrån databasen 