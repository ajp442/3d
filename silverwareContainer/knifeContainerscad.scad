// Ultimaker 2 build volume
// 23 x 22.5 x 20.5cm

// Change these numbers to get different size boxes.
// These are the inside dimensions of the knife container.
kc_l = 22.8; // Knife Container length
kc_w = 2.3; // Knife Container width
kc_h = 5; // Knife Container height
// How thick the sides will be.
wall_thickness = .16;

// Taking the difference of two cubes,
// One larger, 
// the other smaller by two wall thicknesses and 
// offset by one wall thickness in x, y, and z directions
difference(){
    cube([kc_l+wall_thickness*2, kc_w+wall_thickness*2, kc_h]);
    translate([wall_thickness,wall_thickness,wall_thickness]){cube([kc_l, kc_w, kc_h]);}
}
