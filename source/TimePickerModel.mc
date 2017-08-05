
// Singleton 
class TimePickerModel {
	const OPTIONS = [30, 45, 60, 90, 120, 180];
	var lastPickedIndex = 0;
	
	function updateLastPickedIndex(value) {
		lastPickedIndex = OPTIONS.indexOf(value);
	}
}