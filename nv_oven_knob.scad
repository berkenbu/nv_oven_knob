$fn = 60;

base_r = 40/2;
base_offs_r = 2;
base_h = 5;

main_r = 41/2;
main_h = 15;

axle_r = 5.5/2;
axle_h = base_h+main_h-2;
axle_key_offs = 0.6;

sphere_r = 5*main_r;
torus_r = 2;

mark_len = 0.4*main_r;

eps = 1e-2;

main_knob();

module main_knob() {
    difference() {
        union() {
            intersection() {
                union() {
                    cylinder(r=base_r, h=base_h+eps);
                    translate([0, 0, base_h])
                        cylinder(r1=base_r+base_offs_r, r2=main_r, h=main_h);
                }
                translate([0, 0, -sphere_r+base_h+main_h-eps]) sphere(r=sphere_r);
            }
            let (dh=sphere_r-sqrt(sphere_r*sphere_r-main_r*main_r)) {
                translate([0, 0, base_h+main_h-dh-0.1]) 
                    torus(Rad=main_r-torus_r+(base_r+base_offs_r-main_r)*dh/main_h, rad=torus_r);
                translate([main_r-torus_r-mark_len, 0, base_h+main_h-dh-0.1])
                    rotate([0, 90, 0]) {
                        cylinder(r=torus_r, h=mark_len);
                        sphere(r=torus_r);
                    }
            }
        }
        translate([0, 0, -eps]) axle();
    }
}

module axle() {
    difference() {
        cylinder(r=axle_r, h=axle_h);
        translate([2*axle_h+(1-axle_key_offs)*axle_r, 0, 0]) cube(4*axle_h, center=true);
    }
}

module torus (Rad, rad) {
    rotate_extrude() {
        translate([Rad, 0]) circle(rad);
    }
}