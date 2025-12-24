extends Node2D
const BOAR = preload("res://Scenes/boar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_boar := BOAR.instantiate()
	new_boar.position = position
	get_parent().add_child(new_boar)
