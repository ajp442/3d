
$fn=50;

m_gap=0.5;
m_wall_thickness = 0.8;
m_can_height = 113;
m_outer_can_diameter = 76.5;
m_inner_can_diameter = 66;
m_can_lip = 4.5;
m_insert_height_percent = 0.85;
m_outer_sleve_height = 20;



CanInsert(m_can_height, m_outer_can_diameter, m_inner_can_diameter, m_insert_height_percent, m_outer_sleve_height, m_wall_thickness, m_gap);
// Model of the can.
//inner_can_diameter = can_diameter - (2*can_lip);
//difference(){
//    cylinder(can_height, d=can_diameter, true);
//    translate([0,0,can_lip])
//    cylinder(can_height, d=inner_can_diameter, true);
//}

module CanInsert(can_height, outer_can_diameter, inner_can_diameter, insert_height_percent, outer_sleve_height, wall_thickness, gap)
{
    e = 0.1;
    ee = 1;
    outer_sleve_diameter = outer_can_diameter + gap;
    inner_sleve_diameter = inner_can_diameter - gap;
    insert_height = can_height * insert_height_percent;
    inner_sleve_height = insert_height - (inner_sleve_diameter/2);

    // The outer sleve.
    difference() {
        cylinder(outer_sleve_height, d=outer_sleve_diameter + 2*wall_thickness, true);
        cylinder(outer_sleve_height, d=outer_sleve_diameter, true);
    }

    // The inner sleve.
    difference() {
        cylinder(inner_sleve_height, d=inner_sleve_diameter, true);
        cylinder(inner_sleve_height, d=inner_sleve_diameter - 2*wall_thickness, true);
    }

    // Bottom flat part that connects the inner and outer sleves.
    difference() {
        cylinder(wall_thickness, d=outer_sleve_diameter + 2*wall_thickness, true);
        cylinder(wall_thickness, d=inner_sleve_diameter - 2*wall_thickness, true);
    }


    // Dome with holes.
    difference() {
        translate([0,0,inner_sleve_height]) {
            difference() {
                sphere(d=inner_sleve_diameter);
                sphere(d=inner_sleve_diameter-2*wall_thickness);
                // Drainage holes.
                for(j=[-90:10:90])
                {
                    for(i=[-90:30:90])
                    {
                        rotate([j,0,i]) {
                            translate([0,0,(inner_sleve_diameter/2)-wall_thickness-e])
                                cylinder(wall_thickness+ee, d=2);
                        }
                    }
                }
            }
        }
        // Removes part of the hollow sphere that would be inside the inner sleve.
        translate([0,0,-inner_sleve_diameter]) {
            cylinder(inner_sleve_height+inner_sleve_diameter, d=inner_sleve_diameter-2*wall_thickness, true);
        }
    }
}

