// Edited from https://www.thingiverse.com/thing:51376

//-----------------------------------------------------------------------
// AAA Battery dimensions
//-----------------------------------------------------------------------
// From Wikipedia
// length: 44.5 mm + 0.8 mm positive terminal button (45.3 mm total)
// diameter: 10.5 mm
//
// My mesurements
// length: 43.7 mm + 1.14 mm positive terminal button  (44.84 mm total)
// diameter: 10.3 mm

//-----------------------------------------------------------------------
// AA Battery dimensions
//-----------------------------------------------------------------------
// From Wikipedia
// length: 49.2–50.5 mm, including the button terminal
// diameter: 13.5–14.5 mm 
//
// My measurements
// length: 50.35 mm
// diameter 14.1 mm

battery_type = "AAA"; // ["AAA", "AA"]
part = "base"; // ["base", "lid"]
// How much of the case should we dedicate to being the lid?
lid_percent = 26.0; // [0.0 : 50.0]

// Number of batteries across
columns = 4; // [1:10]

// Number of batteries deep
rows = 4; // [1:10]

module __Customizer_Limit__ () {}

// Right now we only support "AAA" and "AA"
// We add a little fudge to the battery height and diameter from 
// what we measured, otherwise it is too tight for the batteries to fit.
batteryDiameter = 10.7;
batteryHeight = 46;
if (battery_type == "AA")
{
    batteryDiameter = 14.6;
    batteryHeight = 53;
}

// We will render either the "lid" or "base" depending on what is selected.
insideHeight = batteryHeight * (1 - (lid_percent/100));
if ("lid" == part)
{
    insideHeight = batteryHeight * (lid_percent/100);
}


// thickness of the sides
wall_thickness = 0.8;


// thickness of the bottom layer
base_thickness = 0.8;


// magnet cutouts only appear if there are at least 2 x 2 batteries
magnetType = "cylinder"; // [cylinder, cube]

magnetDiameter = 3.2;

magnetHeight = 3.1;




///////////////////////////////////////////////////////////////////////////


module cylinderAt(r, h, x, y, z) {
	translate([x,y,z]) {
		cylinder(r=r, h=h, center=true);
	}
}

module cubeAt(xy, h, x, y) {
	translate([x,y,0]) {
		cube(size=[xy,xy,h], center=true);
	}
}


module magnetCubeAt(xy, h, x, y, z) {
	translate([x,y,z]) {
		rotate([0,0,45]) {
			cube(size=[xy,xy,h], center=true);
		}
	}
}

module batteryGrid(diameter, height, rows, columns, mtype, mdiameter, mheight) {
	angle = 35;
	r = diameter/2;
	cut = 2*r*sin(angle);
	tan = tan(angle);
	filletOffset = r * tan;
	filletRadius = r/cos(angle) - r;
	xstart = ((columns-1) * diameter)/2;
	ystart = ((rows-1) * diameter)/2;
	eps = 0.1;

	union() {
		difference() {
			union() {
				// cylinder
				for (x=[-xstart:diameter:xstart+eps]) {
					for (y=[-ystart:diameter:ystart+eps]) {
						cylinderAt(r,height,x,y,0);
					}
				}
	
				if (rows > 1) {	
					for (x=[-xstart:diameter:xstart+eps])
					for (y=[-ystart+r:diameter:ystart-r+eps]) {
						cubeAt(cut, height, x, y);
					}
				}
	
				if (columns > 1) {	
					for (x=[-xstart+r:diameter:xstart-r+eps])
					for (y=[-ystart:diameter:ystart+eps]) {
						cubeAt(cut, height, x, y);
					}
				
				}
			}

			if (columns > 1) {	
				for (x=[-xstart+r:diameter:xstart-r+eps])
				for (y=[-ystart-r:diameter:ystart+r+eps])
				for(y2=[filletOffset, -filletOffset]) {
					cylinderAt(filletRadius,height+eps,x,r+y+y2,0);
				}
			}
	
			if (rows > 1) {	
				for (x=[-xstart:diameter:xstart+eps])
				for (y=[-ystart:diameter:ystart+eps])
				for(x2=[filletOffset, -filletOffset]) {
					cylinderAt(filletRadius, height+eps,x + x2, r+y, 0);
				}
			}
		}

		// magnets
		if (rows > 1 && columns > 1) {	
			for (x=[-xstart+r:diameter:xstart-r+eps])
			for (y=[-ystart+r:diameter:ystart-r+eps]) {
				if (mtype == "cylinder") {
					cylinderAt(mdiameter/2, mheight, x, y, height/2-mheight/2);
				} else if (mtype == "cube") {
					magnetCubeAt(mdiameter, mheight, x, y, height/2-mheight/2);
				}
			}
		}
	}
}


module makeTray(diameter, height, rows, columns, wall, base, mtype, mdiameter, mheight) {
	eps = 0.1;
	rounding = diameter/2 + wall;
	width = diameter * columns + wall*2;
	depth = diameter * rows + wall*2;

	union() {
		difference() {
	
			hull()
			for (x=[-width/2 + rounding, width/2 - rounding])
			for (y=[-depth/2 + rounding, depth/2 - rounding]) {
				translate([x,y])
				cylinder(r=rounding, h=height+base);
			}	

			translate([0,0,height/2 + base]) {
				batteryGrid(diameter, height+eps, rows, columns, mtype, mdiameter, mheight+eps);
			}
		}
	}
}


makeTray(batteryDiameter, insideHeight, 
			rows, columns, 
			wall_thickness, base_thickness, 
			magnetType, magnetDiameter, magnetHeight, $fn=90);
