
characterImages = [["B013_ME.png", "B067_KI.png", "B050_PU.png", "B055_NU.png", "B058_SU.png"],
                   ["B013_ME.png", "B050_PU.png", "B016_QA.png", "B058_SU.png", "B055_NU.png"],
                   ["B044_KE.png", "B004_TE.png", "B055_NU.png", "B016_QA.png", "B013_ME.png"],
                   ["B055_NU.png", "B052_NO.png", "B011_PO.png", "B006_NA.png", "B055_NU.png"],
                   ["B053_RI.png", "B058_SU.png", "B009_SE.png", "B024_NE.png", "B044_KE.png"]];

charScale = 0.9; // Edit this to make the character larger or smaller.

imageSize = 50;

spacingBetweenCubes = (imageSize/10);

wallThickness = 10;

numRows = len(characterImages);
numCols = len(characterImages[0]);

e = 0.1;

//liddedContainer(characterImages, imageSize, charScale, spacingBetweenCubes, wallThickness);


//cubes(characterImages, imageSize, charScale, spacingBetweenCubes);

// Getting things in the right place feels a little haky to me right now.

container(characterImages, imageSize, charScale, spacingBetweenCubes, wallThickness);
translate([spacingBetweenCubes + wallThickness,spacingBetweenCubes + wallThickness, wallThickness])
	translate([(imageSize*numRows + (numRows-1)*spacingBetweenCubes)/2, (imageSize*numCols + (numCols-1)*spacingBetweenCubes)/2, imageSize/2])
		rotate([0,180,0])
			translate([-(imageSize*numRows + (numRows-1)*spacingBetweenCubes)/2, -(imageSize*numCols + (numCols-1)*spacingBetweenCubes)/2, -imageSize/2])
				cubes(characterImages, imageSize, charScale, spacingBetweenCubes);


module liddedContainer(images, imageSize, imageScale, spacingBetweenCubes, wallThickness)
{
	difference() {
		container(characterImages, imageSize, charScale, spacingBetweenCubes, wallThickness);
		translate([wallThickness/2,wallThickness/2,imageSize + 15])
		lid(characterImages, imageSize, charScale, spacingBetweenCubes, wallThickness);
	}
}

module lid(images, imageSize, imageScale, spacingBetweenCubes, wallThickness)
{  
	lidWidth = (imageSize * numRows) + (spacingBetweenCubes * (1 + numRows)) + wallThickness;
	lidDepth = (imageSize * numRows) + (spacingBetweenCubes * (1 + numRows)) + 1.5*wallThickness + e;
	cube([lidWidth, lidDepth, wallThickness]);
}

module container(images, imageSize, imageScale, spacingBetweenCubes, wallThickness)
{
    containerInnerWidth = (imageSize * numRows) + (spacingBetweenCubes * (1 + numRows));
    containerInnerDepth = (imageSize * numCols) + (spacingBetweenCubes * (1 + numCols));
    containerOuterWidth = (imageSize * numRows) + (spacingBetweenCubes * (1 + numRows)) + (wallThickness * 2);
    containerOuterDepth = (imageSize * numCols) + (spacingBetweenCubes * (1 + numCols)) + (wallThickness * 2);
    outerCubeDimensions = [containerOuterWidth, containerOuterDepth, imageSize + wallThickness + 20];
    innerCubeDimensions = [containerInnerWidth, containerInnerDepth, imageSize + wallThickness + 20];

    difference() {
        cube(outerCubeDimensions);
        translate([wallThickness, wallThickness, wallThickness])
			cube(innerCubeDimensions);
    }
}

module cubes (images, imageSize, imageScale, spacingBetweenCubes)
{
    imageImpressionDepth = 1;
    imageImpressionScale = imageImpressionDepth/100; // Calculated from surface scaling range (0 to 100)
    margin = (imageSize - (imageSize * imageScale))/2;
    centerImageOnCube = [margin, margin, imageImpressionDepth-e];

    for (i = [ 0 : numRows-1])
    {
        for (j = [ 0 : numCols-1])
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
