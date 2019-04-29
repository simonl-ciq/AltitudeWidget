using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Sensor as Sensor;

class AltitudeWidgetView extends Ui.View {
	hidden var mNotMetric = false;  // ie they are Sys.UNIT_METRIC by default
	hidden var mConvert = 1.0;

    function initialize() {
    var units = Sys.getDeviceSettings().elevationUnits;
		mNotMetric = Sys.getDeviceSettings().elevationUnits != Sys.UNIT_METRIC;
    	mConvert = mNotMetric ? 3.280839895 : 1.0;

        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
		View.setLayout(Rez.Layouts.MainLayout(dc));
    	var title = "Altitude (" + (mNotMetric ? "ft" : "m") + ")";
        View.findDrawableById("title").setText(title);
        View.findDrawableById("value").setText("0000");
    }
    
    // Update the view
    function onUpdate(dc) {
	    var sensorInfo = Sensor.getInfo();

    	if (sensorInfo has :altitude && sensorInfo.altitude != null) {
    		var alt = sensorInfo.altitude;
    		alt = Math.round(alt * mConvert);
        	alt = (alt.toNumber()).toString();
			View.findDrawableById("value").setText(alt);
			Sys.println(View.findDrawableById("value").locY);
        } else {
			View.findDrawableById("title").setText("No Altitude");
			View.findDrawableById("value").setText("0000");
        }

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}
