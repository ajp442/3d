// rename -n 's/(Linear_B_Syllable_)(.*$)/$2/' *.png



//characterImages = [[13, 67, 50, 55, 58],
//                   [13, 50, 16, 58, 55],
//                   [44, 04, 55, 16, 13],
//                   [55, 52, 11, 06, 55],
//                   [53, 58, 09, 24, 44]];

container();
translate([9,9,4])
translate([(50*5 + 5*4)/2, (50*5 + 5*4)/2, 25])
rotate([0,180,0])
translate([-(50*5 + 5*4)/2, -(50*5 + 5*4)/2, -25])
cubes();




module container()
{
    characterImages = [["B013_ME.png", "B067_KI.png", "B050_PU.png", "B055_NU.png", "B058_SU.png"],
                       ["B013_ME.png", "B050_PU.png", "B016_QA.png", "B058_SU.png", "B055_NU.png"],
                       ["B044_KE.png", "B004_TE.png", "B055_NU.png", "B016_QA.png", "B013_ME.png"],
                       ["B055_NU.png", "B052_NO.png", "B011_PO.png", "B006_NA.png", "B055_NU.png"],
                       ["B053_RI.png", "B058_SU.png", "B009_SE.png", "B024_NE.png", "B044_KE.png"]];
    imageSize = 50;

    spacingBetweenCubes = (imageSize/10);

    containerInnerSize = (imageSize * len(characterImages)) + (spacingBetweenCubes * (1 + len(characterImages)));

    wallThickness = 4;

    outerCubeDimensions = [containerInnerSize + wallThickness*2, containerInnerSize + wallThickness*2, imageSize + wallThickness + 20];
    innerCubeDimensions = [containerInnerSize, containerInnerSize, imageSize + wallThickness + 20];

    difference() {
        cube(outerCubeDimensions);
        translate([wallThickness, wallThickness, wallThickness])
        cube(innerCubeDimensions);
    }
    
}

module cubes ()
{
    characterImages = [["B013_ME.png", "B067_KI.png", "B050_PU.png", "B055_NU.png", "B058_SU.png"],
                       ["B013_ME.png", "B050_PU.png", "B016_QA.png", "B058_SU.png", "B055_NU.png"],
                       ["B044_KE.png", "B004_TE.png", "B055_NU.png", "B016_QA.png", "B013_ME.png"],
                       ["B055_NU.png", "B052_NO.png", "B011_PO.png", "B006_NA.png", "B055_NU.png"],
                       ["B053_RI.png", "B058_SU.png", "B009_SE.png", "B024_NE.png", "B044_KE.png"]];

    charScale = 0.9; // Edit this to make the character larger or smaller.

    imageSize = 50;

    spacingBetweenCubes = (imageSize/10);

    charTrans = (imageSize - (imageSize * charScale))/2;

    echo (len(characterImages));
    for (i = [ 0 : len(characterImages)-1])
    {
        for (j = [ 0 : len(characterImages[i])-1])
        {
            translate([((imageSize*i) + (spacingBetweenCubes*i)),((imageSize*j) + (spacingBetweenCubes*j)),0]) {
                difference() {
                    cube(imageSize);
                    translate([charTrans,charTrans,.9])
                        scale([charScale, charScale, 0.1])
                            surface(file = characterImages[i][j], invert = true);
                }
            }
        }
    }
}

