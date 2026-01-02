extends Label
@onready var boar_state_machine: StateMachine = $"../BoarStateMachine"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#text = boar_state_machine.state
