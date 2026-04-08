$fn=120;

difference(){
    hull(){
        cylinder(h=.5, r=12.5);
        translate([0,0,8])
            sphere(r=6);
    }

    translate([-25,0,6.5])
      rotate([0,90,0])
        cylinder(r=4.5, h=50);
        
*      translate([0,0,6.5])
          sphere(r=4.75);
    
    for(i=[-1:2:1])
        hull(){
         translate([0,0,6.5])
          sphere(r=4.);
        translate([i*8,0,6.5])
            sphere(r=5.75);
    }
    translate([0,0,6])
        cylinder(r=.5, h=10);    
}