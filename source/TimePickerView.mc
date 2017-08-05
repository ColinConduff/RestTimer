using Toybox.WatchUi as UI;
using Toybox.Graphics as Graphics;

class TimePickerView extends UI.Picker {

	function initialize(options, lastPickedIndex) {
		UI.Picker.initialize({
			:pattern => [new DigitFactory(options)],
			:defaults => [lastPickedIndex]
		});
	}
	
	function onUpdate(dc) {
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
  	}
}


class DigitFactory extends UI.PickerFactory {

    hidden var options;

    function initialize(options) {
      	PickerFactory.initialize();
      	self.options = options;
    }

    function getValue(index) {
      	return options[index];
    }

    function getDrawable(index, selected) {
    
    	var time = TimeFormatter.formatTime(options[index]);
    	var text = time[:minutes] + ":" + time[:seconds];
    
        return new UI.Text({ 
        	:text => text, 
        	:color => Graphics.COLOR_WHITE, 
        	:font => Graphics.FONT_LARGE, 
        	:locX => UI.LAYOUT_HALIGN_CENTER, 
        	:locY => UI.LAYOUT_VALIGN_CENTER 
        });
    }

    function getSize() {
        return options.size();
    }
}
