$fn=500;
e = 0.001;


// All Silverware containers.
m_container_height = 55;
m_neck_percent = 0.05;
m_base_percent = 0.2;
m_wall_thickness = 0.8;

// Large Spoons
largeSpoon_handle_neck_width = 9;
largeSpoon_handle_base_width = 22;
largeSpoon_scoop_width = 45;
largeSpoon_scoop_length = 73;
largeSpoon_handle_length = 125;
//spoonContainer(largeSpoon_scoop_width, largeSpoon_scoop_length, largeSpoon_handle_length, largeSpoon_handle_base_width, largeSpoon_handle_neck_width, m_container_height, m_wall_thickness, m_neck_percent, m_base_percent);

// Medium Spoons
mediumSpoon_handle_neck_width = 6;
mediumSpoon_handle_base_width = 21;
mediumSpoon_scoop_width = 36;
mediumSpoon_scoop_length = 56;
mediumSpoon_handle_length = 110;
//spoonContainer(mediumSpoon_scoop_width, mediumSpoon_scoop_length, mediumSpoon_handle_length, mediumSpoon_handle_base_width, mediumSpoon_handle_neck_width, m_container_height, m_wall_thickness, m_neck_percent, m_base_percent);

// Small Spoons
smallSpoon_handle_neck_width = 5;
smallSpoon_handle_base_width = 13;
smallSpoon_scoop_width = 29;
smallSpoon_scoop_length = 45.8;
smallSpoon_handle_length = 90;
//spoonContainer(smallSpoon_scoop_width, smallSpoon_scoop_length, smallSpoon_handle_length, smallSpoon_handle_base_width, smallSpoon_handle_neck_width, m_container_height/4, m_wall_thickness, m_neck_percent, m_base_percent);

// Large Forks
largeFork_handle_neck_width = 8;
largeFork_handle_base_width = 24;
largeFork_width = 27;
largeFork_length = 73;
largeFork_handle_length = 136;
//forkContainer(largeFork_width, largeFork_length, largeFork_handle_length, largeFork_handle_base_width, largeFork_handle_neck_width, m_container_height, m_wall_thickness, m_neck_percent, m_base_percent);

// Small Forks
smallFork_handle_neck_width = 5;
smallFork_handle_base_width = 13;
smallFork_width = 21;
smallFork_length = 50;
smallFork_handle_length = 96;
forkContainer(smallFork_width, smallFork_length, smallFork_handle_length, smallFork_handle_base_width, smallFork_handle_neck_width, m_container_height*0.4, m_wall_thickness, m_neck_percent, m_base_percent);





//-----------------------------------------------------------------------------
// The below code gives an idea of what the containers would look like inside
// a drawr.
//-----------------------------------------------------------------------------
// Drawr width 25 cm.
// drawr length 20 inch, 51 cm
//drawr_width = 25;
//drawr_height = 6;
//drawr_length = 51;
//difference() {
//cube([drawr_width+2*m_wall_thickness, drawr_length+2*m_wall_thickness, drawr_height+2*m_wall_thickness]);
//translate([m_wall_thickness, m_wall_thickness,m_wall_thickness*2])
//cube([drawr_width, drawr_length, drawr_height]);
//}
//translate([m_wall_thickness, m_wall_thickness, m_wall_thickness])
//{
//    spoonContainer(largeSpoon_scoop_width, largeSpoon_scoop_length, largeSpoon_handle_length, largeSpoon_handle_base_width, largeSpoon_handle_neck_width, m_container_height, m_wall_thickness, m_neck_percent, m_base_percent);
//
//    translate([largeSpoon_scoop_width+2*m_wall_thickness,0,0]) {
//        forkContainer(largeFork_width, largeFork_length, largeFork_handle_length, largeFork_handle_base_width, largeFork_handle_neck_width, m_container_height, m_wall_thickness, m_neck_percent, m_base_percent);
//
//
//        translate([largeFork_width+2*m_wall_thickness,0,0]) {
//            spoonContainer(mediumSpoon_scoop_width, mediumSpoon_scoop_length, mediumSpoon_handle_length, mediumSpoon_handle_base_width, mediumSpoon_handle_neck_width, m_container_height, m_wall_thickness, m_neck_percent, m_base_percent);
//
//        }
//    }
//}



module spoonContainer(scoop_width_d, scoop_length_d, handle_length, handle_base_width, handle_neck_width, container_height, wall_thickness, neck_percent, base_percent)
{
    container_width = scoop_width_d + wall_thickness*2;
    container_length = (handle_length + scoop_length_d) + (wall_thickness*2);

    // Translate it so it start in "the corner", like a cube would if not centered.
    translate([container_width/2, scoop_length_d+wall_thickness,0]) {
        difference(){
            translate([(-scoop_width_d/2)-wall_thickness, -scoop_length_d-wall_thickness, 0])
                cube([container_width, container_length, container_height]);

            translate([0,0,wall_thickness]) {
                linear_extrude(container_height,center=false,convexity=4,twist=false) {
                    spoonShape(scoop_width_d, scoop_length_d, handle_length, handle_base_width, handle_neck_width);
                }
            }

            if ((neck_percent + base_percent) <= 1.0)
            {
                grab_box_length = handle_length*(1-(neck_percent + base_percent));
                // Inner box, a place to grab the utencil.
                translate([(-scoop_width_d/2), neck_percent*handle_length, wall_thickness])
                    cube([container_width-(2*wall_thickness), grab_box_length, container_height]);
            }
        }
    }
}

module spoonShape(scoop_width_d, scoop_length_d, handle_length, handle_base_width, handle_neck_width)
{
    margin = 1;
    // The user will enter diameter measurements, we use radius measurements in this code;
    scoop_width_r = scoop_width_d/2;
    scoop_length_r = scoop_length_d/2;

    // The scoop: an oval to approximate the shape of the scoop.
    scoop_diameter_scale = (scoop_length_r/scoop_width_r);
    translate([0,-scoop_length_r,0])
    {
        scale([1.0,scoop_diameter_scale,1.0])
        {
            circle(scoop_width_r);
        }
    }

    // This is for the case if you have a long spoon with a narow handle_base_width,
    // and a shorter spoon with a wider handle_base_width. If you enter the max measurements
    // for each spoon, the short spoon would not fit because the base starts to taper.
    // This prevents the base from tapering untill later on.
    d = handle_length/2;
    translate([-handle_base_width/2, handle_length-d, 0])
    square([handle_base_width, d], center=false);

    // Shape of the handle as a quadralatierall.
    polygon([[(handle_base_width/2.0), handle_length], [(-handle_base_width/2.0), handle_length], [-(handle_neck_width/2), -margin], [handle_neck_width/2, -margin]]);
}

module forkContainer(fork_width, fork_length, handle_length, handle_base_width, handle_neck_width, container_height, wall_thickness, neck_percent, base_percent)
{
    container_width = fork_width + wall_thickness*2;
    container_length = (handle_length + fork_length) + (wall_thickness*2);

    translate([container_width/2, fork_length+wall_thickness,0]) {
        difference(){
            translate([-(fork_width/2)-wall_thickness, -fork_length-wall_thickness, 0])
                cube([container_width, container_length, container_height]);

            translate([0,0,wall_thickness]) {
                linear_extrude(container_height,center=false,convexity=4,twist=false) {
                    forkShape(fork_width, fork_length, handle_length, handle_base_width, handle_neck_width);
                }
            }

            if ((neck_percent + base_percent) <= 1.0)
            {
                grab_box_length = handle_length*(1-(neck_percent + base_percent));
                // Inner box, a place to grab the utencil.
                translate([(-fork_width/2), neck_percent*handle_length, wall_thickness])
                    cube([container_width-(2*wall_thickness), grab_box_length, container_height]);
            }
        }
    }
}
module forkShape(fork_width, fork_length, handle_length, handle_base_width, handle_neck_width)
{
    margin = 10;

    translate([0,-fork_length/2,0])
    square([fork_width, fork_length], true);

    // This is for the case if you have a long spoon with a narow handle_base_width,
    // and a shorter spoon with a wider handle_base_width. If you enter the max measurements
    // for each spoon, the short spoon would not fit because the base starts to taper.
    // This prevents the base from tapering untill later on.
    d = handle_length/2;
    translate([-handle_base_width/2, handle_length-d, 0])
    square([handle_base_width, d], center=false);

    // Shape of the handle as a quadralatierall.
    polygon([[(handle_base_width/2.0), handle_length], [(-handle_base_width/2.0), handle_length], [-(handle_neck_width/2), -margin], [handle_neck_width/2, -margin]]);
}

// Ultimaker 2 build volume
// 23 x 22.5 x 20.5cm
