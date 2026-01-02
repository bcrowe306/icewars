extends Label
@onready var player_controller: PlayerController = $".."
@onready var stomp_hit_box: Area2D = $"../StompAttack/StompHitBox"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = player_controller.sm.state
