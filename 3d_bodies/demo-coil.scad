
facets = 100;

module winding(radius, height, draw_cap)
{
	// left wire
	translate([0, -height/2, -height/2])
	sphere(r=radius, $fn=facets);

	translate([0, -height/2, 0])
	cylinder(r=radius, h=height, center=true, $fn=facets);

	// bottom wire
	translate([0, +height/2, -height/2])
	sphere(r=radius, $fn=facets);

	translate([0, +height/2, 0])
	cylinder(r=radius, h=height, center=true, $fn=facets);

	// right wire
	translate([0, +height/2, +height/2])
	sphere(r=radius, $fn=facets);

	translate([0, 0, -height/2])
	rotate([90, 0, 0])
	cylinder(r=radius, h=height, center=true, $fn=facets);

	// top wire
	translate([0, -height/2, +height/2])
	sphere(r=radius, $fn=facets);

	translate([+radius, 0, +height/2])
	rotate([90, 0, atan(2*radius/height)])
	cylinder(r=radius, h=height, center=true, $fn=facets);

	// final wire cap
	if (draw_cap == true)
	{
		translate([2*radius, -height/2, +height/2])
		sphere(r=radius, $fn=facets);
	}
}

module coil(windings)
{
	r = 1;
	h = 10;

	for (i = [0:1:windings-1])
	{
		translate([i*2*r, 0, 0])
		winding(r, h, i==windings-1);
	}
}

coil(5);
