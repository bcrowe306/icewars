extends CharacterBody2D
@onready var enter_right: RayCast2D = $EnterRight
@onready var enter_left: RayCast2D = $EnterLeft
@onready var exit_right: RayCast2D = $ExitRight
@onready var exit_left: RayCast2D = $ExitLeft
@onready var opp_state_label: Label = $OppStateLabel


const SPEED = 180.0
const JUMP_VELOCITY = -400.0
var direction: float = 0.0
var chasing: bool = false
@export var enabled: bool = true

enum opponent_states {
	OUT_OF_RANGE,
	CLOSE_RANGE,
	IN_RANGE
}

var opp_state: opponent_states = opponent_states.OUT_OF_RANGE


func is_entered() -> float:
	if enter_right.is_colliding() and exit_right.is_colliding():
		return 1
	
	if enter_left.is_colliding() and exit_left.is_colliding():
		return -1
	return 0
	
func is_exited() -> float:
	if enter_right.is_colliding() == false and exit_right.is_colliding():
		return 1
	
	if enter_left.is_colliding() == false and exit_left.is_colliding():
		return -1
	return 0
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction: float = 0.0
	if enabled:
	
		determine_opponent_state()
		opp_state_label.text = opponent_states.keys()[opp_state]
		if direction and chasing:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
	
func determine_opponent_state():
	var entered := is_entered()
	if entered:
		direction = entered
		opp_state = opponent_states.IN_RANGE
		chasing = true
		return
	var exited: float = is_exited()
	if exited:
		direction = exited
		opp_state = opponent_states.CLOSE_RANGE
		return
	
	direction = 0
	chasing = false
	opp_state = opponent_states.OUT_OF_RANGE
	
