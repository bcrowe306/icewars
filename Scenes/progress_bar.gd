extends ProgressBar
@onready var boar_stats: Stats = $"../BoarStats"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_value = boar_stats.max_health # Replace with function body.
	self.min_value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	self.value = boar_stats.health
