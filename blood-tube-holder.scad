$fn = 100;  //set high quality render

body_core_height = 15;
body_width = 25;
body_length = 25;
body_taper_width = 20;
body_taper_length = 25;
body_taper_offset = 20;
body_thickness = 4;

module body(){
    difference(){
        hull(){
            //main body
            translate([0,0,body_core_height/2])cube([body_width, body_length, body_core_height], center=true);
            //top extension
            translate([0,0,body_taper_offset + body_core_height/2]) cube([body_taper_width, body_taper_length, body_thickness], center=true);
        }
        //subtract the inner core
        hull(){
            translate([0,0,body_core_height/2 + body_thickness/2]) cube([body_width-body_thickness, body_length+1, body_core_height-body_thickness/2], center=true);
            translate([0,0,body_taper_offset + body_core_height/2 - body_thickness/2]) cube([body_taper_width-body_thickness, body_taper_length+1, body_thickness], center=true);
        }
        //side cut
        translate([0,0,body_core_height/2+ body_thickness*2]) cube([body_width+1, body_taper_length-body_thickness*3, body_core_height+body_taper_offset-body_thickness*3], center=true);
    }
}

module tube_holder(){}

module interface(){}

body();