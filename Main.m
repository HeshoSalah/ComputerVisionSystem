clc;
clear all;
close all;

logo=imread('LogoRef.jpg');
areaRef=imread('AreaRef.jpg');
prod_image=imread('Products3.jpg');
%figure,imshow(B)
red=prod_image(:,:,1);
green=prod_image(:,:,2);
blue=prod_image(:,:,3);

I1=im2bw(red,0.4);
I2=im2bw(green,0.4);
I3=im2bw(blue,0.4);
m=I1&I2&I3;


A=medfilt2(m);
A=im2bw(A,0.18);

A=imcomplement(A);
A=bwareaopen(A,100);
A=imfill(A,'holes');



[v,k]=bwlabel(A,8);

r2g=rgb2gray(prod_image);

figure,imshow(prod_image)

hold on

for j=1:k
[r,c]=find(v==j);

length=max(r)-min(r)+2;
width = max(c)-min(c)+2;
target1=zeros(length,width);
target2=zeros(length,width);
target3=uint8(255*ones(size(r2g,1),size(r2g,2)));


min_x=min(r)-1;
min_y=min(c)-1;
for i=1:size(r,1)
    x=r(i,1)-min_x;
    y=c(i,1)-min_y;
    target1(x,y)=m(r(i,1),c(i,1));
    target2(x,y)=A(r(i,1),c(i,1));
    target3(r(i,1),c(i,1))=r2g(r(i,1),c(i,1));
    
 
end
% figure,imshow(target3)

%%%%%%

if (CompareAreas(areaRef,target2)==1)
  if (matching(logo,target1)==1)
      color = colorDetect(prod_image,target3);
      
      props=regionprops((v==j),'BoundingBox','Centroid');
      box=props(1).BoundingBox;
      rectangle('position',box,'EdgeColor','r','LineWidth',2)
      
      center=props(1).Centroid;
      
      plot(center(1),center(2),'-m+')
      text(round(center(1))-50,round(center(2))+20,['The Cenroid','(',...
          num2str(round(center(1))),', ',num2str(round(center(2))),')'],'BackgroundColor',[0 1 1]);
      switch color
          case 1
             text(round(center(1))-50,round(center(2))+40,['The color is blue  '],'BackgroundColor',[0 1 1]);
          case 2
             text(round(center(1))-50,round(center(2))+40,['The color is red '],'BackgroundColor',[0 1 1]);
          case 3
             text(round(center(1))-50,round(center(2))+40,['The color is green   '],'BackgroundColor',[0 1 1]);
          case 4
             text(round(center(1))-50,round(center(2))+40,['The color is Purple'],'BackgroundColor',[0 1 1]);
          case 5
             text(round(center(1))-50,round(center(2))+40,['The color is yellow'],'BackgroundColor',[0 1 1]);
     
      end
      
  end
 
end
%%%%
end
