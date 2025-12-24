extends ProgressBar
@onready var player_stats: Node = $"../PlayerStats"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	max_value = player_stats.max_health
	value = player_stats.health
