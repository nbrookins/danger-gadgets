h=28;
w=77;
l=148;

$fn = 180;

br = 45;
//cube([w,l,h]);
difference(){
union(){
//translate([-5,l-9,-5])
//cube([w+10,15,h+4.9]);

translate([-5,-6,-5])
cube([w+10 + br,15,h+4.9]);

translate([w+br/2+h/2  -2,-6,h/4+2.8])
rotate([0,40,0])
cube([w+ br-15, 15, h-4]);

translate([w+br/2+h/2 +18 -2,-6 ,  h/4+2.8  +h/3*2.05 -9-1.3])
rotate([0,40,0])
cube([w+ br-25, 30, h/5]);

}


cube([w,l,h]);
}