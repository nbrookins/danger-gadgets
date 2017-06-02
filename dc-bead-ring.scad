// dc-bead-ring
// Configurable 3d printable captive-bead ring
// Copyright 2014-2017 Nicholas Brookins and Danger Creations, LLC
// http://dangercreations.com/
// https://github.com/nbrookins/danger-gadgets.git
// http://www.thingiverse.com/knick


$fn=96;

part = 0;
diameter = 20;
thickness = 2;
bead_ratio = 1.1;
slot_ratio = 0.9;
slot_offset = 0;

bead_radius = thickness * 1.5 * bead_ratio;

if (part ==0 || part == 1){
    difference(){
        rotate_extrude(convexity=1)
         translate([diameter/2, 0, 0])	
        circle(r = thickness);
        
        translate([diameter/2 + (bead_radius/2-thickness) + slot_offset,0,0])
        sphere(r=bead_radius * slot_ratio);
    }
}
if (part ==0 || part == 2){
    sphere(r=bead_radius);
}

