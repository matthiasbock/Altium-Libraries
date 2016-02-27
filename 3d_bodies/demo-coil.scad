
facets = 100;

module winding_rectangular(radius, width, height, draw_cap)
{
	translate([0, -width/2, -height/2])
	sphere(r=radius, $fn=facets);

	// left wire
	translate([0, -width/2, 0])
	cylinder(r=radius, h=height, center=true, $fn=facets);

	translate([0, +width/2, -height/2])
	sphere(r=radius, $fn=facets);

	// right wire
	translate([0, +width/2, 0])
	cylinder(r=radius, h=height, center=true, $fn=facets);

	translate([0, +width/2, +height/2])
	sphere(r=radius, $fn=facets);

    // bottom wire
	translate([0, 0, -height/2])
	rotate([90, 0, 0])
	cylinder(r=radius, h=width, center=true, $fn=facets);

	translate([0, -width/2, +height/2])
	sphere(r=radius, $fn=facets);

	// top wire
	translate([+radius, 0, +height/2])
	rotate([90, 0, atan(2*radius/width)])
	cylinder(r=radius, h=width, center=true, $fn=facets);

	// final wire cap
	if (draw_cap == true)
	{
		translate([2*radius, -width/2, +height/2])
		sphere(r=radius, $fn=facets);
	}
}

module coil_rectangular(windings)
{
	r = 1;
    w = 15;
	h = 10;

	for (i = [0:1:windings-1])
	{
		translate([i*2*r, 0, 0])
		winding_rectangular(r, w, h, i==windings-1);
	}
}

coil_rectangular(5);
