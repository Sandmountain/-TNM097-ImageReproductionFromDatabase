%% Image Reproduction
% välj bäst SSIM, kolla 32x32 område - hitta bästa kandidat (genom SSIM)
% och jämför alla närliggande bilder
nrOfPixels = 1;
xValue = 2;
RecreatedImageValues = rgb2lab(imresize(imread('obama.jpg'),[320 320]));

%Gör om databasen till RGB
ImageDateBase_RGB = lab2rgb(ImageDataBase_LAB);

DBRangeX = 1:31:(size(RecreatedImageValues,1));     
DBRangeY = 1:31:(size(RecreatedImageValues,2));
i = 1;
for a = 1:size(DBRangeX,2)-1
    for b = 1:size(DBRangeY,2)-1

        i = 1;
        Value_L = RecreatedImageValues(DBRangeX(a):DBRangeX(a+1),DBRangeY(b):DBRangeY(b+1),1);
        Value_A = RecreatedImageValues(DBRangeX(a):DBRangeX(a+1),DBRangeY(b):DBRangeY(b+1),2);
        Value_B = RecreatedImageValues(DBRangeX(a):DBRangeX(a+1),DBRangeY(b):DBRangeY(b+1),3);
      
        deltaE = mean2(sqrt((Value_L(:,:)-ImageDataBase_LAB(:,:,1,1)).^2+(Value_A(:,:)-ImageDataBase_LAB(:,:,2,1)).^2+(Value_B(:,:)-ImageDataBase_LAB(:,:,3,1)).^2));
        
        
        for findImage = 1:size(ImageDataBase_LAB,4)
            newDeltaE = mean2(sqrt((Value_L(:,:)-ImageDataBase_LAB(:,:,1,findImage)).^2+(Value_A(:,:)-ImageDataBase_LAB(:,:,2,findImage)).^2+(Value_B(:,:)-ImageDataBase_LAB(:,:,3,findImage)).^2));
            
            if(newDeltaE < deltaE)          % Hittar minsta differansen
              deltaE = newDeltaE;
              savedImage(:,:,:,i) = ImageDataBase_LAB(:,:,:,findImage);
              deltaEMatrix(i) = deltaE;
              i = i+1;
            end
            if(findImage == size(ImageDataBase_LAB,4))
                
                newQualityMeasure = 100;
                for k = 1:i-1
                    for l = 1:i-1
                        thisDeltaE = mean2(sqrt(deltaEMatrix(k)-deltaEMatrix(l)).^2+(deltaEMatrix(k)-deltaEMatrix(l)).^2+(deltaEMatrix(k)-deltaEMatrix(l)).^2);
                        SSIM = ssim(RecreatedImageValues(DBRangeX(a):DBRangeX(a+1),DBRangeX(b):DBRangeX(b+1),:),savedImage(:,:,:,k));
                     
                        QualityMeasure = xValue * thisDeltaE + (1 - xValue) * (1-SSIM);  
                        if(QualityMeasure < newQualityMeasure)
                            newQualityMeasure = QualityMeasure;
                            finalImage(DBRangeX(a):DBRangeX(a+1),DBRangeX(b):DBRangeX(b+1),:) = savedImage(:,:,:,k);
                        end
                    end
                end
            end
        end
    end
end
imshow(lab2rgb(finalImage))

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