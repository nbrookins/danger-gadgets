// dc-bead-ring
// Configurable 3d printable captive-bead ring
// Copyright 2014-2017 Nicholas Brookins and Danger Creations, LLC
// http://dangercreations.com/
// https://github.com/nbrookins/danger-gadgets.git
// http://www.thingiverse.com/knick


$fn=96;
//which part to print.  
part = 0; // [0:Preview both, 1:Ring, 2:Bead]
//Diameter of ring
diameter = 20;
//thickness of ring
thickness = 2;
//size/ratio of bead as compared to thickness.  adjust upwards alightly from 1.0 to enlarge bead
bead_ratio = 1.1;
//ratio of slot to bead.  .9 usually gives a tight fit.  
slot_ratio = 0.9;
//additional offset to position the bead slot.  tweak this if it isn't centered to your liking
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

