using Toybox.Application as App;
using Toybox.WatchUi as UI;

class RestTimerApp extends App.AppBase {

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
    	var restTimerView = new RestTimerView();
    	var controller = new RestTimerController(restTimerView.weak());
    	return [restTimerView, controller];
    }
}