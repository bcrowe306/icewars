extends State
@onready var charge: AnimatedSprite2D = $"../../IcewaveAttack/Charge"
@onready var charge_2: AnimatedSprite2D = $"../../IcewaveAttack/Charge2"
@onready var charge_player: AudioStreamPlayer2D = $ChargePlayer


func _enter(_previous_state: String):
	animated_sprite.play(animation_name)
	charge_player.play()
	charge.visible = true
	charge_2.visible = true
	charge.play("default")
	charge_2.play("Spiral")
	
func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	charge.stop()
	charge_2.stop()
	charge.visible = false
	charge_2.visible = false
	
func state_guard(_next_state: String):
	return _next_state == "Icewave"
