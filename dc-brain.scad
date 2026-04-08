// my favorite brain :: (c) nick brookins, 2022-2024 ::
layer_set =[                       // TRANSLATE       SIZE         ROTATE     RD  CNVXTY
/* brain stem, medulla oblongata */[[-1.0,00,01], [3.0,2.6,2.8], [000,15,000], 4, 15],  [[-1,0,0.8000], [4.7,4,1.700], [00,00,00], 1, 18],
/* cerebellum, 2 halves */         [[-.8,.5,1.5], [7,5.5,2.200], [-5,-20,-15], 2, 19],  [[-.8,-0.5,00], [7,5.5,2.200], [5,-20,15], 2, 19],
/* temporal lobe base & halves */  [[1.5,00,-.6], [7.5,5.3,1.5], [000,00,000], 1, 18],  [[1.8,-1.4,.6], [8.2,4.7,2.2], [15,12,18], 2, 15],  [[1.8,1.4,0], [8.2,4.7,2.2], [-15,12,-18], 2, 15],
/* cerebral cortex layers 1-9 */   [[0.8,00,000], [10.4,8.20,1], [000,180,00], 2, 13],  [[0.8,0,0.730], [10.7,8.60,1], [00,00,00], 2, 13], /*cc3*/ [[0.8,0,0.73], [10.8,8.8,001], [000,180,000], 2, 16], /*cc4*/ [[0.77,0,.6], [10.3,8.4,1], [0,00,00], 2, 17], /*cc5*/ [[.74,0,.55], [9.6,7.6,1], [0,180,0], 2, 15], /*cc6*/ [[0.65,0,0.55], [8.6,6.60,.8], [0,00,00], 2.5, 13], /*cc7*/ [[.6,0,.45], [7.6,5.6,.8], [0,0,0], 2, 12], [[0.59,0,0.35],[06,4.5,.8], [0,0,00], 2, 11], /*cc8*/ [[.58,0,.12], [4.2,3.2,1], [0,0,0], 2, 12]];
                 // PLACEMENT  ROTATE  POST-ROTATE-TRANSFORM  RAD1&2 DEPTH CVX H-vs-P  SIDE
pegs_or_holes = [[[-23,-16,68], [90,0,-20], [0,0,0], 6.4,6.4, 48, 16,  0, -1],   [[36,-16,68], [90,0,20], [0,0,0], 6.4,6.4, 48,  24,  0, -1], /*<led holes>*/ [[-23,16,68],[90,0,20],[0,0,0],6.4,6.4,48,24,0,1],[[36,16,68],[90,0,-20],[0,0,0],6.4,6.4,48,24,0,1], /*wire holes>*/[[-33,-3,40],[0,25,10],[0,0,0],5.0,2.5,65.0,24,0,-1], [[10,1,66],[90,0,90],[0,0,0],2,2,50.0,24,0,-1], [[-33,3,40],[0,25,-10],[0,0,0],5.0,2.5,65,24,0,1], [[10,-1,66],[90,0,90],[0,0,0],2,2,50.0,24,0,1], /*magnet slots*/[[-18,-5.0,3.8],[0,0,0],[0,0,0],10,10,6.0,24,0,-1], [[-18,5.0,3.8],[0,0,0],[0,0,0],10,10,6.0,24,0,1],/*slices*/ [[0,0,0], [0,50,0], [0,0,00], 150,150, 100, 16,  0, -1],[[0,0,0], [0,50,0], [0,0,00], 150,150, 100, 16,  0, 1] ]; //*/];
halves = [ /*halves(-1,0,1,2)*/ 2, /*sep(50)*/ 50, /*cxf(1)*/ 1, /*rnd(3)*/ 3, /*cvx(4)*/ 4, /*bulge(.85)*/ .85, /*glb rot*/ [2,-4,0], /* glb scl */ [15,14.5,15]];

// create main brain model from applied parameters //
module brain(layers, h, seperation, cf, r, rcx, poh, slice){
    if (h == 0) mink_round(r) mold(layers); // make single solid brain
    if (h != 0) for (i=[-1 : 2 : abs(h)-1]) // make brain hemispheres by making two brains and slicing half from each
       render(convexity=1) union(){ translate([0, (seperation+r/1.05)*i, 0]) {  //seperate halves, pre-render
          difference() { mink_round([r,((i<0)?rcx/cf:rcx*cf)]) difference() { scale(halves[7]) intersection(){ //apply rounding / transforms
            mold(layers, i, cf); translate([0, i*15*((abs(h)==1)?h:1), 0]) rotate([halves[6][0]*i, 0, 0]) cube([30, 30, 30], center=true); }} //slice half
              /* Holes..*/ holy_pegs(poh, 0, h=i); } /*..Pegs!*/ holy_pegs(poh, 1, h=i);}}
}
// create solid brain mold from layer data //
module mold(layers, cx=0, cf=1, rot=halves[6]){
    union() difference(){ rotate([rot[0]*cx, rot[1], rot[2]]) union() layer_chain(layers, 0, 0, cx, cf); //apply global rotation, start layer chain
        translate([0,0,-15])cube([30,30,30], center=true); } //slice flat bottom on brain stem
}
// recurses a list of vectors to represent layer translation, size, rotation, circle_radius, and convexity //
module layer_chain(l, i, zlevel, cx=0, cf=1){
    //aggregate zlevel to shift each layer up, apply other modifications
    translate ( [l[i][0][0], l[i][0][1], zlevel + l[i][0][2]]) rotate(l[i][2]) resize(l[i][1])
		torus(t=l[i][3], fn=((cx<0)?l[i][4]/cf:l[i][4]*cf)); //create the torus
    //call ourselves recursively with next layer to keep counter
    if (len(l)>i+1) layer_chain(l, i+1, zlevel + l[i][0][2], cx, cf);           ///  peek into my mind         ///
}                                                                              ///  this is the beauty i see  ///
// filled-torus layer function                                                 ///   my favorite brain        ///
module torus(t, cr=.5, fn, bulge=halves[5]){
    hull(){ rotate_extrude($fn=fn) /*like play-doh*/ translate([t, 0, 0]) circle(r=cr);
        if (bulge>0) sphere(bulge);} // add the hole back in the donut for a center bulge
}
// do a minkowski hull process to smooth edges (very slow) //
module mink_round(r) {
    if (!is_list(r) || r[0] == 0){ children();} // if not rounding, pass children back unmodified
        else{ minkowski($fn=r[1]) { children(); sphere(r[0], $fn=r[1]); }} //roll sphere over surface additively
}
// create holes or pegs.  for things. //
module holy_pegs(ph, test_peg, h) {
    for(p=[0:1:len(ph)-1]) if (test_peg==ph[p][7] && (h==ph[p][8] || h==0)) // determine hole vs peg, and if this is the right half
        translate(ph[p][0]) rotate(ph[p][1]) translate(ph[p][2]) cylinder(ph[p][5],ph[p][3],ph[p][4],$fn=ph[p][6],center=true);
}
// main function //
brain(layer_set, halves[0], halves[1], halves[2], halves[3], halves[4], pegs_or_holes);