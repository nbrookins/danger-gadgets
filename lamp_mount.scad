$fn=180;
intersection(){
cylinder(r=5.9*25.4, h=4);

translate([5.5*25.4,0,0])
cylinder(r=1.5*25.4, h=4.2);

}
difference(){
translate([5.75*25.4,0,0])
cylinder(r=.6*25.4, h=4);

translate([5.75*25.4,0,-.1])
cylinder(r=.4*25.4, h=4.2);

}