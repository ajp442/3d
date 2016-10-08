// Ultimaker 2 build volume
// 23 x 22.5 x 20.5cm

// Change these numbers to get different size boxes.
// These are the inside dimensions of the knife container.
box_l = 20; // Knife Container length
box_w = 20; // Knife Container width
box_h = 20; // Knife Container height
// How thick the sides will be.
wall_thickness = .16;

$fn=50; // Number of fragments.

//screw
function main(params) {
    var sqrt3 = Math.sqrt(3) / 2;
    var radius = 10;

    var hex = CSG.Polygon.createFromPoints([
            [radius, 0, 0],
            [radius / 2, radius * sqrt3, 0],
            [-radius / 2, radius * sqrt3, 0],
            [-radius, 0, 0],
            [-radius / 2, -radius * sqrt3, 0],
            [radius / 2, -radius * sqrt3, 0]
    ]).setColor(
        [0, 0.8, 0]
    );
    var angle = 5;
    return hex.solidFromSlices({
        numslices: 720 / angle,
        callback: function(t, slice) {
            var coef = 1 - t * 0.8;
            return this.scale(coef).translate([radius * 4 * t, t * 15, 0]).rotate(
                        [0,20,0],
                        [-1, 0, 0],
                        angle * slice
                    );
        }
    });
}

//function path(t) = [
//        (t / 1.5 + 0.5) * 100 * cos(6 * 360 * t),
//        (t / 1.5 + 0.5) * 100 * sin(6 * 360 * t),
//        200 * (1 - t)
//];
//
//loft(path = "path", slices = 800, height = 100) {
//        translate([-10, -6, 0]) square([3, 6]);
//        square([20, 2], center = true);
//        translate([7, -6, 0]) square([3, 6]);
//}

//linear_extrude(height = 10, center = false, convexity = 20, twist = 720, $fn = 100)
//translate([2, 0, 0])
//circle(r = 1);

//box();
//
//start=1;
//increment=1;
//num_shelves=5;
//difference() {
//    for(s = [start : increment : num_shelves]) {
//        shelf(s*box_w/(num_shelves+1));
//    }
//
//    translate([box_l/2, box_h, box_w]) {
//        rotate([90,0,0]) {
//            cylinder(h=box_w-wall_thickness, r=5, center=false);
//        }
//    }
//}

// Taking the difference of two cubes,
// One larger, 
// the other smaller by two wall thicknesses and 
// offset by one wall thickness in x, y, and z directions
module box() {
    difference(){
        cube([box_l+wall_thickness*2, box_w+wall_thickness*2, box_h]);
        translate([wall_thickness,wall_thickness,wall_thickness]){cube([box_l, box_w, box_h]);}
    }
}


module shelf(shelf_height) {
    translate([wall_thickness, shelf_height, wall_thickness]) {
        cube([box_l, wall_thickness, box_h]);
    }
}
