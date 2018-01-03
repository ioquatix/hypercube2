
// This function creates a cube with a given x/y either above (f=1) or below (f=-1) the z axis.
module zcube(dimensions, z=0, f=1) {
	translate([0, 0, dimensions[2]/2 * f + z]) cube(dimensions, true);
}

module rcube(dimensions, d, z=0, f=1) {
	dx = dimensions[0]/2 - d/2;
	dy = dimensions[1]/2 - d/2;
	dz = dimensions[2]/2 * (f-1) + z;
	
	hull() {
		translate([-dx, -dy, dz]) cylinder(h=dimensions[2], d=d);
		translate([-dx, dy, dz]) cylinder(h=dimensions[2], d=d);
		translate([dx, -dy, dz]) cylinder(h=dimensions[2], d=d);
		translate([dx, dy, dz]) cylinder(h=dimensions[2], d=d);
	}
}

module zcorners() {
	children();
	mirror([1, 0, 0]) children();
	mirror([0, 1, 0]) children();
	mirror([1, 1, 0]) children();
}
