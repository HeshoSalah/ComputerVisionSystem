function o = matching(q,w)
logoImage = rgb2gray(q);
% figure; imshow(logoImage);
% title('Image of a Ain Shams logo');
sceneImage = w;
% figure; imshow(sceneImage);
% title('Image of a Cluttered Scene');

%%
%Step 2: Detect Feature Points

boxPoints = detectSURFFeatures(logoImage);
scenePoints = detectSURFFeatures(sceneImage);
%%
%Step 3: Extract Feature Descriptors
[boxFeatures, boxPoints] = extractFeatures(logoImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

boxPairs = matchFeatures(boxFeatures, sceneFeatures);

%%
%Step 4: Find Putative Point Matches

matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
%figure;
%showMatchedFeatures(logoImage, sceneImage, matchedBoxPoints,matchedScenePoints, 'montage');
%title('Supposed Matched Points (Including Outliers)');

%%
%Step 5: Locate the Object in the Scene Using Putative Matches
%estimateGeometricTransform calculates the transformation relating the matched points, while eliminating outliers. 
%This transformation allows us to localize the object in the scene.
if ((size(matchedBoxPoints,1)>0)&&(size(matchedScenePoints,1)>0))
[tform, inlierBoxPoints, inlierScenePoints]=estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');


% % % figure,showMatchedFeatures(logoImage, sceneImage, inlierBoxPoints,inlierScenePoints, 'montage');
% % % title('Matched Points (Inliers Only)');

%Get the bounding polygon of the reference image.
boxPolygon = [1, 1;...                           % top-left
        size(logoImage, 2), 1;...                 % top-right
        size(logoImage, 2), size(logoImage, 1);... % bottom-right
        1, size(logoImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon

%Transform the polygon into the coordinate system of the target image.
%The transformed polygon indicates the location of the object in the scene.
newBoxPolygon = transformPointsForward(tform, boxPolygon);


% figure; imshow(sceneImage);
% hold on;
% line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
% title('Detected Ain Shams logo in the cluttered Scene');
o=1;
else
    o=0;
end
end
