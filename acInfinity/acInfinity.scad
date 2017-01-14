$fn=10;
e = 0.01;

// Metric socket flat head
// 4mm x 0.7mm x 20mm

// Metric hex nut
// 4mm x 0,7mm


translate([0,0,(35.5/2)])
    cube([125,125,35.5], true);

    difference() {
        translate([0,0,(2/2)])
            cube([160,160,2], true);


        for(i=[1,-1])
        {
            for(j=[1,-1])
            {
                translate([(i*160/2-i*9.3),(j*160/2-j*9.3),-e])
                    cylinder(2+1,d=5.3,true);
            }
        }
    }

cylinder(100,d=153,true);
