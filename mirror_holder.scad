$fn=120;

cover = false;

difference(){
    union(){
        hull(){
            cylinder(h=.5, r=20.5);
            translate([0,0,16])
                sphere(r=10);
        }

        if (cover)
            translate([0,0,40])
            rotate([0,90,0])
            cylinder(h=3, r=25.6 + 1.5);
    }    
    if (cover)
        translate([1.5,0,40])
        rotate([0,90,0])
        cylinder(h=10, r1=25.5, r2=25.1);
    else
        translate([-.7,0,40])
        rotate([0,90,0])
        cylinder(h=1.4, r=25.4);
 }
    
