
module beam_2020(length=500) {
	color("grey") translate([0, -length/2, 0]) {
		render() difference() {
			cube([20, length, 20]);
			
			translate([10, length, 10]) rotate([90, 0, 0]) cylinder(d=4.3, h=length);
			
			offset = (20-5)/2;
			translate([offset, 0, 0]) cube([5, length, 5]);
			translate([0, 0, offset]) cube([5, length, 5]);
			translate([offset, 0, offset*2]) cube([5, length, 5]);
			translate([offset*2, 0, offset]) cube([5, length, 5]);
		}
	}
}

module beam_2040(length=500) {
	beam_2020(length);
	translate([0, 0, 20]) beam_2020(length);
}

module beam_2020z(length=500) {
	translate([0, 20, length/2]) rotate([90, 0, 0]) beam_2020(length);
}

translate([-20, 0, 0]) beam_2020(500);
translate([20, 0, 0]) beam_2040(500);
