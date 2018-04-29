    %image processing project
    %color detection code 
    %This code made by:Mina yousry Halim
    
  
    function number =colorDetect(originalImage,object)
   
    coloredImage=originalImage; 
    objectImage=object;
    
    % detect the blue color
    % Subtracting the blue matrix from the image to detect the blue color in the image.
    imgblue=imsubtract(0.7*coloredImage(:,:,3),objectImage);
    %median filter to remove the noise if existed
    imgblue=medfilt2(imgblue,[3,3]);
    %transforming te image into binary
    imgblue=im2bw(imgblue,0.18);
    %removing areas below 300 pixels
    imgblue=bwareaopen(imgblue,300);
    
    if(size(find(imgblue==1),1)~= 0)
        number=1;
    end

    %%
    %detect the red color
    % Subtracting the red matrix from the image to detect the red color in the image.
    imgred=imsubtract(coloredImage(:,:,1),objectImage);
    %median filter to remove the noise if existed
    imgred=medfilt2(imgred,[3,3]);
    %transforming te image into binary
    imgred=im2bw(imgred,0.18);
    %removing areas below 300 pixels
    imgred=bwareaopen(imgred,300);
    
    if((size(find(imgred==1),1)~= 0))
        number=2;    
    end

   %% 
    %detect the green color
    % Subtracting the green matrix from the image to detect the green color in the image.
    imggreen=imsubtract(coloredImage(:,:,2),objectImage);
    %median filter to remove the noise if existed
    imggreen=medfilt2(imggreen,[3,3]);
    %transforming te image into binary
    imggreen=im2bw(imggreen,0.18);
    %removing areas below 300 pixels
    imggreen=bwareaopen(imggreen,300);
    if((size(find(imggreen==1),1)~= 0))
        number=3;
        
    end

  %%  
    %detect the purple color
    % Subtracting the purple + blue matrix from the image to detect the purple + blue color in the image.
    imgpurple=imsubtract(coloredImage(:,:,3),objectImage);
    %transforming the image into binary
    imgpurple=im2bw(imgpurple,0.18);
    str=strel('disk',3);
    imgblue = imcomplement(imdilate(imgblue,str));
    % detect purple color
    imgpurple = imgpurple .* imgblue;
    %median filter to rmove the noise if existed
    imgpurple=medfilt2(imgpurple,[3,3]);
    %removing areas below 100 pixels
    imgpurple=bwareaopen(imgpurple,100);
    if(size(find(imgpurple==1),1)~= 0)
        number=4;
      
    end

  %%  
    %detect the yellow color
    % Subtracting the yellow + green matrix from the image to detect the yellow + green color in the image.
    imgyellow=imsubtract(coloredImage(:,:,2),objectImage);
    imgyellow = imgyellow * 5;
    %transforming the image into binary
    imgyellow=im2bw(imgyellow,0.18);
    
    % detect yellow color
    imgyellow = imcomplement(imggreen) .* imgyellow;
    %median filter to rmove the noise if existed
    imgyellow=medfilt2(imgyellow,[3,3]);
    %removing areas below 100 pixels
    imgyellow=bwareaopen(imgyellow,300);
    if(size(find(imgyellow==1),1)~= 0)
        number=5;

    end
    end