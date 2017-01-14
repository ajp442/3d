
inner_diameter = 3.5;
outer_diameter = 5;
washer_height = 2.5;
e=.01;
ee=.005;

$fn = 50;

difference() {
	cylinder(washer_height, d=outer_diameter);
	translate([0,0,-ee]) {
		cylinder(washer_height+e, d=inner_diameter);
	}
}
