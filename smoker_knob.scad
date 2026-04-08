$fn=120;

difference(){
  union(){
      translate([0,0,22]) {
      difference(){
      hull(){
        cylinder(h=4, r=22 );
        translate([0,0,-3])
          sphere(r=15);
      }
          translate([0,0,-18])
        cylinder(h=18, r=28 );
        
        for (i =[0:(5-1)]) rotate([0,0,360/5*i])
          translate([0,17,12.2])
            sphere(r=8);
      }
    }
    
    cylinder(h=24, r=5);
  }
  
  difference(){
    translate([0,0,-.1])
    cylinder(h=24, r=3.1);

    translate([-2.4,0,12])      
    cube([1.5,8,24], center=true);
  }
}



    
