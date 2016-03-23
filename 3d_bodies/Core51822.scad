$fn = 50;

use <QFN.scad>;

module pin_2mm()
{
    width_x = 1;
    width_y = 1;
    height = 10;
    translate([-width_x/2,-width_y/2])
    {
        // metal
        color("silver")
        cube([width_x,width_y,height]);
        
        // plastic
        color("black")
        translate([-0.5,-0.5,2])
        cube([2,2,1]);
    }
}

module pin_2mm_row(count)
{
    space = 2;
    for (i = [0:count-1])
    {
        translate([i*space,0]) pin_2mm();
    }
}

module core51822()
{
    // 2mm pins
    
    module pin_row_downwards()
    {
        rotate([180,0,90]) pin_2mm_row(9);
    }
    
    translate([02,02,2]) pin_row_downwards();
    translate([04,02,2]) pin_row_downwards();
    translate([16,02,2]) pin_row_downwards();
    translate([18,02,2]) pin_row_downwards();
    
    // board
    color("darkblue")
    cube([20,30,1]);
    
    // components
    translate([6,20,1])
    qfn48("Nordic", "NRF51822", "QFAC");
}

core51822();