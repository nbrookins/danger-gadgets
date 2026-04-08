//parameters
include <media-eng-logo-params-aaron.scad>;//include <media-eng-logo-params-triviastar.scad>;

module gear(){
	difference(){ //base circle and hole
		cylinder(h=height, r=ring_radius, $fn = res, center=true) ;
    cylinder(h=height+2, r=hole_radius, $fn = res, center=true);
    //HACK
    shaft(); //cut shaft out for strength
	}
	for (i = [0 : (cogs-1)]){	//loop cogs around
		hull() rotate(i*360/cogs, [0,0,1])
      translate([ring_radius, 0, 0]){
        cube ([cog_base, cog_base_width, cog_height], center=true);
        translate([cog_length, 0, 0]) cube ([.1, cog_tip_width, tip_height], center=true);
		}
	}
}

module flare(){
  	difference(){ //base circle and hole
  		cylinder(h=height+cog_flare, r=ring_radius-cog_flare_buffer[0], $fn = res, center=true) ;
      cylinder(h=height+2, r=hole_radius+cog_flare_buffer[1], $fn = res, center=true);
      shaft(); //cut shaft out for strength
	}
}

module triangle(ratio, hratio){
    difference(){minkowski(){
        cylinder(d=ring_radius*ratio, h=height*hratio, $fn=3); //triangle
        cylinder(d=ring_radius/8, h=0.1, $fn = res); //round corners
    } translate([0,0,height/2]) shaft();} //remove shaft
}

module shaft(){
    rotate([28,90,0]) translate([0,0,-shaft_length/2 - 5] ) rotate([0,0,45]){
      cylinder(h=shaft_length,r=shaft_radius,$fn = shaft_facets);
      translate([0,0,shaft_length/2-1]) cylinder(h=3,r=shaft_radius+1,$fn = 8);}
}

module base(){
  difference(){
    rotate([28,80,0]) translate([-sphere_radius/8,0,-sphere_radius*1.5])
    difference(){
      resize ([0,0,sphere_radius*1.85]) sphere(r = sphere_radius, $fn=res); //trim bottom
      translate([0,0,-sphere_radius*.8]) cube([sphere_radius*2,sphere_radius*2,sphere_radius*2], center=true);}
    minkowski(){ hull() gear(); cylinder(d=ring_radius/8, h=1.5, $fn = res);}
    medallion(2.5, 2.5); //slice out the bottom
  }
}

module medallion(h, rad, t, to){
 rotate([28,80,0]) translate([-sphere_radius/8, 0, -sphere_radius*1.3-.01])
    if (!to) difference(){cylinder(h=h, r=sphere_radius-rad, $fn=res);
    if(t) translate([0,0,-h*2-.84]) make_text();} //carve out text
    else translate([0,0,-h*2-.84]) make_text(); //insert text
}

module make_text(){
   rotate ([0,0,90]) translate([0, len(txt)*txt_size[0]/2 *0.92, sphere_radius*.2 -1.01])  linear_extrude(height = 0.5)
    for (i = [0:len(txt)-1]) translate([0,txt_spc[i], 0])
      mirror([1, 0, 0]) text(text = txt[i], font = fnt, size = txt_size[i], halign = "center");
}

translate([0,0,height/2]){
  if (part==0 || part==1) color(clr[1]) base();
  if (part==0 || part==2) color(clr[2]) gear();
  if (part==0 || part==3) color(clr[3]) shaft();
  if (part==0 || part==7) color(clr[7]) medallion(1.5, 2.75, true);
  if (part==0 || part==8) color (clr[8]) medallion(1.5, 0, true, true);
  if (part==0 || part==9) color (clr[9]) flare();
}
if (part==0 || part==4) color(clr[4]) triangle(1.03, .88);
if (part==0 || part==5) color(clr[5]) triangle(.75, .92);
if (part==0 || part==6) color(clr[6]) triangle(.6, .99);
