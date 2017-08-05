using Toybox.WatchUi as UI;

class TimePickerController extends UI.PickerDelegate {

	var weakParentController;
	var timePickerModel = new TimePickerModel();

  	function initialize(weakParentController) {
    	PickerDelegate.initialize();
		self.weakParentController = weakParentController;
  	}

	function onAccept(values) {
		timePickerModel.updateLastPickedIndex(values[0]);
		startTimers(values[0]);
		UI.popView(UI.SLIDE_DOWN);
  	}

	function onCancel() {
		UI.popView(UI.SLIDE_DOWN);
	}
	
	// called from RestTimerController
	function displayTimePicker() {
		var view = new TimePickerView(timePickerModel.OPTIONS, timePickerModel.lastPickedIndex);
		UI.pushView(view, self, UI.SLIDE_UP);
	}
	
	function startTimers(restTime) {
		if (weakParentController.stillAlive()) {
			weakParentController.get().startTimers(restTime);
		}
	}
}