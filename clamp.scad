$fn=180;
l = 5.5;
w = 1.5;

difference(){
union(){

difference(){
cube([l,w,2]);


//notches
translate([l+.1,w+.01,1.85])
rotate([90,30,0])
cylinder(r=1, h=w+.2, $fn=3);


translate([l+.1,w+.01,1.3])
rotate([90,30,0])
cylinder(r=1, h=w+.2, $fn=3);

translate([l+.1,w+.01,.8])
rotate([90,30,0])
cylinder(r=1, h=w+.2, $fn=3);


translate([l,w+.01,.3])
rotate([90,30,0])
cylinder(r=1, h=w+.2, $fn=3);

//cord cuts
translate([ l/3,w+.01,-.1])
rotate([90,0,0])
scale([1,.2,1])
cylinder(r=1, h=w+.2);

translate([ l/1.5,w+.01,-.1])
rotate([90,0,0])
scale([1,.2,1])
cylinder(r=1, h=w+.2);



}

rotate([0,10,0]){
translate([0,0,-2.5])
cube([l+.7,w,2]);

difference(){
union(){

translate([l-.15,0,-2.5])
cube([1,w,3.2]);

//latches
translate([l,w,1.05])
rotate([90,30,0])
cylinder(r=1, h=w, $fn=3);


translate([l,w,.5])
rotate([90,30,0])
cylinder(r=1, h=w, $fn=3);

translate([l,w,-.3])
rotate([90,30,0])
cylinder(r=1, h=w, $fn=3);
}
translate([l-.5,-.5,1.4])
cube([1,3,1]);

}


}


rotate([90,0,0])
translate([.25,-.15,-w])
difference(){
  cylinder(h=w,r=2.4, );

  translate([01,0,-.01])
  cylinder(h=w+.2,r=1.);
    translate([1.75,0,-.01])
  cylinder(h=w+.2,r=1.0);
}
}

rotate([90,0,0])
translate([-1.25,-.15,-w])
    translate([1.2,0,-.01])
  cylinder(h=w+.2,r=.8);
}