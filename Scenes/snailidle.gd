extends State

@onready var collide_attack: Attack = $"../../CollideAttack"

func _enter(_previous_state: String):
	collide_attack.do_attack()
	animated_sprite.play(animation_name)

func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	pass
	
func state_guard(_next_state: String):
	pass
