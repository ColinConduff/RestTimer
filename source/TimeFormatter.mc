
class TimeFormatter {
	static function formatTime(seconds) {
		var minutes = seconds / 60;
		var minutesLabel = minutes > 9 ? minutes.format("%02d") : minutes.format("%01d");
		
		return {
			:minutes => minutesLabel,
			:seconds => (seconds % 60).format("%02d")
		};
	}
}