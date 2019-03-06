% Optimera efter databasen

nrOfPixels = 8;
RecreatedImageValues = rgb2lab(imresize(imread('obama.jpg'),1/nrOfPixels));

originalImage_mean_L = mean(mean(RecreatedImageValues(:,:,1)));
originalImage_mean_A = mean(mean(RecreatedImageValues(:,:,2)));
originalImage_mean_B = mean(mean(RecreatedImageValues(:,:,3)));

Threshold = 30;                 % Tröskelvärdet vi jämför mot 30 relativt lågt knappt någon skillnad i upplevd färg

Database = ImageDataBase_LAB;

blackList = zeros(1,(size(Database,4)));    %Bilder som inte får vara med
for p = 1: 1:(size(Database,4))-1
        if(blackList(p) == 1)
            %Jämför inte någon som är blacklistad
            break;
            %Jämför inte samma bild
        else
           %Skillnaden i ALLA kanaler (ger dåligt resultat)
           %difference = mean2(sqrt(Database(:,:,1,p)-originalImage_mean_L).^2+((Database(:,:,2,p)-originalImage_mean_A).^2) + ((Database(:,:,3,p)-originalImage_mean_B).^2) );
           
           %Beräknar skilladen i enbart hur ljus/mörk orginalbilden (Ger
           %bra resultat
           difference = mean2(sqrt((Database(:,:,1,p)-originalImage_mean_L).^2));
           if(difference > Threshold)   %Sparar bilden om delta e är större än threshold, dvs stor skillnad.
               if(blackList(p) == 1)    % Svartlistad och kommer inte med
                   continue;        
               else                     % Lägger till bilden
                   blackList(p) = 2;               
               end               
           elseif(blackList(p) == 0 || blackList(p) == 2)   %Kollar om indexet är visitad eller redan med
               blackList(p) = 1;              
           end         
        end
end

%Skapar databasen i LAB
imageCounter = 1;
for i = 1:size(Database,4)
    if(blackList(i) == 2)
        ImageDataBase_LAB_scrubbed(:,:,:,imageCounter) = (Database(:,:,:,i));
        imageCounter = imageCounter + 1;
    end
end

L_Data_scrubbed = squeeze(mean(mean(ImageDataBase_LAB_scrubbed(:,:,1,:))));
A_Data_scrubbed = squeeze(mean(mean(ImageDataBase_LAB_scrubbed(:,:,2,:))));
B_Data_scrubbed = squeeze(mean(mean(ImageDataBase_LAB_scrubbed(:,:,3,:))));

%Gör om databasen till RGB
ImageDateBase_RGB_scrubbed = lab2rgb(ImageDataBase_LAB_scrubbed);

%indexmatrisen för vilken bild i datorbasen som hör till vilket pixelområde
idx = ones(size(RecreatedImageValues,1),size(RecreatedImageValues,2));

for a = 1:size(RecreatedImageValues,1)
    for b = 1:size(RecreatedImageValues,2)
        Value_L = RecreatedImageValues(a,b,1);
        Value_A = RecreatedImageValues(a,b,2);
        Value_B = RecreatedImageValues(a,b,3);
        
        difference = mean2(sqrt((Value_L-L_Data_scrubbed(1)).^2 + (Value_A-A_Data_scrubbed(1)).^2 + (Value_B-B_Data_scrubbed(1)).^2));
        for findImage = 1:size(L_Data_scrubbed,1)
            NewDifference = mean2(sqrt((Value_L-L_Data_scrubbed(findImage)).^2 + (Value_A-A_Data_scrubbed(findImage)).^2 + (Value_B-B_Data_scrubbed(findImage)).^2));
            if(NewDifference < difference)          % Hittar minsta differansen
                difference = NewDifference;         % Ekvivalent? med min(pixel,bild)      
                idx(a,b) = findImage;               % Sparar index för bilden
            end
        end
    end
end

newImageRangeX = 1:31:(size(idx,1)*32);     %Sätter upp storleken på slutbilden
newImageRangeY = 1:31:(size(idx,2)*32);
newImage = zeros(size(idx,1),size(idx,2),3);

for u = 1:size(idx,1)
    for v = 1:size(idx,2)    
        newImage(newImageRangeX(u):newImageRangeX(u+1),newImageRangeY(v):newImageRangeY(v+1),:) = ImageDateBase_RGB_scrubbed(:,:,:,idx(u,v));   
    end
end

imshow(newImage)
