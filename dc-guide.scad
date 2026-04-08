$fn=180;

guide_thickness = 12;
thickness = 2;
radius = 38;
hole_radius = 3.2;
guide_radius = 6;

difference(){
    union(){
        //main
        cylinder(h=thickness, r=radius);

        //guide
        cylinder(h=guide_thickness, r=guide_radius);
    }
    //hole
    translate([0,0,-1])
    cylinder(h=guide_thickness+2, r=hole_radius);    
}