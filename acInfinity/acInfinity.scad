$fn=100;
//$fa = 20;
e = 0.1;

// Metric socket flat head
// 4mm x 0.7mm x 20mm

// Metric hex nut
// 4mm x 0,7mm

use <square_round_connector.scad>;

fan_depth = 35.5; // How deep/tall the fan is.
fan_side_length = 128; // Length and width of the fan box.
fan_flange = 160; // Flaps that come out from the fan body that has the screw holes in it.

inside= 1;  // [1:inside, 2:outside]
wall_thickness = 0.8; // Wall thickness.
square_side = fan_side_length+wall_thickness; // Length of side of square section.
square_length = fan_depth; // Length of square section.
transition_length = square_length; // Length of transition section.
round_diameter = 149; // Diameter of round section.
round_length = transition_length; // Length of round section.
layers= 10; // Number of steps in the transition - large is quite slow.



// Uncomment to see fan & shroud together.
//color("black") { acInfinityFan(); }
//translate([0,0,wall_thickness+e]) { acInfinityFanShroud(); }

acInfinityFanShroud();

// A model of the fan itself.
module acInfinityFan()
{
	translate([0,0,(fan_depth/2)]) {
		cube([fan_side_length,fan_side_length,fan_depth], true);
	}

	difference() {
		translate([0,0,(wall_thickness/2)]) {
			cube([fan_flange,fan_flange,wall_thickness], true);
		}


        // Screw Holes, one in each quadrant.
		for(i=[1,-1])
		{
			for(j=[1,-1])
			{
				translate([(i*fan_flange/2-i*9.3),(j*fan_flange/2-j*9.3),-e]) {
					cylinder(2+1,d=5.3,true);
				}
			}
		}
	}
}


// The shroud/adapter that goes around the fan to make it so it can hook up to
// 6 inch flexable dryer duct with a circle clamp.
module acInfinityFanShroud() {
	rotate([0,0,45]) {
		square_round_connector(inside, wall_thickness, square_side, square_length, transition_length, round_diameter, round_length, layers);
	}

	difference() {
        // Flanges that stick off to the side with the screw holes.
		translate([0,0,(wall_thickness)/2]) {
			cube([fan_flange,fan_flange,wall_thickness], true);
		}

        // Square hole where the fan slides in.
		translate([0,0,(wall_thickness+e)/2]) {
			cube([fan_side_length,fan_side_length,wall_thickness+2*e], true);
		}

        // Screw holes, one in each quadrant.
		for(i=[1,-1])
		{
			for(j=[1,-1])
			{
				translate([(i*fan_flange/2-i*9.3),(j*160/2-j*9.3),-e]) {
					cylinder(2+1,d=5.3,true);
				}
			}
		}
	}
}
