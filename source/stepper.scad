
module stepper_nema17(length = 40, size = 42.3, diameter = 9.5, center=[0.5, 0.5, 0]) {
	render() translate([size*center[0], size*center[1], length*center[2]]) difference() {
		union() {
			translate([-size/2, -size/2, 0]) cube([size, size, length]);
			cylinder(d=22, h=length+2);
			cylinder(d=diameter, h=length+24, $fn=32);
		}
		
		for (r = [0:90:360]) {
			rotate([0, 0, r]) translate([-31/2, -31/2, length-4.5]) cylinder(d=3, h=4.5, $fn=16);
		}
	}
}

module idler_nema17(length = 40, size = 42.3, diameter = 9.5, thickness = 1.5) {
	render() translate([size/4, size/2, 0]) difference() {
		union() {
			cylinder(d=diameter, h=length+24, $fn=32);
			translate([0, diameter+thickness, 0]) cylinder(d=diameter, h=length+24, $fn=32);
		}
	}
}

module idler_x(length = 40, size = 42.3, diameter = 9.5, thickness = 1.5) {
	offset = diameter+thickness;
	
	render() translate([size/2, 0, 0]) difference() {
		union() {
			translate([offset, -offset/2, 0]) cylinder(d=diameter, h=length+24, $fn=32);
			translate([offset, offset/2, 0]) cylinder(d=diameter, h=length+24, $fn=32);
		}
	}
}

module idler_z(length = 40, size = 50, overlap = 20, rod = [8, 500], center=[0.5, 0.5, 0]) {
	render() translate([size*center[0]+overlap, size*center[1], length*center[2]+overlap]) {
		translate([-size/2, -size/2, 0]) {
			difference () {
				cube([size, size, length]);
				translate([size-overlap, 0, overlap]) cube([overlap, size, length-overlap]);
			}
			
			rod_inset = (size - overlap) / 2;
			translate([rod_inset, size/2, 0]) cylinder(d=rod[0], h=rod[1]);
		}
	}
}

translate([0, -100, 0]) stepper_nema17();

idler_z();
