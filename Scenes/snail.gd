extends CharacterBody2D
enum opponent_states {
	OUT_OF_RANGE,
	CLOSE_RANGE,
	IN_RANGE
}

var opp_state: opponent_states = opponent_states.OUT_OF_RANGE

@export var enter_right: RayCast2D 
@export var enter_left: RayCast2D 
@export var exit_right: RayCast2D 
@export var exit_left: RayCast2D
@export var floor_right: RayCast2D
@export var floor_left: RayCast2D
@onready var sm: StateMachine = $StateMachine
@onready var collide_attack: Attack = $CollideAttack
@onready var snail_label: Label = $SnailLabel


const MAX_SPEED = 75.0
const JUMP_VELOCITY = -400.0
var acceleration: float = 200.0
var decceleration: float = 900.0
var direction: float = 0
var MAX_KNOCKBACK_VELOCITY: float = 1000.0
var chasing: bool = false
var opponent_level: int = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func oppenent_range() -> int:
	var level: int = 0
	if exit_left.is_colliding():
		level -= 1
		if enter_left.is_colliding():
			level -= 1
	if exit_right.is_colliding():
		level += 1
		if enter_right.is_colliding():
			level += 1
			
	return level



func _physics_process(delta: float) -> void:
	collide_attack.do_attack()
	
	determine_opponent_state()
	snail_label.text = opponent_states.keys()[opp_state]
	if direction > 0:
		animated_sprite_2d.flip_h = true
	if direction < 0:
		animated_sprite_2d.flip_h = false
	# Add the gravity.
	
	
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()
	else:
		if direction:
			if velocity.x > MAX_SPEED:
				velocity.x -= decceleration * delta
			
			elif velocity.x < -MAX_SPEED:
				velocity.x += decceleration * delta
				
			else:
				velocity.x += acceleration * direction * delta
		else:
			if velocity.x > 0:
				velocity.x = maxf(velocity.x - decceleration * delta,0)
			
			if velocity.x < 0:
				velocity.x = maxf(velocity.x + decceleration * delta,0)
				
		# Only Move if the object will not fall off edge
		if is_on_floor():
			
			if velocity.x > 0 and floor_right.is_colliding():
				move_and_slide()
			elif velocity.x < 0 and floor_left.is_colliding():
				move_and_slide()
			
			if velocity.x == 0:
				move_and_slide()
		else:
			move_and_slide()
			
	determineState()


func determineState():
	var next_state:String = "Idle"
	
	if abs(velocity.x) > 0:
		next_state = "Crawl"
		
	sm.state = next_state
	
	
func _on_hurt_box_damaged(attack: Attack, hit_vector: Vector2, amount: float, new_health: float) -> void:
	sm.state = "Hit"
	velocity = hit_vector * attack.knockback * MAX_KNOCKBACK_VELOCITY
	velocity.y /= 1.5


func determine_opponent_state():
	opponent_level = oppenent_range()
	direction = 0
	
		
	var abs_level := absi(opponent_level)
	if abs_level == 0:
		opp_state = opponent_states.OUT_OF_RANGE
		chasing = false
	elif abs_level == 1:
		opp_state = opponent_states.CLOSE_RANGE
	
	elif abs_level == 2:
		opp_state = opponent_states.IN_RANGE
		chasing = true
		
		
	if opponent_level > 0 and chasing:
		direction = 1
	elif opponent_level < 0 and chasing:
		direction = -1
		
