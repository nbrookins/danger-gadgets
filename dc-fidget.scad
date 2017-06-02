// dc-fidget-spinner
// Configurable DIY fidget spinner design
// Copyright 2014-2017 Nicholas Brookins and Danger Creations, LLC
// http://dangercreations.com/
// https://github.com/nbrookins/danger-gadgets.git
// http://www.thingiverse.com/knick

$fn=96;

body_thickness = 7.5;
body_hole_diameter = 22;
body_diameter = 38;

arms = 3;
arm_length = 30;
arm_hole_diameter = 22;
arm_hole_sides = 0;
arm_thickness = 3.5;
arm_hull_center = 30;

ahs = (arm_hole_sides==0) ? 96 : arm_hole_sides;
arm_diam = arm_hole_diameter + arm_thickness;

difference(){
    union(){
        if(arms==4){
            difference(){
                hull(){
                    translate([0,arm_length,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([0,arm_length,-.01])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
            difference(){
                hull(){
                    translate([0,-arm_length,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([0,-arm_length,-.01])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
        }

        if(arms==4 || arms==2){
            difference(){
                hull(){
                    translate([arm_length,0,0])
                    rotate([0,0,30])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([arm_length,0,-.01])
                rotate([0,0,30])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
        }
        difference(){
            hull(){
                translate([-arm_length,0,0])
                rotate([0,0,30])
                cylinder(d=arm_diam, h=body_thickness);
                cylinder(d=arm_hull_center, h=body_thickness);
            }
            translate([-arm_length,0,-.01])
            rotate([0,0,30])
            cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
         }
         
         if(arms==3){
             difference(){
                hull(){
                    translate([arm_length*.5,arm_length*.87,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }
                translate([arm_length*.5,arm_length*.87,-0.01])
                rotate([0,0,30])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
            difference(){
                 hull(){
                    translate([arm_length*.5,-arm_length*.87,0])
                    cylinder(d=arm_diam, h=body_thickness);
                    cylinder(d=arm_hull_center, h=body_thickness);
                }   
                translate([arm_length*.5,-arm_length*.87,-0.01])
                rotate([0,0,30])
                cylinder(d=arm_hole_diameter, h=body_thickness*2, $fn=ahs);
            }
        }  
        
        //main body
        cylinder(d=body_diameter, h=body_thickness);
    }    

    //center hole
    translate([0,0,-1])
    cylinder(d=body_hole_diameter, h=body_thickness*2);
}
