using Toybox.Application as App;

class AltitudeWidgetApp extends App.AppBase {
	hidden var AltView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        AltView = new AltitudeWidgetView();
        return [ AltView, new AltitudeWidgetDelegate() ];
    }

(:glance)
    function getGlanceView() {
        return [ new AltitudeWidgetGlanceView() ];
    }

}