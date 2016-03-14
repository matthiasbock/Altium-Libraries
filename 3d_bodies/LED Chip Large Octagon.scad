$fn = 50;

module aluminum_base_plate()
{
	width = 46;
	height = 42;
	thickness = 1;
	hole_distance_x = 30;
	hole_distance_y = 36;
	hole_radius = 1.5;

	module diagonal_corner()
	{
		rotate(45) cube([10,10,thickness+0.1], center=true);
	}

	module screw_hole()
	{
		cylinder(r=hole_radius, h=thickness+0.1, center=true);
	}

	color("lightgrey")
	{
		translate([0,0,thickness/2]) difference()
		{
			cube([width,height,thickness], center=true);

			// 4 corners
			translate([width/2,height/2]) diagonal_corner();
			translate([-width/2,height/2]) diagonal_corner();
			translate([width/2,-height/2]) diagonal_corner();
			translate([-width/2,-height/2]) diagonal_corner();

			// screw holes
			translate([hole_distance_x/2,hole_distance_y/2]) screw_hole();
			translate([-hole_distance_x/2,hole_distance_y/2]) screw_hole();
			translate([hole_distance_x/2,-hole_distance_y/2]) screw_hole();
			translate([-hole_distance_x/2,-hole_distance_y/2]) screw_hole();
		}
	}
}

module plastic_casing()
{
	width = 36;
	height = 38;
	thickness = 1;
	hole_width = 23;
	hole_height = 23;

	module round_corner()
	{
    	w = 5;
		h = 4;
		union()
		{
			translate([0,0,-0.1])
			{
				cube([w,h/2,thickness+0.2]);
				cube([w/2,h,thickness+0.2]);
				translate([w/2,h/2,0]) scale([w/2,h/2]) cylinder(r=1, h=thickness+0.2);
			}
		}
	}

	color("white")
	{
		difference()
		{
			translate([-width/2,-height/2]) cube([width,height,thickness]);

			// 4 corners
			translate([width/2,height/2]) rotate(180) round_corner();
			translate([-width/2,-height/2]) round_corner();
			mirror([1,0,0])
			{
			translate([width/2,height/2]) rotate(180) round_corner();
			translate([-width/2,-height/2]) round_corner();
			}

			// hallow middle
			translate([-hole_width/2,-hole_height/2,-0.1]) cube([hole_width,hole_height,thickness+0.2]);
		}
	}
}

aluminum_base_plate();
translate([0,0,1]) plastic_casing();
