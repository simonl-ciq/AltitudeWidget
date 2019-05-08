using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class AltitudeWidgetDelegate extends Ui.BehaviorDelegate {
    /* Initialize and get a reference to the view, so that
     * user iterations can call methods in the main view. */
// Not needed in this case
     
    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }

    function onSelect() {
//		Sys.println("Select");
        // force a redraw
        Ui.requestUpdate();
        return true;
    }

    /* Menu button press. */
/*
    function onMenu() {
		Sys.println("Menu");
        Ui.requestUpdate();
        return true;
    }
*/
}
