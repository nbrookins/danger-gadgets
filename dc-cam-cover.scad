// dc-flask-base
// Configurable flared base for flasks, test tubes or other cylindrical objects
// Copyright 2014-2016 Nicholas Brookins and Danger Creations, LLC
// http://dangercreations.com/
// https://github.com/nbrookins/danger-gadgets.git
// http://www.thingiverse.com/knick

fnv=128;

//diameter of the hole, should be about the same as the vessel you'd like to hold
inside_diameter = 55;
//depth of the hole
inside_depth = 18;
//thickness of the material under the vessel.  This can be 0 to make it go through, or as high as you'd like to lift the vessel
bottom_thickness = 0;
//width of the extra supporting flare.  should be greater than the inside_diameter, but smaller than outside_diameter.
flare_diameter = 55;
//the width of the overall base
outside_diameter = 57;
//thickness of the outside edge
outside_thickness = 1;

union(){
	difference(){
		union(){
			cylinder(d1=flare_diameter+ outside_thickness*2, d2=inside_diameter + outside_thickness*2, h= inside_depth + bottom_thickness, $fn=fnv);
			translate([0,0,-outside_thickness])
			cylinder(d1=outside_diameter, d2=flare_diameter+ outside_thickness*2, h=outside_thickness, $fn=fnv);
            
		//	translate([0,0,-outside_thickness*3])
		//	cylinder(d1=outside_diameter, d2=outside_diameter, h=outside_thickness, $fn=fnv);
			
		}
		translate([0,0,bottom_thickness +.01])
		cylinder(d=inside_diameter, h=inside_depth, $fn=fnv);
        
        translate([0,inside_diameter/1.5,0])
        cube([inside_diameter, inside_diameter, inside_diameter], center=true);
	}
}

//55 diam