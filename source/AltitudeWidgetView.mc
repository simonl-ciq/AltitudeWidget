using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Sensor as Sensor;

class AltitudeWidgetView extends Ui.View {
	hidden var mNotMetric = false;  // ie they are Sys.UNIT_METRIC by default
	hidden var mConvert = 1.0;
	hidden var mTitle = "Altitude";

    function initialize() {
		mNotMetric = Sys.getDeviceSettings().elevationUnits != Sys.UNIT_METRIC;
    	mConvert = mNotMetric ? 3.280839895 : 1.0;

        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
		View.setLayout(Rez.Layouts.MainLayout(dc));
    	mTitle = "Altitude (" + (mNotMetric ? "ft" : "m") + ")";
        View.findDrawableById("title").setText(mTitle);
        View.findDrawableById("value").setText("0000");
    }
    
    // Update the view
    function onUpdate(dc) {
	    var sensorInfo = Sensor.getInfo();

    	if (sensorInfo.altitude != null) {
   			var alt = sensorInfo.altitude;
   			alt = Math.round(alt * mConvert);
       		alt = (alt.toNumber()).toString();
			View.findDrawableById("value").setText(alt);
   	    } else {
			View.findDrawableById("title").setText(mTitle + "\nnot available");
			View.findDrawableById("value").setText("0000");
        }

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}

(:glance)
class AltitudeWidgetGlanceView extends Ui.GlanceView {
	hidden var mNotMetric = false;  // ie they are Sys.UNIT_METRIC by default
	hidden var mConvert = 1.0;

	var centre=80;
	var vcentre=80;

	function initialize() {
		mNotMetric = Sys.getDeviceSettings().elevationUnits != Sys.UNIT_METRIC;
    	mConvert = mNotMetric ? 3.280839895 : 1.0;
		GlanceView.initialize();
	}
	
	function onLayout(dc) {
		var dim = dc.getTextDimensions("Simply Altitude", Gfx.FONT_SMALL);
		centre = dim[0] / 2;
		vcentre = dim[1] - 10;
	}

	function onUpdate(dc) {
	    var sensorInfo = Sensor.getInfo();

		dc.setColor(Gfx.COLOR_BLACK,Gfx.COLOR_BLACK);
		dc.clear();
		dc.setColor(Gfx.COLOR_WHITE,Gfx.COLOR_TRANSPARENT);

		dc.drawText(0, -7, Gfx.FONT_SMALL, "Simply Altitude", Gfx.TEXT_JUSTIFY_LEFT);
		dc.setColor(Gfx.COLOR_DK_GREEN,Gfx.COLOR_TRANSPARENT);
    	if (sensorInfo.altitude != null) {
   			var elev = sensorInfo.altitude;
   			elev = Math.round(elev * mConvert);
       		var alt = (elev.toNumber()).toString();
			dc.drawText(centre, vcentre, Gfx.FONT_MEDIUM, alt + (mNotMetric ? "ft" : "m"), Gfx.TEXT_JUSTIFY_CENTER);
        } else {
			dc.drawText(centre, vcentre, Gfx.FONT_SMALL, "not available", Gfx.TEXT_JUSTIFY_CENTER);
		}

	}

}
