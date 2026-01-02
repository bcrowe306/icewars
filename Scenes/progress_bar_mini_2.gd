extends ProgressBar

class_name ProgressBarMini

@onready var change_timer: Timer = $ChangeTimer
@onready var green: ProgressBar = $Green
@onready var red: ProgressBar = $Red



func _ready() -> void:
	pass
	

func set_min_max(min: float, max: float):
	self.min_value = min
	green.min_value = min
	red.min_value = min
	self.max_value = max
	green.max_value = max
	red.max_value = max
	
	
func _process(delta: float) -> void:
	pass

func set_value_instant(value: float):
	red.value = value
	green.value = value
	
func set_value_animated(value: float):
	green.value = value
	change_timer.start()

	

func _on_change_timer_timeout() -> void:
	red.value = green.value # Replace with function body.
