// Customizable Cube Gears
// Note: the assembly is animated
// FPS 20, Steps 40

use <MCAD/involute_gears.scad>
//use <../pin2.scad>

choose(i=object);

//Choose which part to render (assembly is only for viewing)
// [0:First Word Gear, 1:Second Word Gear, 2:Third Word Gear, 3:Fourth Word Gear,
// 4:Center, 5:Small Gear, 6:Pin, 7:Plate, 8:Assembly, 9:Assemply without pins, 10 pins only,
// 11 word corners]
object=11;

//Numbers of teeth on gears
type=0;//[0:18 & 9,1:9 & 6,2:18 & 15]

//Space between gear teeth.
Backlash=0.5;

//Words on large gears.
words = ["Tigers", "Football", "Lineman", "DI", "Band", "xBox One", "4-Wheeler", "Shooting", "SDSM&T", "Fjelstad", "Nathan", "Groton SD"];
//words = ["Star Trek", "starship",  "Enterprise", "Kirk", "Spock", "McCoy", "Data", "Klingon", "Vulcan",  "Gagh", "Ceti eel", "sehlat"];
//words = ["Raven", "Viper 4", "Slingshot", "Viper Pro", "E Pro", "SmarTrax", "Cruizer", "Hawkeye", "RTK", "Accuboom", "Multi-Hybrid", "Autoboom"];
//words = ["hack", "the", "planet", "science", "math", "physics", "lisp", "C", "python", "encript", "sort", "search"];
//words = ["corner_0", "corner_0", "corner_0", "corner_1", "corner_1", "corner_1", "corner_2", "corner_2", "corner_2", "corner_3", "corner_3", "corner_3"];

fontsize=6;


//use <utils/build_plate.scad>
////for display only, doesn't contribute to final object
//build_plate_selector = 0; //[0:Replicator 2,1:Replicator,2:Thingomatic,3:Manual]
////when Build Plate Selector is set to "manual" this controls the build plate x dimension
//build_plate_manual_x = 100; //[100:400]
////when Build Plate Selector is set to "manual" this controls the build plate y dimension
//build_plate_manual_y = 100; //[100:400]

rf1=50*1;// distance from center of cube to end of gear 1 (before clipping)
$fs=0.5*1;// adjust number of faces in holes

NR=[[18,9,0.7493,0.3746,1],
	[9,6,0.6860,0.4573,2],
	[18,15,0.6285,0.5238,5]];

Nr=NR[type];
n1=Nr[0];// number of teeth on gear 1
n2=Nr[1];// number of teeth on gear 2
r1=Nr[2];// these two numbers come from gearopt.m
r2=Nr[3];
nt=Nr[4];// number of turns per cycle
cp=0.28*1;// percentage of rf1 for the center block
dc=rf1/sqrt(1-pow(r1,2));
theta=asin(1/sqrt(3));
pitch=360*r1*dc/n1;
rf2=sqrt(pow(dc,2)-pow(r2*dc,2));

module choose(i=0){
    if (i==0){ // Large gear 0
        gear1(words[i*3], words[(i*3)+1], words[(i*3)+2]);
    }
    else if(i==1){ // Large gear 1
        gear1(words[i*3], words[(i*3)+1], words[(i*3)+2]);
    }
    else if(i==2){ // Large gear 2
        gear1(words[i*3], words[(i*3)+1], words[(i*3)+2]);
    }
    else if(i==3){ // Large gear 3
        gear1(words[i*3], words[(i*3)+1], words[(i*3)+2]);
    }
	if(i==4)translate([0,0,rf1*cp])center(); // Center
	else if(i==5)gear2(); // Small
	else if(i==6)pinpeg();
	else if(i==7){
		for(j=[0:3]){
			translate([40*(j-1.5),40*(j%2),0])rotate([0,0,10])gear1(words[j*3], words[(j*3)+1], words[(j*3)+2]);
			translate([40*(j-1.5),40*((j+1)%2),0])rotate([0,0,10])gear2();
			translate([20*j,-40,0])pinpeg();
			translate([20*(j-0.5),-40,0])pinpeg();
		}
		translate([-40,-40,rf1*cp])center();
	}
	else if(i==8)assembly();
    else if(i==9) {
        		for(j=[0:3]){
			translate([40*(j-1.5),40*(j%2),0])rotate([0,0,10])gear1(words[j*3], words[(j*3)+1], words[(j*3)+2]);
			translate([40*(j-1.5),40*((j+1)%2),0])rotate([0,0,10])gear2();
		}
		translate([-40,-40,rf1*cp])center();
    }
    else if(i==10){
		for(j=[0:3]){
			translate([20*j,-40,0])pinpeg();
			translate([20*(j-0.5),-40,0])pinpeg();
		}
	}
    else if(i==11){
        for(j=[0:3]){
            translate([40*(j-1.5),40*(j%2),0])rotate([0,0,10])gear1(words[j*3], words[(j*3)+1], words[(j*3)+2]);
        }
    }
}

module assembly()
rotate([0,0,45]){
	rotate([theta+90,0,0])center();
	twogears(words[0], words[1], words[2]);
	rotate([0,0,180])twogears(words[3], words[4], words[5] );
	rotate([180,0,90])twogears(words[6], words[7], words[8]);
	rotate([180,0,-90])twogears(words[9], words[10], words[11]);
}

module twogears(word1, word2, word3){
	rotate(a=[0,90-theta,90])rotate([0,0,nt*120*$t])translate([0,0,rf1*cp])gear1(word1, word2, word3);
	rotate(a=[0,90-theta,0])rotate([0,0,-nt*n1/n2*120*$t])translate([0,0,rf2*cp])gear2();
}

module center(){
intersection(){
	box();
	rotate([2*(90-theta),0,0])box();
	rotate([2*(90-theta),0,120])box();
	rotate([2*(90-theta),0,-120])box();
	rotate(-[theta+90,0,0])rotate([0,0,45])cube(0.85*rf1,center=true);
}}

module box(){
render(convexity=2)
translate([0,0,(rf2-rf1)*cp/2])difference(){
	cube(size=[dc,dc,(rf1+rf2)*cp],center=true);
	translate([0,0,-(rf1+rf2)*cp/2])pinhole(fixed=true,fins=false);
	rotate([180,0,0])translate([0,0,-(rf1+rf2)*cp/2])pinhole(fixed=true,fins=false);
}}

module gear1(word1="", word2="", word3=""){
    render()
    intersection(){
        translate([0,0,-rf1*cp])rotate([0,theta-90,0])rotate([0,0,45])difference(){
            cube(size=rf1, center=true);	
            place_word(word1);
            rotate([-90,0,-90])place_word(word2);
            rotate([90,-90,0])place_word(word3);
        }
        
        difference(){	
            translate([0,0,rf1*(1-cp)])rotate([180,0,90/n1])
            bevel_gear (number_of_teeth=n1, 
                outside_circular_pitch=pitch, 
                cone_distance=dc,face_width=dc*(1-cp), 
                bore_diameter=0, 
                backlash=Backlash, 
                finish=0);	
            pinhole(fixed=false);	
        }
        
    }
}

module gear2(){
render()
intersection(){
	translate([0,0,-rf2*cp])rotate([0,theta-90,0])rotate([0,0,45])cube(size=rf1, center=true);
	difference(){
		translate([0,0,rf2*(1-cp)])rotate([180,0,90/n2])
		bevel_gear (number_of_teeth=n2,
			outside_circular_pitch=pitch,
			cone_distance=dc,
			face_width=dc*(1-cp),
			bore_diameter=0,
			backlash=Backlash,
			finish=0);
		pinhole(fixed=false);
	}
}}


module place_word(word) {
    // [x,move up and down, increase/decreas letter depth]
    rotate([0,0,45-180])translate([0,rf1*0.20,rf1*.490])linear_extrude(height=3, convexity=4)text(word, halign="center", size=fontsize);
}


module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[2,5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}

// Parametric Snap Pins (http://www.thingiverse.com/thing:213310)

module pin(r=3.5,l=13,d=2.4,slot=10,nub=0.4,t=1.8,space=0.3,flat=1)
translate(flat*[0,0,r/sqrt(2)-space])rotate((1-flat)*[90,0,0])
difference(){
	rotate([-90,0,0])intersection(){
		union(){
			translate([0,0,-0.01])cylinder(r=r-space,h=l-r-0.98);
			translate([0,0,l-r-1])cylinder(r1=r-space,r2=0,h=r-space/2+1);
			translate([nub+space,0,d])nub(r-space,nub+space);
			translate([-nub-space,0,d])nub(r-space,nub+space);
		}
		cube([3*r,r*sqrt(2)-2*space,2*l+3*r],center=true);
	}
	translate([0,d,0])cube([2*(r-t-space),slot,2*r],center=true);
	translate([0,d-slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
	translate([0,d+slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
}

module nub(r,nub)
union(){
	translate([0,0,-nub-0.5])cylinder(r1=r-nub,r2=r,h=nub);
	cylinder(r=r,h=1.02,center=true);
	translate([0,0,0.5])cylinder(r1=r,r2=r-nub,h=5);
}

module pinhole(r=3.5,l=13,d=2.5,nub=0.4,fixed=false,fins=true)
intersection(){
	union(){
		translate([0,0,-0.1])cylinder(r=r,h=l-r+0.1);
		translate([0,0,l-r-0.01])cylinder(r1=r,r2=0,h=r);
		translate([0,0,d])nub(r+nub,nub);
		if(fins)translate([0,0,l-r]){
			cube([2*r,0.01,2*r],center=true);
			cube([0.01,2*r,2*r],center=true);
		}
	}
	if(fixed)cube([3*r,r*sqrt(2),2*l+3*r],center=true);
}

module pinpeg(r=3.5,l=13,d=2.4,nub=0.4,t=1.8,space=0.3)
union(){
	pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
	mirror([0,1,0])pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
}
