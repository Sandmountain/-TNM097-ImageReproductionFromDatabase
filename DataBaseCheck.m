%% Databasskapande & optimering
 Threshold = 30;                % Tr�skelv�rdet vi j�mf�r mot 15 relativt l�gt knappt n�gon skillnad i upplevd f�rg
 m = 1380;                       % Antalet bilder i databasen
 
 I=imread('bigDataImage(1).jpg');     % Namnet p� f�rsta bilden 
 [r n p]=size(I);               % Your Images are either 2D or 3D
 Manifold=zeros(r,n,p,m);       % 3D with singleton or 4D 
 for x=1:m
 filename=strcat('bigDataImage(',num2str(x),').jpg');
 Manifold(:,:,:,x)=rgb2lab(imread(filename));
 end
 
blackList = zeros(1,(size(Manifold,4)));    %Bilder som inte f�r vara med

for p = 1: 1:(size(Manifold,4))-1
    for q = 1: 1:(size(Manifold,4))-1
        if(blackList(p) == 1)
            %J�mf�r inte n�gon som �r blacklistad
            break;
        elseif(p == q)
            %J�mf�r inte samma bild
        else
            % Ber�kna /\E
           difference = mean2(sqrt((Manifold(:,:,1,p)-Manifold(:,:,1,q)).^2+(Manifold(:,:,2,p)-Manifold(:,:,2,q)).^2+(Manifold(:,:,3,p)-Manifold(:,:,3,q)).^2));
           if(difference > Threshold)   %Sparar bilden om delta e �r st�rre �n threshold, dvs stor skillnad.
               if(blackList(q) == 1)    % Svartlistad och kommer inte med
                   continue;        
               else                     % L�gger till bilden
                   blackList(q) = 2;               
               end               
           elseif(blackList(q) == 0 || blackList(q) == 2)   %Kollar om indexet �r visitad eller redan med
               blackList(q) = 1;              
           end         
        end
    end
end


%Skapar databasen i LAB
imageCounter = 1;
for i = 1:size(Manifold,4)
    if(blackList(i) == 2)
        ImageDataBase_LAB(:,:,:,imageCounter) = (Manifold(:,:,:,i));
        imageCounter = imageCounter + 1;
    end
end

L_Data = squeeze(mean(mean(ImageDataBase_LAB(:,:,1,:))));
A_Data = squeeze(mean(mean(ImageDataBase_LAB(:,:,2,:))));
B_Data = squeeze(mean(mean(ImageDataBase_LAB(:,:,3,:))));


%% Analysera datorbasen
L_Data_sorted = sort(L_Data);
A_Data_sorted = sort(A_Data);
B_Data_sorted = sort(B_Data);

subplot(2,2,[1 2])
a = bar(L_Data_sorted');
title('Luminance');

subplot(2,2,3)
b = bar(A_Data_sorted');
title('A-channel (g->r)')

subplot(2,2,4)
c = bar(B_Data_sorted');
title('B-channel (b->y)')



