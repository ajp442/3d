//1' = 30.48 cm
//2' = 60.96 cm
//3' = 91.44 cm



// 
// 0.100" x 24" x 48" Clear Acrylic Sheet $31.99 Menards
// 0.118" x 24" x 48" Clear Acrylic Sheet $29.99 Menards
// 0.220" x 24" x 48" Clear Acrylic Sheet $60.87 Menards
// 0.220" x 36" x 72" Clear Colorless Acrylic Sheet $119.00 Mendards
// 0.093" x 36" x 48" Clear Polycarbonate Sheet $69.98 Menards
// 36 in. x 48 in. x .093 in. Acrylic Sheet OPTIX $39.58 HomeDepot
// 0.220" x 36" x 72" Clear Colorless Acrylic Sheet $39.58 HomeDepot
// 24 in. x 48 in. x .093 in. Acrylic Sheet $29.47 HomeDepot


// 0.093 in = 0.23622 cm

ts = 2;
length = 60.96;
width = 91.44;
height = 60.96;

c = 255;
plexiglass_thickness = 0.23622;
glass_color = [204/c, 255/c, 255/c, 40/c];

translate([0, ts+plexiglass_thickness, ts]){
plexiglass(length, width, height);
color("silver")
frame(length, width, height);
}
cart(length, width + plexiglass_thickness*2, height + plexiglass_thickness);

module cart(outside_length, outside_width, outside_height) {
    l = outside_length;
    w = outside_width;
    h = outside_height;
    
    translate([0,0,-20]) {
        // Back left post.
        translate([0, 0, 0,])
        {
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Front right post.
        translate([l-ts, w+ts, 0]){
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Front left post.
        translate([l-ts, 0, 0]) {
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Back right post.
        translate([0, w+ts, 0]) {
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);
    
        // Top left beam.
        translate([0,0, h]) {
            cube([l,ts,ts]);
        } 
        echo("Beam: ", ts, " x ", ts, " x ", l-2*ts);
        
        // Top right beam.
        translate([0,w+ts, h]) {
            cube([l,ts,ts]);
        } 
    }
        
                // Bottom front beam.
        translate([l-ts,ts,0]) {
            cube([ts, w, ts]);
        }
        echo("Beam: ", ts, " x ", ts, " x ", w-2*ts);
        
        // Bottom rear beam.
        translate([0,ts,0]) {
            cube([ts, w, ts]);
        }
         echo("Beam: ", ts, " x ", ts, " x ", w-2*ts);
        
}

module plexiglass(outside_length, outside_width, outside_height) {
    
    l = outside_length;
    w = outside_width;
    h = outside_height;
    
    // Left plexiglass
    translate([0,-plexiglass_thickness,0]) {
        color(glass_color) cube([l, plexiglass_thickness, h]);
    }

    // Right plexiglass
    translate([0,w,0]) {
        color(glass_color) cube([l, plexiglass_thickness, h]);
    }
    echo("plexiglass: ", plexiglass_thickness, " x ", h, " x ", l);

    // Back plexiglass
    translate([-plexiglass_thickness,0,0]) {
        color(glass_color) cube([plexiglass_thickness, w, h]);
    }
    echo("plexiglass: ", plexiglass_thickness, " x ", w, " x ", l);

    // Top plexiglass
//    translate([0,0,h]) {
//        color(glass_color) cube([l, w, plexiglass_thickness]);
//    }
    echo("plexiglass: ", plexiglass_thickness, " x ", w, " x ", l);
}



module frame(outside_length, outside_width, outside_height) {
    l = outside_length;
    w = outside_width;
    h = outside_height;
    
        // Back left post.
        translate([0, 0, 0,])
        {
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Front right post.
        translate([l-ts, w-ts, 0]){
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Front left post.
        translate([l-ts, 0, 0]) {
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Back right post.
        translate([0, w-ts, 0]) {
            cube([ts,ts,h]);
        }
        echo("Post: ", ts, " x ", ts, " x ", h);

        // Top rear beam.
        translate([0,ts,h-ts]) {
            cube([ts, w-2*ts, ts]);
        }
        echo("Beam: ", ts, " x ", ts, " x ", w-2*ts);
        
        // Bottom rear beam.
        translate([0,ts,0]) {
            cube([ts, w-2*ts, ts]);
        }
         echo("Beam: ", ts, " x ", ts, " x ", w-2*ts);

        // Top front beam.
        translate([l-ts,ts,h-ts]) {
            cube([ts, w-2*ts, ts]);
        }
        echo("Beam: ", ts, " x ", ts, " x ", w-2*ts);

        // Bottom front beam.
        translate([l-ts,ts,0]) {
            cube([ts, w-2*ts, ts]);
        }
        echo("Beam: ", ts, " x ", ts, " x ", w-2*ts);

        // Top left beam.
        translate([ts,0, h-ts]) {
            cube([l-2*ts,ts,ts]);
        } 
        echo("Beam: ", ts, " x ", ts, " x ", l-2*ts);

        // Bottom left beam.
        translate([ts,0, 0]) {
            cube([l-2*ts,ts,ts]);
        }
        echo("Beam: ", ts, " x ", ts, " x ", l-2*ts);
        
        // Top right beam.
        translate([ts,w-ts, h-ts]) {
            cube([l-2*ts,ts,ts]);
        } 
        echo("Beam: ", ts, " x ", ts, " x ", l-2*ts);
        
        // Bottom right beam.
        translate([ts,w-ts, 0]) {
            cube([l-2*ts,ts,ts]);
        }
        echo("Beam: ", ts, " x ", ts, " x ", l-2*ts);
        

        // Center support.
        translate([l/2-.5*ts,ts,h-ts]) {
            cube([ts, w-2*ts, ts]);
        }
        echo("large Support ", ts, " x ", ts, " x ", (w/2)-ts);
        
        // Top rear left support
        translate([ts,w/3, h-ts]) {
            cube([l/2-1.5*ts,ts,ts]);
        }
        echo("small Support ", ts, " x ", ts, " x ", l/2-1.5*ts);
        
        // Top front left support
        translate([l/2+.5*ts,w/3, h-ts]) {
            cube([l/2-1.5*ts,ts,ts]);
        }
        echo("small Support ", ts, " x ", ts, " x ", l/2-1.5*ts);
        
        // Top rear right support
        translate([ts,w*(2/3), h-ts]) {
            cube([l/2-1.5*ts,ts,ts]);
        }
        echo("small Support ", ts, " x ", ts, " x ", l/2-1.5*ts);
        
        // Top front right support
        translate([l/2+.5*ts,w*(2/3), h-ts]) {
            cube([l/2-1.5*ts,ts,ts]);
        }
        echo("small Support ", ts, " x ", ts, " x ", l/2-1.5*ts);
}
