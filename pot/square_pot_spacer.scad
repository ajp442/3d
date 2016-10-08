
use <pin2.scad>
use <MCAD/boxes.scad>

//roundedBox([width, height, depth], float radius, bool sidesonly);

translate([110/2,110/2,0]) plantBox();



module plantBox() {
    boxSize = [110, 110, 110];
    pinSize = [8, 8, 13];

    module _plantBox() {
        translate([0,0,boxSize[2]/2]){
            difference(){
                roundedBox(boxSize, 0, true);
                translate([0,0,5])roundedBox([100, 100, 110], 16, true);
            }
        }
    }

    module _pinHoles() {
        spacing = 1;
        for(x = [boxSize[0]/2-(pinSize[0]/2+spacing), (pinSize[0]/2+spacing)-boxSize[0]/2], y = [boxSize[1]/2-(pinSize[1]/2+spacing), (pinSize[1]/2+spacing)-boxSize[1]/2]) {
            translate([x, y, 0]){
                pinhole(fixed=true);
            }
        }
    }
    
    module _archimedean_spiral_holes(spirals=2, holeRadius=5, rmax = 45, holeEveryDeg=45){
    s = spirals*360;
    a = sqrt(pow(rmax,2)/(pow(s,2)*(pow(cos(s),2) + pow(sin(s),2))));
    for(i = [0:holeEveryDeg:s]){ 
        translate([(i*a)*cos(i), (i*a)*sin(i), -1]) cylinder(h=20, r=holeRadius);
    }
}

    difference(){
        _plantBox();
        _pinHoles();
        _archimedean_spiral_holes();
        _archimedean_spiral_holes();
    }
}

//pinpeg();
//translate([0,0,0])difference(){
//	cylinder(r=5.5,h=14);
//	pinhole(fixed=true);
//}
//translate([-10,0,0])difference(){
//	cylinder(r=5.5,h=14);
//	pinhole(fixed=false);
//}


// Test size of pinhole.
// Looks like pinhole bounding box is [8, 8, 13]
//s = 8;
//h = 13;
//%pinhole(fixed=true);
//translate([-s/2, -s/2, 0])%cube([s,s,h], false);
