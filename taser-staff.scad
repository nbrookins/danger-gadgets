include <threads.scad>;
magnets = 34;
holes = 17;
magnet_size = [4,2];
ball_radius = 9.5;
hole_radius = 3.5;
electrode_radius = 18.8;//25.4 * (1+3/8) / 2; //OD of 1 1/4 copper pipe
electrode_height = ball_radius*2;
ring_radius = 41.5;
thickness = 2;
//laser_size = [31.5, 33.3, 67.5];
laser_size = [31.5+6.2, 34.5, 67.5];
taser_size = [31.5, 33.3, 51.0];
laser_extension = 10;
shaft_radius = 12;
laser_controller_size = [32, 42, 70];
shaft_coupler = 70;

gap = ring_radius-ball_radius*2-electrode_radius;
width = (ring_radius+ball_radius*2)*2;
body_radius = shaft_radius+thickness + 7;
length = laser_size[2]*2+ taser_size[2] + shaft_coupler;

$fn = 60;
good = 120;
preview = 0;
part = 11;

main();

module main(){
    difference(){
        echo("Gap: ", gap, ", Width: ", width, "/", width/25.4, "height: ", electrode_height/25.4, ", length: ", length/25.4, " elec radius: " , electrode_radius);
        union(){
            if (part <=2 ){
                *rotate([0,0,-7.7]) translate([0,0,266])
                   lt_coupler(postlength=12, ext = true, long=true, tab=true, rotate_post=true);
                difference(){
                laser_housing(part=part);
                                //slice
                translate([0, 0, 174.25]) cube([200, 200, .01], center=true);
            }}

            //translate([0,0,-36]) taser_housing();

            if (part == 0 || part == 3) {
                color("white") translate([0,0,length-16]){
                    difference() {
                        taser_housing();
                        //slice
                        translate([0, 0, magnet_size[0] +.25]) cube([200, 200, .01], center=true);
                    }
                    if (preview){
                        magnets();
                        //ball
                        color("grey")translate([ring_radius-ball_radius,-5, 0]) sphere(r=ball_radius);
                    }
                }
            }

            if (part == 0 || part == 4)
                laser_cover();

            if (part == 0 || part == 5){
                color("orange") translate([0,0,-62]) //rotate([0,180,0])
                difference() {
                    lt_coupler(postlength=12, ext = true, long=true, tab=true, rotate_post=true);
                        //slice
                        translate([0, 0, -0]) cube([200, 200, .01], center=true);

                    translate([0,0,-6.5-8])
                   hull(){
                        translate([0,.05,0])lens_holder();
                        translate([0,-.05,0])lens_holder();
                        translate([0,.05,-.32]) lens_holder();
                        translate([0,-.05,-.32]) lens_holder();
                    }
                   * for (i = [0 : (2-1)])
                       # rotate([90,0,65]){
                            translate([13.8+i*-30.4,-9,-25]) cube([2.2,6,50]);
                }
                    }
                    translate([0,0,-102+24-30])
                    lens_holder();
            }

            if (part == 0 || part == 6)
                  difference() {
                       refractor();
                        //slice
                        translate([0, 0, 0]) cube([200, 200, .01], center=true);
                    }

            if (part == 0 || part==7){
                //translate([0,0,-320])
                translate([0, 0, -163])
                cube([ 25, 50, 1.5], center=true);
                difference() {
                   battery_housing();
                   //slice
                   translate([0, 0, -124]) cube([200, 200, .01], center=true);
                }
            }

            if (part == 0 || part==8)
                spinner();

            if (part == 0 || part==9)
                 translate([0,0,-4])
                 spinner(peg=true);

            if (part == 0 || part==10)
                 //translate([0,0,-4])
                 prism();

            if (part == 0 || part==11)
                 taser_cap();

            //if (preview)//handle
            // *   color("tan") translate([0,0,-1210]) cylinder(r=shaft_radius, h=4*12*25.4);
        }
        //cutout
        if (preview) translate([0, 0, -1500]) cube([60, 60, 2000]);
    }}

module battery_housing(){
    rotate([0,180,0])
        translate([0,0,15])
        difference() {
        CountersunkClearanceHole(12.5, 0, [0,0,-.5])
            ScrewHole(22.5, 27, pitch=5.5,tolerance=0.5, tooth_height=3.5 ,position=[0,0,2.5])
            //position=[0,0,0], rotation=[0,0,0], pitch=0, tooth_angle=30, tolerance=0.4, tooth_height=0)
            //cylinder(r=13.75, h=25);
            hull(){
                cylinder(r=shaft_radius+thickness, h=32);//shaft_coupler);
                translate([0,0, 52])//laser_size[2]/2])
                cylinder(r=body_radius+4, h=4*25+12+7, $fn=good);
                translate([0,0, 140+16+7])//laser_size[2]/2])
                cylinder(r=shaft_radius+thickness-3, h=32);
                //battery bulge
                for (i = [0 : (2-1)]) rotate([0,0,0+180*i])
                translate([0,6, 102])
                cube([ 28,1.38 *25.4,2.95 *25.4 + 20], center=true);
            }

            //wire hole
            rotate([4,0,90])translate([0,16,-10])
            cylinder(r=3, h=52);//shaft_coupler*1.75);

                //shaft cut
                difference(){ hull(){
                    translate([0,0,34])
                    cylinder(r1=shaft_radius+5,r2=shaft_radius+9, h=18);//shaft_coupler*1.75);
                    translate([0,0,155+6])
                    cylinder(r2=shaft_radius+1,r1=shaft_radius+9, h=20);//shaft_coupler*1.75);
                    }
                    translate([0,0,109])
                    cube([35,100,26], center=true);
                    difference(){
                    translate([0,0,57.501])
                    cube([35,100,3], center=true);
                    translate([0,0,55])
                    //cylinder(r=shaft_radius+3, h=18);//shaft_coupler*1.75);
                    cube([26.,33.5,10],center=true);
                    }
                }

                translate([0, 0, 108.5])
                    cube([27,100,19.5], center=true);
                for (j = [-1 : 1]) rotate([0,0,40*j])  for (i = [-1 :2: 1])//3,2
                    translate([28.5*i, 0, 108.5]) hull(){
                        translate([0,0,-12]) rotate([90,0,0]) cylinder(r=4,h=100, center=true);
                        translate([0,0,12]) rotate([90,0,0]) cylinder(r=4,h=100, center=true);
                    }

                //battery cut
                translate([0,6.0, 104])
                cube([ 26, 46, 84+6], center=true);

                rotate([0,0,0+180])translate([0,6.0, 119+5])
                cube([ 26, 1.38 *25.4 * 1.2, 50], center=true);
                //switch cut
                for (i = [0 : (2-1)]) rotate([0,0,0+180*i])
                translate([0,21.5, 31])
                rotate([90-14,0,0])
                cylinder(h = 22, r1 = 3.9, r2=4.2);
                //power cut
                translate([0,26.0, 46])
                rotate([90,0,0])
                cylinder(h = 12, r = 6.5);

                //bulb
                *translate([0,26.0, 154.0])
                rotate([90,0,0])
                cylinder(h = 30+10, r = 6.8);

                translate([0,0, 200-1])
                sphere(r=16.15/2);//25.4/2*.5);

                translate([0,0, 164.0+7])
                //rotate([90,0,0])
                cylinder(h = 30+10, r = 6.8, center=true);

                  //decorationy thingies
            list = [95,135,175,275,315, 355, 225];
            rotate([0,0,-45.]) for (i = [0 : (6-1)]) rotate(list[i], [0,0,1]) rotate([-7.0,0,0])
            translate([0,19.7,60]) cylinder(r=3,h=76, center=true);
            rotate([0,0,-45.]) for (i = [0 : (7-1)]) rotate(list[i], [0,0,1]) rotate([15.0,0,0])
            translate([0,70.,180]) cylinder(r=4,h=76, center=true);
        }}

module taser_housing(){
    difference(){
        union(){
            //ball track
            hull($fn = good) rotate_extrude(convexity = 10)
                translate([ring_radius-4, 0, 0])
                    circle(r = ball_radius+2, $fn = good);
            //electrode shaft
            cylinder(r=electrode_radius+thickness, h=electrode_height, center=true);
            //screw tabs
            for (i = [0 : (5-1)]) rotate(i*360/5, [0,0,1]){
                translate([ring_radius + 6.4,0,2]) cylinder(r=4.25, h=10, center=true);
            }

        }
        //center cutout
        hull($fn = good) rotate_extrude(convexity = 10, $fn=good)
            translate([ring_radius-ball_radius+1, 0, 0]) circle(r = ball_radius-.75, $fn = good);
        //ball cutout
        rotate_extrude(convexity = 10, $fn=120) hull($fn = good){
            translate([ring_radius-ball_radius+1.5, 0, 0]) circle(r = ball_radius+.35, $fn = good); //slop
            translate([ring_radius-ball_radius-0.75, 0, 0]) circle(r = ball_radius+.35, $fn = good);
        }

        //magnet track
        cylinder(r=ring_radius+magnet_size[1]*1.65, h=magnet_size[0]*2+.5, $fn=magnets, center = true);
        //electrode cutout
        cylinder(r=electrode_radius,h=ball_radius*4, center=true);

        //holes
        for (i = [0 : (holes-1)]) rotate(i*360/holes, [0,0,1])
            translate([electrode_radius + thickness + hole_radius, 0, -ball_radius * 2])
                cylinder(r=hole_radius, h=ball_radius * 4);

        //screws
        for (i = [0 : (5-1)]) rotate(i*360/5, [0,0,1]){
                translate([ring_radius + 7.2,0,2]){
                    cylinder(r=1.5, h=12.5, center=true);
                    translate([1,0,0]) resize([0,8.95,0])difference(){
                        cylinder(r=4.15, h=24, center=true);
                        cylinder(r=4.15, h=10, center=true);
                    }
                }
            }
        //wire hole
        rotate([0,0,-10]) translate([ring_radius + magnet_size[1]*1.25 - 3.0, 0, -ball_radius*1.2-.5]){
            rotate([0,25,0])cylinder(r=1.35, h=ball_radius+2);
        }
    }}

module magnets(){
    for (i = [0 : (magnets-1)]) rotate(i*360/magnets, [0,0,1]) translate([ring_radius+magnet_size[1]/2+.5, 0, 0]) rotate([0,90,0])
        cylinder (r=magnet_size[0], h=magnet_size[1], center=true);}

module laser_cover(){
    difference(){
        cube([30,34,64], center=true);
        translate([1.5,1.5,0]) cube([30,34,65], center=true);
    }}

module switchblock(height=44){
    hull() translate([0, body_radius-7, 8]) {
        translate([-2.5,9.0,11]) rotate([0,0,-17]) {
            cube([19,6.5,height]);
            translate([-3,0,0]) cube([25,.1,height]);
            translate([0,0,-15]) cube([18,.1,1]);
            translate([0,0,height+15]) cube([18,.1,1]);
        }
    }}

module switchcut(mod=false, smooth=false){
    translate([0, body_radius-8, 8])
    translate([.5,6.5,18]) rotate([0,0,-17]) {
        if (mod){
            translate([5.5,10,1.5]) rotate([90,0,0]) cylinder(r=3.7, h=20);
            translate([5.5,10,14.25]) rotate([90,0,0]) cylinder(r=3.7, h=20);
            translate([5.5,10,27.25]) rotate([90,0,0]) cylinder(r=3.7, h=20);
        } else if (smooth){
            translate([0,0,-8]) cube([15,3,59]);
        }else{
            translate([5.5,10,-8.6]) rotate([90,0,0])  cylinder(r=5, h=20);
            translate([5.5,10,-8.6 + 14.5]) rotate([90,0,0]) cylinder(r=5, h=20);
            translate([5.5,10,-8.6 + 14.5*2]) rotate([90,0,0])  cylinder(r=3.7, h=20);
            translate([5.5,10,-8.6 + 14.5*3]) rotate([90,0,0])  cylinder(r=5, h=20);
        }
    }}

module laser_housing(part=0){
    difference(){union(){
       hull(){
            //top body
            translate([0,0, shaft_coupler])//laser_size[2]/2])
            cylinder(r=body_radius+4, h=laser_size[2]*2+ taser_size[2]-.5, $fn=good );

            //bottom taper
            cylinder(r=shaft_radius+thickness, h=shaft_coupler, $fn=good );
        }
        //expanded top
        translate([0,0, shaft_coupler + laser_size[2]+taser_size[2]+2.5]){
            cylinder(r=body_radius+6.0, h=laser_size[2]-3, $fn=good );
            translate([0,0,-25])
                cylinder(r1=body_radius, r2=body_radius+6.0, h=25, $fn=good );
        }

        if(part!=1){
               translate([0,0,shaft_coupler + taser_size[2]]){
                rotate([0,0,-20]) translate([0,0,-8.5]) switchblock(height=59);
                rotate([0,0,160]) switchblock();
               }
            }
        }
        //shaft cut
       translate([0,0,-1])  cylinder(r=shaft_radius-.3, h=shaft_coupler*1.5);
        //body cut
        translate([0,0,shaft_coupler-.1])//laser_size[2]/2+2])
            cylinder(r=body_radius+.5, h=laser_size[2]*2+ taser_size[2]+3);
            translate([0,0,shaft_coupler+laser_size[2]*2-17.5])
            cylinder(r=body_radius+2.5, h=laser_size[2]+3);
        //wire hole
        translate([-17.5,0,0]) cylinder(r=3.5, h=laser_size[2]*2);
        //cut module
        rotate([0,0,-5.0]){
            //translate([0,0,shaft_coupler + taser_size[2]/2]) laser_module(size=taser_size); //laser controller
            translate([0,0,shaft_coupler + taser_size[2] + laser_size[2]/2-2.1]) scale([1,1,1.5])
                laser_module(size=taser_size); //taser module
            translate([0,0,shaft_coupler + taser_size[2] +laser_size[2]*1.5-.2])
                laser_module(e=true);
            translate([4.5,body_radius+2,shaft_coupler + taser_size[2]/2+laser_size[2]*2+7.5])
                cube([ 13,10,45 ], center=true);
        }
        //mid cut
        translate([0,0,shaft_coupler + taser_size[2]]){
            if (part==0) cylinder(r=50, h=.01);
            if (part==1){
                cylinder(r=50, h=200);
                scale([.995,.995,1]) tabs();
            }
            if (part==2){
                translate([0,0,laser_size[2]*2]) scale([.995,.995,1])
                    rotate([0,0,4]) tabs(tabs=4, bottom_taper=true, ext=true);
                rotate([0,0,-20]) switchcut();
                rotate([0,0,160]) switchcut(mod=true);

                rotate([0,0,-20]) translate([-2.5,2,-8]) switchcut(smooth=true);
                rotate([0,0,160]) translate([-2,2,-10]) switchcut(smooth=true);
            }
        }
        if (part==1){
            //shaft screw holes
            for (i = [1 : (3-1)]) rotate([90,0,0]) {
                translate([0,i*20,0]) cylinder(r=3,h=50, center=true);
                translate([0,i*20,14.8+i*3]) cylinder(r=5,h=5, center=true);
                translate([0,i*20,-(14.8+i*3)]) cylinder(r=5,h=5, center=true);
            }
            //decorationy thingies
            rotate([0,0,-18.5]) for (i = [0 : (5-1)]) rotate(i*360/5, [0,0,1]) rotate([-7.0,0,0])
            translate([0,17.7,60]) cylinder(r=3,h=70, center=true);
        }
        if (part==2) translate([0,0,-.1])
            cylinder(r=50, h=shaft_coupler + taser_size[2]);
    }
    translate([0,0,shaft_coupler + taser_size[2]])
        if (part!=1){
            translate([0,0,.5]) tabs(holes=true);
            //reenforce tab
            hull() translate([0, body_radius-10-1.6, laser_controller_size[2]*1])
                rotate([0,0,16.2]){
                    translate([-7,12.0,26]) cube([11,2.5,38.499]);
                    translate([-7,14,14]) cube([11,.5,1]);
            }

        }}

module tabs(holes=false, tabs=4, bottom_taper=false, long=false, ext=false){
    x = (long) ? 20+20 : 0;
    y = (long) ? 9+20 : 0;
    q = (ext) ? -2.75:0;
    for (i = [0 : (tabs-1)]) rotate(i*360/tabs, [0,0,1]){
        difference(){
            union(){
                hull(){
                    intersection(){
                        cylinder(r=body_radius + 3.5 +3-q, h=56+y, center=true, $fn=good);
                        translate([0, -body_radius-10- 2.3 + q*2, -18.1-x]) rotate([0,0,6])
                        cube([10,10-q,37+x]);
                    }
                    //top taper
                 *  #translate([0, -body_radius-10-1.8, -23.1]) rotate([0,0,6]){
                        translate([0,8+q+.5*2,60]) cube([10,1,1]);
                     if(bottom_taper)
                        translate([0,5.5+q,-15]) cube([10,1,1]);
                    }
                }
                if (!holes) make_hole(); //reverse holes for subtractive
            }
            if (holes) make_hole(ext=x/2);
        }
    }}

module make_hole(ext=0){
    translate([4.0, -body_radius-1.8-3.5, -17-ext])
     rotate([90,0,10]) cylinder(r=1.75, h=10, center=true);}

module laser_module(size = laser_size, e = false){
    //laser module
    color("purple") cube(size, center=true);
    //cutout
    if (e) {
        color("gray") translate([-laser_size[0]/2+2.5, laser_size[1]/2 + laser_extension/2-.01 -.75, 0])
        cube([5,laser_extension,laser_size[2]], center=true);

       color("gray") translate([-laser_size[0]/2+2.5, -laser_size[1]/2 - laser_extension/2-.01 +4.5 +3.75, 0])
        cube([5,laser_extension,laser_size[2]], center=true);
    }}

module lt_coupler(tab = true, ext=false, long=false, thick=4, postlength = 0, nubs=false, rotate_post=false){
    difference(){
        union(){
            if (tab) rotate([0,0,12.5]) difference(){
                translate([0,0,-thick/2*0]) tabs(holes=true, long=long, ext=ext, bottom_taper=false);
                translate([0,0,20.51]) cylinder(r=50, h=37, center=true);
            }
            //screw nubs
            if (nubs) for (i = [0 : (4-1)]) rotate(i*360/4, [0,0,1]){
                translate([4.75,-body_radius-3.5,thick/2]) difference(){
                    cylinder(r=7.5, h=thick, center=true);
                    translate([.5,-4.3,0]) cylinder(r=1.65, h=5, center=true);
                }
            }
            //holes (posts)
            if (postlength>0){
                rotpost = (rotate_post) ? 180:0;
                rotate([0,rotpost,0])
                for (i = [0:3:(holes-1)]) rotate(i*360/holes, [0,0,1])
                    translate([electrode_radius + thickness + hole_radius, 0, -postlength +thick/2]){
                    difference(){union(){
                        cylinder(r=hole_radius-.6, h=postlength);
                        translate([0,0,2.19])
                            cylinder(r=hole_radius+1, h=10-.19);
                    }
                   // translate([0,0,-.1])cylinder(r=hole_radius/2.5, h=40);
                    }
                }
            }
            //bottom circle
            q = (ext) ? 2.5: 0;
            translate([0,0,-thick/2-q/1.5]) cylinder(r=body_radius+5+q*1.25, h=thick+q/1.5, $fn=good);
        }
        //cut core
        cylinder(r=electrode_radius, h=37, center=true);
        //#translate([0,0,22.01]) cylinder(r=50, h=37, center=true);
    }}

module lens_holder(){
    difference(){
        union(){
            cylinder(h=5,r=17.25, center=true);

    for (i = [0 : (2-1)])
    rotate([90,0,65]){
        translate([14.25+i*-31.5,-2.5,-25]) cube([3,5,50]);
    }

    for (i = [0 : (2-1)])
    rotate([90,0,65+90]){
        translate([22+i*-47.,-2.5,-16]) cube([3,5,31]);
    }
        }
            translate([0,-0.25,-1])
            cylinder(h=4,r=15.25);
        cylinder(h=5.2,r=13., center=true);

    }}

module refractor(){
    //motor
        //motor housing
        difference(){
            union(){
                rotate([0,0,47.0])
                translate([body_radius+.1, -body_radius/2-5.5, 4-.5])
                rotate([0,0,90+50]) resize([15.5,20.5,0])
                    cylinder(r=8.5, h=22, center=true);
                rotate([0,0,211])
                    lt_coupler(tab=false, postlength=12, thick=5);
            }
            rotate([0,0,47])
            translate([body_radius+.28, -body_radius/2-5.5, 4-.5]){
            rotate([0,0,50]) resize([0,12,0]) cylinder(r=7.25, h=23, center=true);
            rotate([0,0,50+90]) translate([0,0,9]) cube([10.5,12.5,7], center=true);
        }
        //temp spinner
    }
    //tase prods
    difference(){union(){
        for (i = [0 : (2-1)]) rotate([0,0,-154 + 43*i])
        translate([body_radius-2.2, -body_radius/2-5, 15.450]){//
        difference(){
            cylinder(r=5.5, h=46, center=true);
            cylinder(r=2.5, h=57, center=true);
            //if (i==1)translate([0,0,-10]) rotate([0,90,10])
              //  cylinder(r=2, h=80, center=true);
        }
        }
        translate([-22.5,-4,20]) rotate([90,0,10])
            cylinder(r=2.5, h=10, center=true);
        }
        translate([-22,-4,5]) rotate([90,0,10])
            cylinder(r=2.5, h=20, center=true);
    }}

module spinner(peg=false){
    rot1 = (peg) ? 180 : 0;
    translate([0,0,20]) rotate([0,rot1,0]){
    difference(){
        union(){
            if (!peg){
                //reenforcement
                difference(){
                    cylinder(r=36.8, h=2, center=true, $fn=good);
                    translate([0,0,.35])
                    cylinder(r2=37.8, r1=37.3, h=2.1, center=true, $fn=good);
                }
            }else{
                cylinder(r=3.25, h=7);
            }

            //hat(peg);
        }
        //diff
        if (!peg) refract();

        *translate([0,0,-1.76])
            cylinder(r=36.8, h=1.25, center=true);

        //todo magnet interface
        t = (peg) ? -.01: -1.26;
        for (i =[0:(3-1)]) rotate([0,0,120*i]){
            translate([0,5,t-1])
                cylinder(r=2.7, h=3.5, center=false);
        }
        if (peg){
            translate([0,0,.2])
                cylinder(r=1.8, h=7.2);
        }
    }
    if(peg)#rotate([0,0,-145])translate([1.6,0,1.751]) cube([.75,4,3.5], center=true);
                    //refractor disk
    if (!peg) {
        union(){

        difference(){
            cylinder(r=36.8, h=2, center=true, $fn=good);
            //translate([0,0,.2])
            cylinder(r2=35.8, r1=35.3, h=2.1, center=true, $fn=good);
        }
                difference(){
                    union(){
                        refract();
                         hat(peg);
                    }
                translate([0,0,-1.76 +.14 ])
                cylinder(r=37.8, h=1.5, center=true);

                        //todo magnet interface
        t = (peg) ? -.01: -1.26;
        for (i =[0:(3-1)]) rotate([0,0,120*i]){
            translate([0,5,t-.8])
                cylinder(r=2.7, h=3.5, center=false);
        }
                }
       }
    }
    }
    }

module hat(peg){
                rr1 = (peg) ? 10 : 12;
            t2 = (peg) ? 0: -.9;
            translate([0,0,t2]) hull(){
                cylinder(r1=rr1, r2=10, h=2.6, center=false);
                translate([0,0,3])
                cylinder(r=3.25, h=1, center=false);
            }
}
    module refract(){
        translate([0,0,-1])
        cylinder(r=36.8, h=.25, center=true);

        rotate([0,0,-16])
        translate([0,0,-1.1])
        for (i =[0:(7-1)]) rotate([0,0,360/7*i]){
            resize ([0,0,1.9]) rotate([90,0,0]) translate([0,0,0])
            cylinder(h=36.8, r=1.45, center=false, $fn=good);
        }
    }

module taser_cap(){
    difference() {
        union(){
            washer();

            translate([-3,6,0])
            cube([6,30,1.5]);

            translate([0,44,0]){
                sphere_hull(r=8.8, t=4, depth=2.);

                //tab
                for (i =[0:(4-1)]) rotate([0,0,360/4*i])
                translate([0,7.0,.4])
                sphere_hull(depth=2.1);

               translate([0,-7,0])
               sphere_hull(r=5, t=2.5, depth=2.5);
            }
        }

        translate([0,44,0]){
            translate([0,0,-18.01])
            washer(r=25, t=18, hole=false);

            sphere_hull(r=3.75, t=3.5, depth=1.0);

            //magnets
            rotate([0,0,180])
            for (i =[0:(4-1)]) rotate([0,0,360/4*i])
                translate([0,7,-.1])
                cylinder(r=2.65, h=2.6, center=false);
        }
    }
}

module sphere_hull(r=4, t=2, depth=3){
     hull(){
        resize([0,0,t])
        sphere(r=r, $fn=good);

        translate([0,0,depth])
        resize([0,0,t])
        sphere(r=r, $fn=good);
    }
}

module washer(r=17.75/2, t=1.5, hole=true){
    difference(){
        cylinder(r=r, h=t);
        if(hole) translate([0,0,-.01]) cylinder(r=10.4/2, h=1.85);
    }
}

module spinner_hat(peg=false){
    rot1 = (peg) ? 180 : 0;
    translate([0,0,20]) rotate([0,rot1,0]){
    difference(){
        union(){
            if (!peg){
                //refractor disk
                 translate([0,0,-1])
                cylinder(r=36.8, h=.25, center=true);
                rotate([0,0,-16])
                translate([0,0,-1.1])
                for (i =[0:(7-1)]) rotate([0,0,360/7*i]){
                    resize ([0,0,1.9]) rotate([90,0,0]) translate([0,0,0])
                    cylinder(h=36.5, r=1.45, center=false, $fn=good);
                }
                //reenforcement
                difference(){
                    cylinder(r=36.8, h=2, center=true, $fn=good);
                    cylinder(r2=35.8, r1=35.3, h=2.1, center=true, $fn=good);
                }

            }else{
                cylinder(r=3.25, h=7);
            }
            rr1 = (peg) ? 10 : 12;
            t2 = (peg) ? 0: -.9;
            translate([0,0,t2]) hull(){
                cylinder(r1=rr1, r2=10, h=2.6, center=false);
                translate([0,0,3])
                cylinder(r=3.25, h=1, center=false);
            }
        }
             translate([0,0,-1.76])
                cylinder(r=36.8, h=1.25, center=true);
        //todo magnet interface
        t = (peg) ? -.01: -1.26;
        for (i =[0:(3-1)]) rotate([0,0,120*i]){
            translate([0,5,t-1])
                cylinder(r=2.7, h=3.5, center=false);
        }
        if (peg){
            translate([0,0,.2])
                cylinder(r=1.8, h=7.2);
        }
    }if(peg)#rotate([0,0,-145])translate([1.6,0,1.751]) cube([.75,4,3.5], center=true);
    }}

module prism(){
    intersection() {
        union()difference() {
            cylinder(h=8, r=electrode_radius-1.5, center=true, $fn=good);
            cylinder(h=9, r=electrode_radius-3.5, center=true, $fn=good);
        }
        union() for (i =[0:(5-1)]) rotate([0,0,360/5*i]){
            translate([0,10,-4])
            rotate([0,0,-35]) cube([10,10,10]);
        }
    }
    intersection() {
        difference() {
            translate([0,0,4])
            cylinder(h=3, r=electrode_radius+.75, center=true, $fn=good);
            translate([2.5,3.2,6.75])
            sphere(r = 10.25, $fn=good);
        }

        translate([0,0,2]) rotate([0,0,22]) cube([electrode_radius*2-2.5,electrode_radius*2.5,10], center=true);
    }
}