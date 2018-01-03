
use <bolts.scad>;

use <beam.scad>;
use <rail.scad>;
use <stepper.scad>;

origin = [200, 200, 400];

module reflect(axis) {
	children();
	mirror(axis) children();
}

module corexy(size, rails = [450, 500, 10], offset = origin, inset = 7) {
	
	// Stepper motors:
	reflect([1, 0, 0])
	translate([size[0]/2-inset, size[1]/2+20, size[2]]) rotate([0, 180, 0]) stepper_nema17(center=[0, 0.5, 0]);
	
	// XY idlers:
	reflect([1, 0, 0])
	translate([size[0]/2-inset, -size[1]/2-10, size[2]-100]) idler_nema17(center=[0, 0, 0]);
	
	// X idlers:
	reflect([1, 0, 0]) translate([size[0]/2-inset, offset[1], size[2]])
	rotate(180, [0, 1, 0]) idler_x();
	
	translate([0, -20/2 + offset[1], size[2]-80]) rotate([0, 0, 90]) {
		translate([20/2, 0, 20]) {
			rail_mgn9(rails[0]);
			translate([0, offset[0], 0]) reflect([0, 1, 0]) rail_mgn9c(10);
		}
		
		beam_2020(size[0]+40);
	}
	
	reflect([1, 0, 0]) translate([size[0]/2+20/2, 0, size[2]-40]) rotate([0, 180, 0]) {
		rail_mgn9(rails[1]);
		translate([0, offset[1], 0]) {
			reflect([0, 1, 0]) rail_mgn9c(10);
		
			hull() {
				translate([-10, -40, 10]) cube([20, 80, 5]);
				translate([-10, -15, 35]) cube([20, 30, 5]);
			}
		}
	}
}

module z_axis(size) {
	translate([0, size[1]/2, 0]) scale([1, 1, -1]) stepper_nema17(center=[0, -0.5, -2]);
	
	reflect([1, 0, 0]) translate([size[0]/2, 0, 0]) idler_z(center=[-0.5, 0, 0]);
}

module t8_brass_nut_cutout(height=20, inner_diameter=10.2, outer_diameter=22, offset=16) {
	hole(inner_diameter, height);
	
	for (r = [0:90:360]) {
		rotate(r, [0, 0, 1]) {
			translate([0, 16/2, 0]) hole(3.5, height);
		}
	}
}

module z_axis_bracket(height=20, outset=15, width=40) {
	render() difference() {
		hull() {
			translate([0, -width/2, 0]) cube([outset, width, height]);
			translate([outset, 0, 0]) cylinder(d=22, h=height);
		}
		
		translate([outset, 0, 0]) t8_brass_nut_cutout(height=height);
		
		for (y = [-15, 15])
			translate([0, y, height/2]) rotate([0, 90, 0]) #hole(3, outset);
	}
}

module z_axis_carriage(height=40, outset=40, width=20, thickness=10) {
	render() difference() {
		union() {
			hull() {
				cube([outset, width, thickness]);
				cube([thickness, width, thickness]);
			}
			
			hull() {
				cube([width, outset, thickness]);
				cube([width, thickness, height]);
			}
		}
	}
}

module bed(size, rails=[500, 10], offset=origin, bottom=60, plate=[400, 400, 4]) {
	
	z_offset = offset[2] - 190;
	
	reflect([1, 0, 0]) reflect([0, 1, 0]) {
		translate([size[0]/2+10, size[1]/2, rails[0]/2+bottom]) rotate([90, 0, 0]) {
			rail_mgn9(rails[0]);

			translate([0, -z_offset, 0]) {
				rail_mgn9c(31);
				rail_mgn9c(-41);
			}
		}
	}
	
	reflect([0, 1, 0]) translate([0, size[1]/2 - rails[1], bottom + rails[0]/2 - z_offset]) {
		rotate([0, 0, -90]) beam_2020(size[1]+40);
	}
	
	reflect([1, 0, 0]) translate([size[0]/2, 0, bottom + rails[0]/2 - z_offset]) {
		beam_2020(size[0]-60);
		
		mirror([1, 0, 0]) z_axis_bracket();
		
		reflect([0, 1, 0]) translate([20, -size[0]/2 + rails[1], 20]) mirror([1, 0, 0]) z_axis_carriage();
		
		reflect([0, 1, 0]) translate([20, -size[0]/2 + rails[1], 0]) rotate([0, 180, 0]) z_axis_carriage();
	}
	
	// plate
	translate([0, 0, bottom + rails[0]/2 - z_offset+20]) {
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
		
		//translate([0, size[1]/2, size[2]-100]) rotate([0, 0, 90]) beam_2040(size[0]);
	}
	
	corexy(size, bottom=bottom+40);
	bed(size, bottom=bottom+40);
	
	color([0, 0, 1]) z_axis([500, 500, 640], bottom);
}

frame([500, 500, 650]);
