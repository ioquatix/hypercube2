
module rail_mgn9(length) {
	color("green")
	translate([-9/2, -length/2, 0]) cube([9, length, 6.5]);
}

module rail_mgn9c(offset=0) {
	color("orange")
	translate([-20/2, offset, 2]) cube([20, 28.9, 10-2]);
}