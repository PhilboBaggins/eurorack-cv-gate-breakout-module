$fn = 64;

include <eurorack-common/panels.scad>
include <eurorack-common/Switchcraft_35RAPC2AV.scad>

pcbHeight = 100;
pcbWidth = 15;
pcbThickness = 1.6;

yOffsetPCB = (EURORACK_PANEL_HEIGHT - pcbHeight) / 2;
xOffsetPCB = 4.3 + (EURORACK_PANEL_WIDTH_4HP - 4.3 - 7.0 - 4.4) / 2;

yPosConn = [10, 25, 75, 90];

module EurorackCvGateBreakoutModule_PCB()
{
    color("green")
    if ($preview)
    {
        // Use Upverters' 3D model when doing a preview ...
        scale([1, 1, pcbThickness * 2])
        translate([0, 0, pcbThickness/3])
        import("../PCB/Upverter exports/3D model.stl");
    }
    else
    {
        // ... but just use a dummy object when doing a render because
        // Upverter's 3D model makes the render fail
        cube([pcbWidth, pcbHeight, pcbThickness]);
    }
}

module EurorackCvGateBreakoutModule_Panel_2D()
{
    xOffset = xOffsetPCB + 35RAPC2AV_JACK_RADIUS + 4.4 - 1;
    yOffset = yOffsetPCB;

    difference()
    {
        EurorackPanel_4HP();

        translate([xOffset, yOffset, 0])
        for (yPos = yPosConn)
        {
            translate([0, yPos, 0])
            circle(r=35RAPC2AV_JACK_RADIUS);
        }
    }
}

module panelText(size, txt)
{
    text(size=size, valign="center", font="Helvetica", txt);
}

module EurorackCvGateBreakoutModule_Panel_3D()
{
    linear_extrude(height = EURORACK_PANEL_THICKNESS)
    EurorackCvGateBreakoutModule_Panel_2D();

    translate([0, yOffsetPCB, EURORACK_PANEL_THICKNESS])
    linear_extrude(height = EURORACK_PANEL_THICKNESS/3)
    {
        translate([2, yPosConn[0]]) panelText(2.3, "Gate");
        translate([2, yPosConn[1]]) panelText(2.3, "Gate");
        translate([2, yPosConn[2]]) panelText(2.3, "CV");
        translate([2, yPosConn[3]]) panelText(2.3, "CV");
    }
}

module EurorackCvGateBreakoutModule_Assembly()
{
    EurorackCvGateBreakoutModule_Panel_3D();

    translate([xOffsetPCB, yOffsetPCB, 0])
    {
        translate([-pcbThickness, 0, 0])
        rotate([0, 90, 0]) EurorackCvGateBreakoutModule_PCB();

        for (yPos = yPosConn)
        {
            translate([0, yPos, 0])
            rotate([0, 90, 0])
            Switchcraft35RAPC2AV();
        }
    }
}

//EurorackCvGateBreakoutModule_PCB();
//EurorackCvGateBreakoutModule_Panel_2D();
//EurorackCvGateBreakoutModule_Panel_3D();
//EurorackCvGateBreakoutModule_Assembly();
