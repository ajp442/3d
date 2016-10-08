use <MCAD/boxes.scad>

//base_length=50;
//base_width=20;
//base_height=2;
//
//hole_length=2;
//hole_width=6;
//
//word_raise_height=0.5;
//word_sink_depth=0.5;
//text_size=9;
//
//raised_text="Unicorn";
//indented_text="Keeper";
//
//cool_font="Norasi:style=Regular";

$fn=50;
KeyChain("Unicorn", "Keeper");

module KeyChain(raised_text, indented_text, text_size=9, font="Norasi:style=Regular", length=50, width=20, height=2, hole_length=2, hole_width=6, word_raise_height=0.5, word_sink_depth=0.5)
{
    base_length = length;
    base_width = width;
    base_height = height;

    union()
    {
        // Extruded text.
        translate([0,0,base_height/2-0.01])
        {
            linear_extrude(height=word_raise_height, convexity=4)
                text(raised_text, 
                        size=text_size,
                        valign="center",
                        halign="center",
                        font=font);
        }


        difference(){

            // Body of keychain.
            roundedBox([base_length, base_width, 2], 1, true);

            // Hole for putting on keyrings.
            translate([base_length/2 - (hole_length + 1) ,0,])
            {            
                roundedBox([hole_length,hole_width,base_height+0.01], 1, true);
            }

            // Indented text.
            mirror( [0, 1, 0] ) 
            {
                translate([0,0,-base_height/2-0.01])
                {
                    linear_extrude(height=word_sink_depth, convexity=4)
                        text("Keeper", 
                                size=text_size,
                                valign="center",
                                halign="center",
                                font=font);
                }
            }
        }
    }
}
