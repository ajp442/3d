use <MCAD/triangles.scad>

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
sleve_length = extension; // Why not have it the same lenght as the extension for now.
sleve_width = shelf_width + sleve_wall_thickness*2;
sleve_height = shelf_height + sleve_wall_thickness*2;

e = 0.1;
ee = e*2;


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

shelf_extension();



// Block out one half.
//difference() {
//    shelf_extension();
//    translate([-extension, -e, -e]) cube([sleve_length + extension+ee, (sleve_width/2)+ee, sleve_height+ee]);
//
//}

