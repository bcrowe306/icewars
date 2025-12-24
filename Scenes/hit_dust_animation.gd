extends AnimatedSprite2D
@onready var player_controller: PlayerController = $".."
var direction: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_finished.connect(on_finished) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_controller.facing_direction != direction:
		if player_controller.facing_direction:
			position.x = abs(position.x)
			rotation = abs(rotation)
		else:
			position.x = -abs(position.x)
			rotation = -abs(rotation)
		direction = player_controller.direction

func playAnimation():
	
	visible = true
	flip_h = !flip_h
	play()

func on_finished():
	visible = false


func _on_player_attack_1_hitbox_hit_registered(target: Node) -> void:
	playAnimation() 


func _on_attack_2_hitbox_hit_registered(target: Node) -> void:
	playAnimation() 


func _on_attack_3_hitbox_hit_registered(target: Node) -> void:
	playAnimation()
