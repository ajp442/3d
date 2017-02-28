use <MCAD/triangles.scad>
include <knurledFinishLib.scad>
include <polyScrewThread.scad>

// The width of one layer (i.e. nozel size is 0.4mm).
layer_width = 0.4;

// Dimensions of the shelf.
shelf_width = 254; // 10 inch
shelf_length = 1828.8; // 6 feet (72 inch)
shelf_height = 20;

// How long the shelf needs to be.
needed_shelf_length = 1981.2; // 6.5 feet (78 inch)

// Part that extends the shelf.
extension = needed_shelf_length - shelf_length;

// Sleve that fits around the shelf.
sleve_wall_thickness = layer_width * 8; // Increment in number of layers.
ridge_thickness = sleve_wall_thickness * 2;
sleve_length = extension; // Why not have it the same lenght as the extension for now.
sleve_width = shelf_width + sleve_wall_thickness*2;
sleve_height = shelf_height + sleve_wall_thickness*2;

e = 0.1;
ee = e*2;

nut_od = 22.5;
ridge_height = nut_od + 10;
t_od=15;    // Thread outer diameter
hole_diameter = t_od+1;

module shelf_extension()
{
    difference() {
        // The sleve.
        cube([sleve_length, sleve_width, sleve_height]);

        // Negative space where the end of the shelf would go.
        translate([sleve_wall_thickness,sleve_wall_thickness,sleve_wall_thickness]) {
            cube([sleve_length,shelf_width,shelf_height]);
        }
    }

    // The extension.
    mirror([1,0,0]){ 
        translate([-e,sleve_wall_thickness,sleve_wall_thickness]) {
            cube([extension, shelf_width, shelf_height]);
        }
    }
    

    triangle_supports();
    intersecting_corners();

    translate([0,(sleve_width/2)-(ridge_thickness/2),sleve_height])
    connecting_ridge();

    translate([0,(sleve_width/2)-(ridge_thickness/2),-32.5])
    connecting_ridge();
}

module triangle_supports()
{
    // Triangles for more support.

    // Top and bottom of shelf.
    translate([0,sleve_wall_thickness,shelf_height+sleve_wall_thickness]) {
        rotate(a=[90,0,180]) { 
            triangle(sleve_wall_thickness,extension/2,shelf_width);
        }
    }

    translate([0,sleve_wall_thickness,sleve_wall_thickness]) {
        mirror([0,0,1]) {
            rotate(a=[90,0,180]) { 
                triangle(sleve_wall_thickness,extension/2,shelf_width);
            }
        }
    }

    // Sides of shelf.
    translate([0,sleve_wall_thickness,sleve_wall_thickness]) {
        rotate(a=[180,180,0]) {
            triangle(sleve_wall_thickness,extension/2,shelf_height);
        }
    }
    
    translate([0,shelf_width+sleve_wall_thickness,sleve_wall_thickness]) {
        mirror([0,1,0]) { 
            rotate(a=[180,180,0]) {
                triangle(sleve_wall_thickness,extension/2,shelf_height);
            }
        }
    }
}

module intersecting_corners()
{
    intersection() {
        // Top
        translate([0,0,shelf_height+sleve_wall_thickness]) {
            rotate(a=[90,0,180]) { 
                triangle(sleve_wall_thickness,extension/2,sleve_width);
            }
        }

        // front side.
        translate([0,sleve_wall_thickness,0]) {
            rotate(a=[180,180,0]) {
                triangle(sleve_wall_thickness,extension/2,sleve_height);
            }
        }
    }

    intersection() {
        // Top
        translate([0,0,shelf_height+sleve_wall_thickness]) {
            rotate(a=[90,0,180]) { 
                triangle(sleve_wall_thickness,extension/2,sleve_width);
            }
        }

        // back side.
        translate([0,shelf_width+sleve_wall_thickness,0]) {
            mirror([0,1,0]) { 
                rotate(a=[180,180,0]) {
                    triangle(sleve_wall_thickness,extension/2,sleve_height);
                }
            }
        }
    }
    intersection() {
        // Bottom
        translate([0,0,sleve_wall_thickness]) {
            mirror([0,0,1]) {
                rotate(a=[90,0,180]) { 
                    triangle(sleve_wall_thickness,extension/2,sleve_width);
                }
            }
        }

        // front side.
        translate([0,sleve_wall_thickness,0]) {
            rotate(a=[180,180,0]) {
                triangle(sleve_wall_thickness,extension/2,sleve_height);
            }
        }
    }

    intersection() {
        // Bottom
        translate([0,0,sleve_wall_thickness]) {
            mirror([0,0,1]) {
                rotate(a=[90,0,180]) { 
                    triangle(sleve_wall_thickness,extension/2,sleve_width);
                }
            }
        }

        // back side.
        translate([0,shelf_width+sleve_wall_thickness,0]) {
            mirror([0,1,0]) { 
                rotate(a=[180,180,0]) {
                    triangle(sleve_wall_thickness,extension/2,sleve_height);
                }
            }
        }
    }
}

module Makerbolt()
{
 /* Bolt parameters.
  *
  * Just how thick is the head.
  * The other parameters, common to bolt and nut, are defined into k_cyl() module
  */
    b_hg=10;

 /* Screw thread parameters
  */
    t_od=15;    // Thread outer diameter
    t_st=2.5;   // Step/traveling per turn
    t_lf=55;    // Step angle degrees
    t_ln=15;    // Length of the threade section
    t_rs=PI/2;  // Resolution
    t_se=1;     // Thread ends style
    t_gp=0;     // Gap between nut and bolt threads


    difference()
    {
        union()
        {
            k_cyl(b_hg);

            translate([0,0,b_hg])
              screw_thread(t_od+t_gp, t_st, t_lf, t_ln, t_rs, t_se);
        }
    }
}

module k_cyl(bnhg)
{
 /* Bolt/Nut parameters
  */
    k_cyl_hg=bnhg;   // Knurled cylinder height
    k_cyl_od=22.5;   // Knurled cylinder outer* diameter

    knurl_wd=3;      // Knurl polyhedron width
    knurl_hg=4;      // Knurl polyhedron height
    knurl_dp=1.5;    // Knurl polyhedron depth

    e_smooth=1;      // Cylinder ends smoothed height
    s_smooth=0;      // [ 0% - 100% ] Knurled surface smoothing amount

    knurled_cyl(k_cyl_hg, k_cyl_od, 
                knurl_wd, knurl_hg, knurl_dp, 
                e_smooth, s_smooth);
}



//Makerbolt();
//shelf_extension();

module connecting_ridge()
{
    difference() {
    cube([sleve_length, ridge_thickness, ridge_height]);

    translate([sleve_length/4,ridge_thickness+1,ridge_height/2])
    rotate([90,0,0])
    cylinder(h=ridge_thickness+2, d=hole_diameter);

    translate([3*(sleve_length/4),ridge_thickness+1,ridge_height/2])
    rotate([90,0,0])
    cylinder(h=ridge_thickness+2, d=hole_diameter);
    }
    
}



// Block out one half.
difference() {
    shelf_extension();
    translate([-extension, -e, -ridge_height-e]) cube([sleve_length + extension+ee, (sleve_width/2)+ee, sleve_height+2*ridge_height+ee]);

}

