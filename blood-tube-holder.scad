$fn = 100;  //set high quality render

//global parameters
body_core_height = 15;
body_width = 25;
body_length = 25;
body_taper_width = 20;
body_taper_length = 25;
body_taper_offset = 20;
body_thickness = 4;

tube_radius = 10/2;
tube_length = 50;

int_height = 8;
int_radius = 18/2;
int_inner_radius = 15/2;

alignment_radius = 1.2;
flange_thickness = 3;
flange_radius = 25/2;
flange_square_size = 22;

module body(){
    difference() {
        union(){
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
            //add tube base
            translate([0,0,body_core_height/2])
            cube([body_width/2 + body_thickness/2, body_length, body_core_height-body_thickness], center=true);
        }
        //subtract alignment hole
        translate([body_width/2 - body_thickness*1.5, body_width/3, body_core_height + body_taper_offset - body_thickness*2])
        cylinder(h = body_thickness *2, r = alignment_radius, center=true);
    }
}

module interface(){
    //starting point
    union(){
        difference() {
            union(){
                //outer tube
                translate([0,0,-int_height/2])
                cylinder(h = int_height, r = int_radius, center=true);

                //TODO: interface flange notches
                translate([0,0,-int_height/2]){
                    intersection() {
                        cylinder(h = flange_thickness, r = flange_radius, center=true);
                        cube ([flange_square_size,flange_square_size, flange_thickness], center=true);
                    }
                }
            }
            //subtract inner hole
            translate([0,0,-int_height/2 -.01])
            cylinder(h = int_height, r = int_inner_radius, center=true);
        }
    }
}

module main(){
    difference() {
        union(){
            body();
            interface();
        }
        //top tube cut (with debug flag for demonstration)
        translate([0,0,body_taper_offset/2])
       # cylinder(h = tube_length, r = tube_radius, center=true);
    }
}

//entry point
main();