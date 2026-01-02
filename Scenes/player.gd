extends CharacterBody2D
class_name PlayerController
@onready var jump_2_dash: AnimatedSprite2D = $Jump2Dash
@onready var dash_particles_1: CPUParticles2D = $DashParticles1
@onready var dash_particles_2: CPUParticles2D = $DashParticles2
@onready var dash_explosion: CPUParticles2D = $DashExplosion

# Signals
signal camera_shake(amount: float)
signal attack_successful( attack: Attack)

# Exported vars and resources
@export var stats: Stats
@export var sm: StateMachine
@export_range(0, 1.0, .05) var CoyoteTime: float = .5


# Constants
const SPEED = 400.0
const SPEED_BOOST = 1
const JUMP_VELOCITY = -450.0
const MAX_JUMPS: int = 2
const MAX_DASH_VELOCITY: float = 700.0
const MIN_DASH_VELOCITY: float = 75.0


# Public member vars
var accept_input: bool = true
var direction: float
var facing_direction: bool = true
var gravity_multiplier: float = 1
var jump_count: int = 0



func _physics_process(delta: float) -> void:
	_handleGravity(delta)
	_handleDirection()
	_determineState()
	_handleLateralMovement(delta)
	move_and_slide()

func getVelocityPercentage() -> float:
	return abs(velocity.x / SPEED)

func _canJump() -> bool:
	
	if is_on_floor():
		return true
	else:
		var falling_time = sm.get_state("Fall").fall_counter.Count
		if sm.state == "Fall" and sm.previous_state != "Jump":
			if jump_count == 0:
				return falling_time < CoyoteTime
			else:
				return jump_count < MAX_JUMPS
				
		else:
			return jump_count < MAX_JUMPS
	
func resetJumpCount():
	jump_count = 0

func doJump( increase_jump_count: bool = true, multiplier: float = 1.0) -> void:
	velocity.y = JUMP_VELOCITY * multiplier
	if increase_jump_count:
		jump_count += 1
	
	
func _getSpeed() -> float:
	return SPEED * SPEED_BOOST
	

func _handleLateralMovement(delta: float):
	var max_speed = _getSpeed()
	
	if direction:
		#mock_velocity.x = clamp(mock_velocity.x + direction * ACCELERATION * delta, -max_speed, max_speed)
		velocity.x = clamp(velocity.x + direction * stats.acceleration * delta, -max_speed, max_speed)
		#velocity.x = direction * get_speed()
	else:
		velocity.x = move_toward(velocity.x, 0, stats.acceleration * 1 * delta)

func _handleDirection():
	if accept_input:
		direction = Input.get_axis("DIR_LEFT", "DIR_RIGHT")
		if direction > 0:
			facing_direction = true
			
		elif direction < 0:
			facing_direction = false
			
	else:
		direction = 0.0

func _handleGravity(delta: float):
	if not is_on_floor():
		var gravity: Vector2 = get_gravity() * gravity_multiplier
		if sm.state == "Fall":
			gravity *= 1.6
		velocity += gravity * delta
	else:
		resetJumpCount()
## Perform a horizontal dash in the direction the player is facing. amount is int from 0-10
func doDash(amount: int = 5):
	var dash_direction = 1
	var dash_amount = lerpf(MIN_DASH_VELOCITY, MAX_DASH_VELOCITY, clampf(amount, 0, 10) / 10)
	if !facing_direction:
		dash_direction = -1
	velocity.x += dash_direction * dash_amount
		
		

func _handleAttack() -> String:
	var next_state = "Attack1"
	if sm.state == "Attack1":
		next_state = "Attack2"
	
	if sm.state == "Attack2":
		next_state = "Attack3"
		
	return next_state
		

func _handleStomp(next: String) -> String:
	if sm.state == "Jump" or sm.state == "Jump2" or sm.state == "Fall" or sm.state == "Stomp" or sm.state == "Attack2" or sm.state == "Attack1":
		if is_on_floor():
			return next
		else:
			return "Stomp"
	else:
		return next

func _inputBackPressed():
	if facing_direction:
		return Input.is_action_pressed("DIR_LEFT")
	else:
		return Input.is_action_pressed("DIR_RIGHT")

func _determineState():
	var has_combo_input: bool = false
	var has_input: bool = false
	var next_state = "Idle"
	
	# Process combo inputs 1st
	# Jump attack combo
	if Input.is_action_pressed("DIR_UP") and Input.is_action_just_pressed("ACTION_ATTACK_1"):
		next_state = "AirAttack"
		has_combo_input = true
		
	if Input.is_action_pressed("ACTION_ATTACK_2") and Input.is_action_pressed("ACTION_KICK"):
		has_combo_input = true
		next_state = "IcewaveCharge"
	else:
		if sm.state == "IcewaveCharge":
			has_combo_input = true
			next_state = "Icewave"
	
	if has_combo_input:
		sm.state = next_state
		return
	
	# Process single inputs next
	# Handle jump.
	if Input.is_action_just_pressed("ACTION_JUMP") and _canJump():
		doJump()
		if jump_count == 1:
			next_state = "Jump"
		elif jump_count == 2:
			next_state = "Jump2"
		else:
			next_state = "Jump"
		has_input = true
		
	# Handle Stomp
	if Input.is_action_pressed("DIR_DOWN") and not is_on_floor() and sm.state == "Fall":
		has_input = true
		next_state = _handleStomp(next_state)
	
	# Handle Attack
	if Input.is_action_just_pressed("ACTION_ATTACK_1"):
		has_input = true
		next_state = _handleAttack()
		
	if Input.is_action_just_pressed("ACTION_ATTACK_2"):
		has_input = true
		next_state = "Attack2"
	
	if Input.is_action_just_pressed("ACTION_KICK"):
		next_state = "BackflipAttack"
		has_input = true
	
	if has_input:
		sm.state = next_state
		return
	
	# State based on player velocities
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			next_state = "Run"
	else:
		if velocity.y > 0:
			if sm.state == "Stomp":
					next_state = sm.state
			else:
				next_state = "Fall"
			
		elif velocity.y < 0:
				next_state = "Jump"
			
	# Set the state
	sm.state = next_state


func _on_stomp_hit_box_hit_registered(_target: Node) -> void:
	jump_count = 0
	doJump(false, 1.0)

func _on_attack_1_attack_successful_hit(attack: Attack, _hit_vector: Vector2) -> void:
	camera_shake.emit(attack.camera_shake)
	attack_successful.emit(attack)


func _on_attack_2_attack_successful_hit(attack: Attack, _hit_vector: Vector2) -> void:
	camera_shake.emit(attack.camera_shake)
	attack_successful.emit(attack)


func _on_attack_3_attack_successful_hit(attack: Attack, _hit_vector: Vector2) -> void:
	camera_shake.emit(attack.camera_shake)
	attack_successful.emit(attack)


func _on_stomp_attack_attack_successful_hit(attack: Attack, _hit_vector: Vector2) -> void:
	camera_shake.emit(attack.camera_shake)
	attack_successful.emit(attack)


func _on_jump_attack_attack_successful_hit(attack: Attack, _hit_vector: Vector2) -> void:
	camera_shake.emit(attack.camera_shake)
	attack_successful.emit(attack)


func _on_backflip_kick_attack_attack_successful_hit(attack: Attack, _hit_vector: Vector2) -> void:
	camera_shake.emit(attack.camera_shake)
	attack_successful.emit(attack)


func _on_player_hurt_box_damaged(attack: Attack, _hit_vector: Vector2, _amount: float, _new_health: float) -> void:
	HitstopManager.triggerHitstop(attack.hitstop)
	sm.state = "Hit" # Replace with function body.
