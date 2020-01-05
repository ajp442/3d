 images = ["white.png", "white_flopped.png", "black.png", "black_flopped.png"];

imageScale = 0.9; // Edit this to make the character larger or smaller.

imageSize = 50;

spacingBetweenCubes = (imageSize/10);

numRows = len(images);

e = 0.1;
 

imageImpressionDepth = 1;
imageImpressionScale = imageImpressionDepth/100; // Calculated from surface scaling range (0 to 100)
margin = (imageSize - (imageSize * imageScale))/2;
centerImageOnCube = [margin, margin, -e];
uncenterImage = [imageSize/2, imageSize/2, imageImpressionDepth/2];

for ( i = [0 : numRows-1])
{
    translate([((imageSize*i) + (spacingBetweenCubes*i)), 0, 0]) {
        if( true )
        {
            difference() {
                cube(imageSize);
                translate(centerImageOnCube)
                scale([imageScale, imageScale, imageImpressionScale])
                surface(file = images[i]);
            }
        }
    }
}