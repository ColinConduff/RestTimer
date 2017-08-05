using Toybox.WatchUi as UI;

class RestTimerController extends UI.InputDelegate {

	var restTimerModel;
	var weakRestTimerView;
	var timePickerController;
	
	function initialize(weakRestTimerView) {
		InputDelegate.initialize();
		restTimerModel = new RestTimerModel(self.weak());
		self.weakRestTimerView = weakRestTimerView;
	}
	
	// InputDelegate method
	function onKey(keyEvent) {
        if (keyEvent.getKey() == UI.KEY_ENTER) {
        	didPressEnterButton();
        }
    }
	
	function didPressEnterButton() {
		var timerIsOn = restTimerModel.timerIsRunning();
        restTimerModel.resetTimers();
        
        if (!timerIsOn) {
        	if (timePickerController == null) {
	    		timePickerController = new TimePickerController(self.weak());
	    	}
	    	timePickerController.displayTimePicker();
        }
	}
	
	function startTimers(restTime) {
		restTimerModel.startTimers(restTime);
	}
	
	// called from RestTimerModel
	function timerDidChange(time, timerIsOn) {
		if (weakRestTimerView.stillAlive()) {
			weakRestTimerView.get().updateTimeLabel(TimeFormatter.formatTime(time), timerIsOn);
		}
	}
	
	// called from RestTimerModel
	function totalTimeDidChange(totalTimeInSeconds) {
		if (weakRestTimerView.stillAlive()) {
			weakRestTimerView.get().updateTotalTimeLabel(TimeFormatter.formatTime(totalTimeInSeconds));
		}
	}
}