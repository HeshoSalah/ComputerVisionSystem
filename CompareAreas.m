function area = CompareAreas(ref,img)

RefImg=ref;
Compared=img;

RefImg=rgb2gray(RefImg);
RefImg=medfilt2(RefImg);

RefImg=im2bw(RefImg,0.4);
RefImg=imcomplement(RefImg);
RefImg=imfill(RefImg,'holes');
RefImg=bwareaopen(RefImg,100);


v=bwlabel(RefImg,8);
stats=regionprops(v,'Area');
% stats(1).Area

z=bwlabel(Compared,8);
states=regionprops(z,'Area');
% states(1).Area
if(stats(1).Area>states(1).Area)
  p=stats(1).Area-states(1).Area;
else
  p=states(1).Area-stats(1).Area;
end

if(p<1000 && p>0 )
    area=1;
else
    area=0;
end
end



