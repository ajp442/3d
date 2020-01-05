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

module CanInsert(can_height, outer_can_diameter, inner_can_diameter, insert_height_percent, outer_sleve_height, wall_thickness, gap)
{
    e = 0.1;
    ee = 1;
    outer_sleve_diameter = outer_can_diameter + gap;
    inner_sleve_diameter = inner_can_diameter - gap;
    insert_height = can_height * insert_height_percent;
    inner_sleve_height = insert_height - (inner_sleve_diameter/2);

    shave = 23;

    translate([0,0,-shave])
    {
        // Dome with holes.
        difference() {
            difference() {
                sphere(d=inner_sleve_diameter);
                sphere(d=inner_sleve_diameter-2*wall_thickness);
                // Drainage holes.
                for(j=[30:20:80])
                {
                    for(i=[0:40:360])
                    {
                        rotate([j,0,i]) {
                            translate([0,0,(inner_sleve_diameter/2)-wall_thickness-e])
                                cylinder(wall_thickness+ee, d=2);
                        }
                    }
                }
            }

            // Removes part of the hollow sphere that would be inside the inner sleve.
            translate([0,0,-inner_sleve_diameter/2]) {
                cylinder(inner_sleve_diameter/2+shave, d=inner_sleve_diameter, true);
            }
        }
    }
}

