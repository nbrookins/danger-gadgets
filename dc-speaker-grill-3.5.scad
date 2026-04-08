$fn=180;

top_thickness = 1.5;
bottom_thickness = 0.1;
panel_thickness = 5.7;
panel_radius = 37.5;//77
hole_radius = 40.2;
top_inner_flange = .75;
top_outer_flange =0;
top_chamfer = 0;//1.2;

grill_radius=2.2;
grill_thickness=2.5;

wall_thickness = hole_radius-panel_radius;
grill_trim=grill_radius*2-grill_thickness;
//todo - bottom out chamfer
difference(){
union(){
    difference(){
        //slug
        translate([0,0,-top_thickness])
        union(){
            //main
            cylinder(h=panel_thickness + top_thickness + bottom_thickness, r=panel_radius+wall_thickness);

            //bottom flange
            translate([0,0,bottom_thickness/2])
            cylinder(h=bottom_thickness/2, r1=panel_radius+wall_thickness, r2=panel_radius+wall_thickness);
            cylinder(h=bottom_thickness/2, r=panel_radius+wall_thickness);
            
            //top flange
            translate([0,0,+panel_thickness+bottom_thickness]){
                translate([0,0,top_thickness/2])
                cylinder(h=top_thickness/2, r1=panel_radius+wall_thickness+top_outer_flange, r2=panel_radius+wall_thickness+top_outer_flange-top_chamfer);
                cylinder(h=top_thickness/2, r=panel_radius+wall_thickness+top_outer_flange);
            }
        }
        
        //center top
        translate([0,0,+top_thickness+.1])
        cylinder(h=panel_thickness + top_thickness, r=panel_radius-top_inner_flange);
        
        //center top chamfer
        translate([0,0,+panel_thickness+bottom_thickness-top_thickness/2+.1])
        cylinder(h=top_thickness/2, r1=panel_radius-top_inner_flange, r2=panel_radius-top_inner_flange+top_chamfer);
        
        //center bottom
        translate([0,0,-bottom_thickness-top_thickness])
        cylinder(h=panel_thickness + bottom_thickness, r1=panel_radius, r2=panel_radius);

        //panel
 //       cylinder(h=panel_thickness, r=panel_radius);
    }
    
//  for (i = [-2:2 ])    
 * translate([-panel_radius,0,panel_thickness-grill_radius+grill_trim+.09])
    rotate([90,0,90])
    difference(){
        cylinder(h=panel_radius*2, r=grill_radius);
        translate([-grill_radius,grill_radius-grill_trim,-.5])
        cube([grill_radius*2, grill_trim, panel_radius*2+1]);
        translate([-grill_radius,-grill_radius-1,-.5])
        cube([grill_radius*2, grill_trim, panel_radius*2+1]);
    }

    translate([0,0,panel_thickness-grill_radius/2+.091]){
        cube([panel_radius*2,grill_radius*2,grill_radius], center=true);
        cube([grill_radius*2,panel_radius*2,grill_radius], center=true);
    }

    translate([0, 0, panel_thickness-grill_radius+.091])    
    rotate_extrude(convexity = 10)
    translate([24.25, 0, 0])
    square([grill_radius*2,grill_radius]);
     
    translate([0, 0, panel_thickness-grill_radius+.091])//+grill_trim/2 +.09])    
    rotate_extrude(convexity = 10)
    translate([13.5, 0, 0])
    square([grill_radius*2,grill_radius]);//,grill_radius*2,grill_radius*2])

    translate([0, 0, panel_thickness-grill_radius+.091])//+grill_trim/2 +.09])    
    rotate_extrude(convexity = 10)
    translate([3, 0, 0])
    square([grill_radius*2,grill_radius]);
}

   translate([0, 0, -2])
   cylinder(h=8,r=grill_radius+.5);

}