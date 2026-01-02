extends CharacterBody2D
class_name Snail

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
@onready var snail_label: Label = $SnailLabel
@onready var collide_attack: Attack = $CollideAttack


const MAX_SPEED = 150.0
const JUMP_VELOCITY = -400.0
var acceleration: float = 300.0
var decceleration: float = 900.0
var direction: float = 0
var MAX_KNOCKBACK_VELOCITY: float = 1000.0
var chasing: bool = false
var opponent_level: int = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var snail_progress_bar: ProgressBar = $SnailProgressBar
@onready var snail_stats: Stats = $SnailStats

func update_health_bar():
	snail_progress_bar. min_value = 0
	snail_progress_bar.max_value = snail_stats.max_health
	snail_progress_bar.value = snail_stats.health

func _ready() -> void:
	update_health_bar()
	collide_attack.do_attack()

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
	update_health_bar()
	
	determine_opponent_state()
	snail_label.text = sm.state
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
			
			# Clamp velocity to max speed in either direction
			if velocity.x > MAX_SPEED:
				velocity.x -= decceleration * delta
			
			elif velocity.x < -MAX_SPEED:
				velocity.x += decceleration * delta
				
			# This is the case where we actually move the enitity
			else:
				
				# Only move in desired direction on certain states:
				if sm.state != "Dying":
					velocity.x += acceleration * direction * delta
				else:
					velocity.x = 0
		# Direction is zero, meaning the NPC doesn't want to move in any direction. Decceleration logic here
		else:
			if velocity.x > 0:
				velocity.x = maxf(velocity.x - decceleration * delta, 0)
			
			elif velocity.x < 0:
				velocity.x = minf(velocity.x + decceleration * delta, 0)
				
		# Only Move if the object will not fall off edge
		if velocity.x > 0 and not floor_right.is_colliding():
			velocity.x = 0
		elif velocity.x < 0 and not floor_left.is_colliding():
			velocity.x = 0
		
		move_and_slide()
			
	determineState()


func determineState():
	var next_state:String = "Idle"
	if abs(velocity.x) > 0:
		next_state = "Crawl"
		
	sm.state = next_state
	
	
func _on_hurt_box_damaged(attack: Attack, hit_vector: Vector2, _amount: float, new_health: float) -> void:
	if new_health > 0.0:
		if sm.state == "Hit":
			var state: State = sm.get_state("Hit")
			state.animated_sprite.frame = 0
			state.__re_enter()
		else:
			
			sm.state = "Hit"
		velocity = hit_vector * attack.knockback * MAX_KNOCKBACK_VELOCITY
		velocity.y /= 1.5
	else:
		sm.state = "Dying"
		


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
		


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "Dying":
		queue_free() # Replace with function body.
