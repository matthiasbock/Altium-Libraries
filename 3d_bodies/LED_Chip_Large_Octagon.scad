$fn = 50;

// this is added to get rid of rendering problems
render_margin = 0.1;

module aluminum_base_plate()
{
	width = 46;
	height = 42;
	thickness = 1;
	corner_cutaway_x = 10;
	corner_cutaway_y = 10;
	hole_distance_x = 30;
	hole_distance_y = 36;
	hole_radius = 1.5;

	module diagonal_corner()
	{
		rotate(45)
			translate([-corner_cutaway_x/2, -corner_cutaway_x/2, -render_margin])
				cube([corner_cutaway_x, corner_cutaway_y, thickness+2*render_margin]);
	}

	module screw_hole()
	{
		translate([0,0,-render_margin])
			cylinder(r=hole_radius, h=thickness+2*render_margin);
	}

	color("lightgrey")
	{
		difference()
		{
			translate([-width/2,-height/2]) cube([width,height,thickness]);

			// 4 corners
			translate([width/2,height/2]) diagonal_corner();
			translate([-width/2,height/2]) rotate(90) diagonal_corner();
			translate([width/2,-height/2]) rotate(90) diagonal_corner();
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
			translate([0, 0,-render_margin])
			{
				translate([-render_margin, -render_margin])
				{
					cube([w+render_margin, (h/2)+render_margin, thickness+2*render_margin]);
					cube([(w/2)+render_margin, h+render_margin ,thickness+2*render_margin]);
				}
				translate([w/2,h/2,0]) scale([w/2,h/2]) cylinder(r=1, h=thickness+2*render_margin);
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
			translate([-hole_width/2,-hole_height/2,-render_margin]) cube([hole_width,hole_height,thickness+2*render_margin]);
		}
	}
}

module led()
{
	w = 1;
	h = 1;
	t = 0.2;
	translate([-w/2, -h/2]) cube([w,h,t]);
}

module led_string()
{
	// eleven LEDs in a row
	for (i = [1 : 11])
	{
		translate([0, (i-6)*2]) led();
	}
}

module three_led_strings()
{
	// with slight spacing between them
		led_string();
	translate([-2.5,0])
		led_string();
	translate([+2.5,0])
		led_string();
}

/*
 * main
 */

aluminum_base_plate();
translate([0,0,1+2*render_margin]) plastic_casing();

// LEDs
translate([0,0,1+2*render_margin])
{
		color("green") three_led_strings();
	translate([-7.5,0])
		color("blue") three_led_strings();
	translate([+7.5,0])
		color("red") three_led_strings();
}
