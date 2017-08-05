using Toybox.Timer as Timer;
using Toybox.Attention as Attention;

class RestTimerModel {

	hidden var weakController;
	
	private var timerIsOn = false;
	private var timeLeft = 0;
	private var displayTimer = new Timer.Timer();
	private var restTimer = new Timer.Timer();
	
	private var totalTimeInSeconds = 0;
	private var totalTimer = new Timer.Timer();

	function initialize(weakController) {
		self.weakController = weakController;
		self.totalTimer.start(method(:onTotalTime), 1000, true);
	}
	
	function onTotalTime() {
		totalTimeInSeconds++;
		totalTimeDidChange();
	}

	// Called from TimePickerController
	function startTimers(restTime) {
		self.timerIsOn = true;
		
		var restTimeInMS = restTime * 1000;
		self.restTimer.start(method(:stopTimers), restTimeInMS, false);
		
		self.displayTimer.start(method(:refresh), 1000, true);
		self.timeLeft = restTime;
		
		timerDidChange();
	}
	
	// Called from RestTimerController
	function resetTimers() {
		self.displayTimer.stop();
		self.restTimer.stop();
		
		self.timerIsOn = false;
		self.timeLeft = 0;
		
		timerDidChange();
	}
	
	// Called from RestTimerController
	function timerIsRunning() {
		return self.timerIsOn;
	}
	
	function stopTimers() {
		resetTimers();
		playTone(Attention.TONE_LOUD_BEEP); // move to controller
	}

	function refresh() {
		if (timeLeft > 0) { timeLeft--; } 
		timerDidChange();
	}

	 // move to controller
	function playTone(tone) {
		if (Attention has :playTone) { 
			Attention.playTone(tone);
		}
	}
	
	// Notify RestTimerController
	function timerDidChange() {
		if (weakController.stillAlive()) {
			weakController.get().timerDidChange(timeLeft, timerIsOn);
		}
	}
	
	// Notify RestTimerController
	function totalTimeDidChange() {
		if (weakController.stillAlive()) {
			weakController.get().totalTimeDidChange(totalTimeInSeconds);
		}
	}
}
