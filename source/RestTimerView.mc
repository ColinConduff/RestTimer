using Toybox.WatchUi as UI;
using Toybox.Graphics as Graphics;
using Toybox.Sensor as Sensor;

class RestTimerView extends UI.View {

	const AGE = 25; // Move to model
	var maxHeartRate = 196; // Move to model
	
	var timerIsOn = false;
	var restTimeMinutes = "";
	var restTimeSeconds = "";
	var totalTime = "0:00";
	
	var heartRate = "0";
	var hrZone = "0";
	
	var topLine;
    var bottomLine;

    function initialize() {
        View.initialize();
        
        // Move to model
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        Sensor.enableSensorEvents(method(:onSensor));
        maxHeartRate = calculateMaxHeartRate(AGE);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.RestTimerLayout(dc));
        topLine = new Rez.Drawables.TopLine();
        bottomLine = new Rez.Drawables.BottomLine();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc); // Call the parent onUpdate function to redraw the layout
        
        topLine.draw(dc);
        bottomLine.draw(dc);
        updateLabels();
    }
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function updateTimeLabel(restTime, timerIsOn) {
    	self.timerIsOn = timerIsOn; // Move to controller
    	self.restTimeMinutes = timerIsOn ? restTime[:minutes] : ""; // Move to controller
    	self.restTimeSeconds = timerIsOn ? restTime[:seconds] : ""; // Move to controller
    	UI.requestUpdate();
    }
    
    function updateTotalTimeLabel(totalTimeDict) {
    	self.totalTime = totalTimeDict[:minutes] + ":" + totalTimeDict[:seconds]; // Move to controller
    	UI.requestUpdate();
    }
    
    // Move to controller
    function onSensor(sensorInfo) {
    	if (sensorInfo.heartRate) {
    		heartRate = sensorInfo.heartRate.format("%d");
    		
    		var zone = getHeartRateZone(maxHeartRate, sensorInfo.heartRate);
    		hrZone = zone.format("%d") + ".0";
    	}
    }
    
    function updateLabels() {
    	self.findDrawableById("TotalTimeText").setText(totalTime);
    	
    	var titleColor = timerIsOn ? Graphics.COLOR_BLACK : Graphics.COLOR_BLUE;
    	self.findDrawableById("TitleLabel").setColor(titleColor);
    	
    	var colonColor = timerIsOn ? Graphics.COLOR_WHITE : Graphics.COLOR_BLACK;
    	self.findDrawableById("ColonText").setColor(colonColor);
    	
    	self.findDrawableById("MinutesText").setText(restTimeMinutes);
    	self.findDrawableById("SecondsText").setText(restTimeSeconds);
    	
    	self.findDrawableById("HeartRateText").setText(heartRate);
    	self.findDrawableById("HRZoneText").setText(hrZone);
    }
    
    // Move to model
    function getHeartRateZone(maxHeartRate, currentHeartRate) {
		/*
		Zone 1: Warm Up - 0-60% max heart rate
		Zone 2: Easy - 60-70% max heart rate
		Zone 3: Aerobic - 70-80% max heart rate
		Zone 4: Threshold - 80-90% max heart rate
		Zone 5: Maximum - 90-100% max heart rate
		*/
		if (currentHeartRate == null || maxHeartRate == 0) {
			return 0;
		}
		var percentOfMax = (currentHeartRate / maxHeartRate) * 100;
		
		if (percentOfMax < 60) {
			return 1;
		} else if (percentOfMax < 70) {
			return 2;
		} else if (percentOfMax < 80) {
			return 3;
		} else if (percentOfMax < 90) {
			return 4;
		} else {
			return 5;
		}
	}
	
    // Move to model
	function calculateMaxHeartRate(age) {
		return 217 - (0.85 * age);
	}
}
