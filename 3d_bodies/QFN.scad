/*
 * OpenSCAD library for QFN packages
 * Author: Matthias Bock <mail@matthiasbock.net>
 * License: GNU GPL Version 3
 */

$fn = 50;

pin_width = 0.3;
pin_depth = 0.5;
pin_height = 0.2;
pin_spacing = 0.5;
pin_standout = 0.05;

module qfn_pin()
{
    color("silver")
    translate([0, -pin_standout, -pin_standout])
    cube([pin_width, pin_depth, pin_height]);
}

module qfn_pin_row(count)
{
    for (i = [0:count-1])
    {
        translate([i*pin_spacing,0]) qfn_pin();
    }
}

module qfn48(line1, line2, line3)
{
    width_x = 7;
    width_y = 7;
    
    //
    // package body
    //
    color("black")
/*    difference()
    {
*/
        cube([width_x, width_y, 1]);
/*        
        translate([0.8, width_y-0.8, 1])
        sphere(0.4);
    }
*/

    //
    // ground pad
    //
    translate([1, 1, -pin_standout])
    color("silver")
    difference()
    {
        cube([width_x-2, width_y-2, pin_height]);
        
        translate([0, width_y-2.7, -0.1])
        rotate(45)
        cube([2, 1, pin_height+0.2]);
    }

    //
    // pins
    //
    module qfn48_pin_row()
    {
        translate([(width_x/2)-(4*pin_width)-(3.5*pin_spacing),0])
        qfn_pin_row(12);
    }
    
    qfn48_pin_row();

    translate([width_x,0])
    rotate([0,0,90])
    qfn48_pin_row();

    translate([width_x,width_y])
    rotate([0,0,180])
    qfn48_pin_row();
    
    translate([0,width_y])
    rotate([0,0,270])
    qfn48_pin_row();

    //
    // pin 1 marking
    //
    text_standoff = 0.05;

    color("silver")
    translate([1, width_y-1])
    cylinder(r=0.3, h=1+text_standoff);
    
    //
    // inscription text
    //
    font = "Courier New";
    size = 0.7;
    margin_x = 1.2;
    margin_y = 2;
    line_spacing = 1;
    
    if (line1 != "")
    {
        translate([margin_x, width_y-margin_y, 1])
        linear_extrude(height = text_standoff)
        text(line1, size=size, font=font);
    }

    if (line2 != "")
    {
        translate([margin_x, width_y-margin_y-line_spacing,1])
        linear_extrude(height = text_standoff)
        text(line2, size=size, font=font);
    }

    if (line3 != "")
    {
        translate([margin_x, width_y-margin_y-2*line_spacing,1])
        linear_extrude(height = text_standoff)
        text(line3, size=size, font=font);
    }
}

// demo
qfn48("Nordic", "nRF51822", "QFAA");
