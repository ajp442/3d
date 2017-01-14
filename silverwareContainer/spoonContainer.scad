$fn=500;

m_wall_thickness = 0.16;

m_scoop_width = 4.5;
m_scoop_length = 7.3;
m_handle_length = 12.5;
m_handle_base_width = 2.5;
m_handle_neck_width = 0.9;

m_box_length = (m_handle_length + m_scoop_length) + (m_wall_thickness*2);
m_box_width = m_scoop_width + m_wall_thickness*2;
m_box_height = 3;


difference(){
    translate([(-m_scoop_width/2)-m_wall_thickness, -m_scoop_length-m_wall_thickness, 0])
        cube([m_box_width, m_box_length, m_box_height]);

    translate([0,0,m_wall_thickness])
    {
        linear_extrude(m_box_height,center=false,convexity=4,twist=false)
        {
            spoonShape(m_scoop_width, m_scoop_length, m_handle_length, m_handle_base_width, m_handle_neck_width);
        }
    }

    // Inner box, a place to grab the utencil.
    translate([(-m_scoop_width/2), m_handle_length/6, m_wall_thickness])
        cube([m_box_width-(2*m_wall_thickness), m_handle_length*(0.6), m_box_height]);
}

e = 0.0001;
m_scoop_width = 4.5;
m_scoop_length = 7.3;
m_handle_length = 12.5;
m_handle_base_width = 2;
m_handle_neck_width = 0.9;
spoonShape(m_scoop_width, m_scoop_length, m_handle_length, m_handle_base_width, m_handle_neck_width);

module spoonShape(p_scoop_width, p_scoop_length, handle_length, handle_base_width, handle_neck_width)
{
    // The user will enter diameter measurements, we use radius measurements in this code;
    scoop_width = p_scoop_width/2;
    scoop_length = p_scoop_length/2;

    // The scoop: an oval to approximate the shape of the scoop.
    scoop_diameter_scale = (scoop_length/scoop_width);
    translate([0,-scoop_length,0])
    {
        scale([1.0,scoop_diameter_scale,1.0])
        {
            circle(scoop_width);
        }
    }

    // This is for the case if you have a long spoon with a narow handle_base_width,
    // and a shorter spoon with a wider handle_base_width. If you enter the max measurements
    // for each spoon, the short spoon would not fit because the base starts to taper.
    // This prevents the base from tapering untill later on.
    d = handle_length/2;
    translate([-handle_base_width/2, handle_length-d, 0])
    square([handle_base_width, d], center=false);

    // The handle: A quadralateral (in this case, a triangle with the top part chopped off).
    // Note to self. Now that I think about it, a quadrilateral would have been much esier.
    // How far to extend the triangle in order to get the correct neck_width.
    extension = (handle_neck_width*handle_length)/(handle_base_width-handle_neck_width);
    // Discard anything that goes past the handle.
    difference(){
        polygon([[(handle_base_width/2.0), handle_length], [(-handle_base_width/2.0), handle_length], ([0, -extension])]);
        polygon([[((handle_neck_width+e)/2.0), -0.1], [(-(handle_neck_width+e)/2.0), -0.1], ([0, -extension-e])]);
    }
}

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

//color([.5, .5, .5, .5]) polygon([[0,-1], [3, 16], [-3, 16]]);

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
