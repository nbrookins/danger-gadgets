$fn=180;

top_thickness = 1.65;
bottom_thickness = 1.8;
panel_thickness = 5.0;
panel_radius = 35.8;
hole_radius = 37.8;
top_inner_flange = 1.5;
top_outer_flange =3.0;
bottom_inner_flange = 3.5;
bottom_outer_flange = 1.75;
wall_thickness = hole_radius-panel_radius;
top_chamfer = 1.2;
bottom_chamfer = .3;
//todo - bottom out chamfer

difference(){
    //slug
    translate([0,0,-top_thickness])
    union(){
        //main
        cylinder(h=panel_thickness + top_thickness + bottom_thickness, r=panel_radius+wall_thickness);

        //bottom flange
        translate([0,0,bottom_thickness/2])
        cylinder(h=bottom_thickness/2, r1=panel_radius+wall_thickness+bottom_outer_flange, r2=panel_radius+wall_thickness+bottom_outer_flange-bottom_chamfer);
        cylinder(h=bottom_thickness/2, r=panel_radius+wall_thickness+bottom_outer_flange);
        
        //top flange
        translate([0,0,+panel_thickness+bottom_thickness]){
            translate([0,0,top_thickness/2])
            cylinder(h=top_thickness/2, r1=panel_radius+wall_thickness+top_outer_flange, r2=panel_radius+wall_thickness+top_outer_flange-top_chamfer);
            cylinder(h=top_thickness/2, r=panel_radius+wall_thickness+top_outer_flange);
        }
    }
    
//    rotate([0,90,0])
 //   translate([0,0,hole_radius/2 + 7])
 //  # cylinder(h=15, r=2);

    //center top
    translate([0,0,+top_thickness+.1])
    cylinder(h=panel_thickness + top_thickness, r=panel_radius-top_inner_flange);
    
    //center top chamfer
    translate([0,0,+panel_thickness+bottom_thickness-top_thickness/2+.1])
    cylinder(h=top_thickness/2, r1=panel_radius-top_inner_flange, r2=panel_radius-top_inner_flange+top_chamfer);
    
    //center bottom
    translate([0,0,-bottom_thickness-.1])
    cylinder(h=panel_thickness + bottom_thickness, r=panel_radius-bottom_inner_flange);

    //panel
    cylinder(h=panel_thickness, r=panel_radius);
}