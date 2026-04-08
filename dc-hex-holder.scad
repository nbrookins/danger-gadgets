//Wheeler's HEX holder builder
inner = 13.25;
outer = 15.5;
height = 26;
bottom = 2.3;

outer_bulge = 1.75;
outer_flare = 3;
outer_bevel = 2.5;
inner_flare = .75;

//autogen variables
shift_side = inner*2 + (outer-inner)*1.7;
shift_point = inner*2 -.5;

module hex(id, od, sides, height){
    difference(){
        hull(){
            cylinder(height, od, od, $fn=sides);
            cylinder(height-outer_bevel, od+outer_flare, od+outer_bulge, $fn=sides);
        }    
        translate([0,0,bottom])
        cylinder(height, id, id+inner_flare, $fn=sides);
    }
}

//large hex (juice!)
translate([-2.5, shift_side*2 +5,0])
hex(18.5, 21, 6, height+10);

//loop other hexes
for(j=[0:1:1]){
    for(i=[-2:1:1]){
        translate([j * shift_point, shift_side * i + j * .5 * shift_point,0])
        hex(inner, outer, 6, height + i * 4);
    }
}