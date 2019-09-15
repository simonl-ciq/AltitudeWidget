using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Sensor as Sensor;

class AltitudeWidgetView extends Ui.View {
	hidden var mNotMetric = false;  // ie they are Sys.UNIT_METRIC by default
	hidden var mConvert = 1.0;
	hidden var mTitle = "Altitude";

    function initialize() {
    var units = Sys.getDeviceSettings().elevationUnits;
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

    	if (sensorInfo has :altitude) {
	    	if (sensorInfo.altitude != null) {
    			var alt = sensorInfo.altitude;
    			alt = Math.round(alt * mConvert);
        		alt = (alt.toNumber()).toString();
				View.findDrawableById("value").setText(alt);
    	    } else {
				View.findDrawableById("title").setText(mTitle + "\nnot available");
				View.findDrawableById("value").setText("0000");
	        }
   	    } else {
			View.findDrawableById("title").setText(mTitle + "\nnot supported");
			View.findDrawableById("value").setText("0000");
		}

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}

(:glance)
class AltitudeWidgetGlanceView extends Ui.GlanceView {

	function initialize() {
		GlanceView.initialize();
	}

	function onUpdate(dc) {
		dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
		dc.clear();
		dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);

		dc.drawText(0, 10, Graphics.FONT_SMALL,"Simply Altitude", Graphics.TEXT_JUSTIFY_LEFT);
	}

}
