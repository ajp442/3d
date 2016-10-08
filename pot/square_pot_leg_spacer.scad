use <pin2.scad>

pinSize = [8, 8, 13];
legHeight = 25;
spacing = 1;

//difference(){
//    cube([pinSize[0]+2*spacing,pinSize[1]+2*spacing, legHeight]);
//        translate([pinSize[0]/2+spacing, pinSize[0]/2+spacing, 0]) { 
//        pinhole(fixed=true);
//}

pinpeg();
