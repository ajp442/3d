// Ultimaker 2 build volume
// 23 x 22.5 x 20.5cm
// Width of drawr

//item | width | height
//drawr | 25.2 |
//spoon | 4.3 | 19.7
//fork | 2.2 | 
//knife | | 23.4
//$fn=50;
//
//rad = .5;
//
//wall_thickness = .16;
//
//spoon_diameter_width = 4.5;
//spoon_diameter_length = 7.3;
//spoon_handle_length = 12.7;
//spoon_diameter_scale = (spoon_diameter_length/spoon_diameter_width);
//s = v;
//translate([0,-spoon_diameter_length,0]) {scale([1.0,spoon_diameter_scale,1.0]) circle(4.3);}
//minkowski(){
//circle(r=rad);
//polygon([[0,-spoon_diameter_length-rad+5], [-1+rad, spoon_handle_length-rad], [1-rad, spoon_handle_length-rad]]);
//}

color([.5, .5, .5, .5]) polygon([[0,-1], [3, 16], [-3, 16]]);

// Spoon
//sc_l = 20;
//sc_w = 4.4;
//sc_h = 5;
//difference(){
//cube([sc_l+wall_thickness*2, sc_w+wall_thickness*2, sc_h]);
//    translate([wall_thickness,wall_thickness,wall_thickness]){
//cube([sc_l, sc_w, sc_h]);
//    }
//}

//////////////////////////////////////////////////////////////////////////////
//kc_l = 22.8;
//kc_w = 2.3;
//kc_h = 5;
//
//wall_thickness = .16;

//// Knife
//difference(){
//cube([kc_l+wall_thickness*2, kc_w+wall_thickness*2, kc_h]);
//    translate([wall_thickness,wall_thickness,wall_thickness]){
//cube([kc_l, kc_w, kc_h]);
//    }
//}
//////////////////////////////////////////////////////////////////////////////