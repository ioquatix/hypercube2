
use <beam.scad>;
use <rail.scad>;
use <stepper.scad>;

module reflect(axis) {
	children();
	mirror(axis) children();
}

module corexy(size, rails = [500, 500, 10], offset = [000, 000], inset = [42.3/2, 42.3/2, 12]) {
	
	// Stepper motors:
	reflect([1, 0, 0])
	translate([size[0]/2, size[1]/2+20, size[2]-106]) rotate([0, 0, 180]) stepper_nema17();
	
	// XY idlers:
	reflect([1, 0, 0])
	translate([-size[0]/2, -size[1]/2, size[2]]) 
	rotate(180, [1, 1, 0]) idler_nema17();
	
	// X idler:
	translate([size[0]/2, offset[1], size[2]])
	rotate(180, [0, 1, 0]) idler_x();
	
	translate([0, -20/2 + offset[1], size[2]-rails[2]-40-20-24]) rotate([0, 0, 90]) {
		
		translate([20/2, 0, 20]) {
			rail_mgn9(rails[0]);
			translate([0, offset[0], 0]) reflect([0, 1, 0]) rail_mgn9c(10);
		}
		
		beam_2020(size[0]+40);
	}
	
	reflect([1, 0, 0]) translate([size[0]/2+20/2, 0, size[2]-40]) rotate([0, 180, 0]) {
		rail_mgn9(rails[1]);
		translate([0, offset[1], 0]) reflect([0, 1, 0]) rail_mgn9c(10);
	}
}

module z_axis(size) {
	translate([0, size[1]/2, 0]) scale([1, 1, -1]) stepper_nema17(center=[0, -0.5, -2]);
	
	reflect([1, 0, 0]) translate([size[0]/2, 0, 0]) idler_z(center=[-0.5, 0, 0]);
}

module bed(size, rails=[500, 10], offset=[0, 0, 200], bottom = 60, plate=[400, 400, 4]) {
	reflect([1, 0, 0]) reflect([0, 1, 0]) {
		translate([size[0]/2+10, size[1]/2, rails[0]/2+bottom]) rotate([90, 0, 0]) {
			rail_mgn9(rails[0]);

			translate([0, -offset[2], 0]) {
				rail_mgn9c(20);
			}
		}
	}
	
	reflect([0, 1, 0]) translate([0, size[1]/2 - rails[1], bottom + rails[0]/2 - offset[2]]) {
		rotate([0, 0, -90]) beam_2020(size[1]+40);
	}
	
	reflect([1, 0, 0]) translate([size[0]/2, 0, bottom + rails[0]/2 - offset[2]]) {
		beam_2020(size[0]-60);
	}
	
	// plate
	translate([0, 0, bottom + rails[0]/2 - offset[2]+20]) {
		translate([-plate[0]/2, -plate[1]/2, 0]) cube(plate);
	}
}

module frame(size, bottom = 40) {
	reflect([1, 0, 0]) reflect([0, 1, 0]) {
		translate([size[0]/2, size[1]/2, 0]) beam_2020z(size[2]);
	}
	
	reflect([1, 0, 0]) {
		translate([size[0]/2, 0, bottom]) beam_2040(size[1]);
		translate([size[0]/2, 0, size[2]-40]) beam_2040(size[1]);
	}
	
	reflect([0, 1, 0]) {
		translate([0, size[1]/2, bottom]) rotate([0, 0, 90]) beam_2040(size[0]);
		translate([0, size[1]/2, size[2]-40]) rotate([0, 0, 90]) beam_2040(size[0]);
	}
	
	corexy(size, bottom=bottom+40);
	bed(size, bottom=bottom+40);
	
	color([0, 0, 1]) z_axis([500, 500, 640], bottom);
}

frame([500, 500, 640]);
