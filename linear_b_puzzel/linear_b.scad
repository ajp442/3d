
characterImages = [["B013_ME.png", "B067_KI.png", "B050_PU.png", "B055_NU.png", "B058_SU.png"],
                   ["B013_ME.png", "B050_PU.png", "B016_QA.png", "B058_SU.png", "B055_NU.png"],
                   ["B044_KE.png", "B004_TE.png", "B055_NU.png", "B016_QA.png", "B013_ME.png"],
                   ["B055_NU.png", "B052_NO.png", "B011_PO.png", "B006_NA.png", "B055_NU.png"],
                   ["B053_RI.png", "B058_SU.png", "B009_SE.png", "B024_NE.png", "B044_KE.png"]];

charScale = 0.9; // Edit this to make the character larger or smaller.

imageSize = 50;

spacingBetweenCubes = (imageSize/10);

    wallThickness = 4;

container(characterImages, imageSize, charScale, spacingBetweenCubes, wallThickness);
translate([9,9,4])
translate([(50*5 + 5*4)/2, (50*5 + 5*4)/2, 25])
rotate([0,180,0])
translate([-(50*5 + 5*4)/2, -(50*5 + 5*4)/2, -25])
cubes(characterImages, imageSize, charScale, spacingBetweenCubes);




module container(images, imageSize, imageScale, spacingBetweenCubes, wallThickness)
{
    containerInnerSize = (imageSize * len(characterImages)) + (spacingBetweenCubes * (1 + len(characterImages)));
    containerOuterSize = (imageSize * len(characterImages)) + (spacingBetweenCubes * (1 + len(characterImages))) + (wallThickness * 2);

    outerCubeDimensions = [containerOuterSize, containerOuterSize, imageSize + wallThickness + 20];
    innerCubeDimensions = [containerInnerSize, containerInnerSize, imageSize + wallThickness + 20];

    difference() {
        cube(outerCubeDimensions);
        translate([wallThickness, wallThickness, wallThickness])
        cube(innerCubeDimensions);
    }
    
}

module cubes (images, imageSize, imageScale, spacingBetweenCubes)
{

    e = 0.1;
    imageImpressionDepth = 1;
    imageImpressionScale = imageImpressionDepth/100; // Calculated from range of surface scaling (0 to 100)
    margin = (imageSize - (imageSize * imageScale))/2;
    centerImageOnCube = [margin, margin, imageImpressionDepth-e];

    for (i = [ 0 : len(characterImages)-1])
    {
        for (j = [ 0 : len(characterImages[i])-1])
        {
            translate([((imageSize*i) + (spacingBetweenCubes*i)),((imageSize*j) + (spacingBetweenCubes*j)),0]) {
                difference() {
                    cube(imageSize);
                    translate(centerImageOnCube)
                        scale([imageScale, imageScale, imageImpressionScale])
                            surface(file = characterImages[i][j], invert = true);
                }
            }
        }
    }
}
