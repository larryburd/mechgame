extends CharacterBody2D

class_name Player

const RUN_SPEED: float = 350.0
const TURN_SPEED: float = .05
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3

var torso = null
var legs = null

enum PLAYER_STATE { IDLE, RUN, JUMP, FALL, HURT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE

func _ready():
	torso = $Torso
	legs = $Legs
	
func _process(delta):
	turn_torso()
	get_input()
	move_and_slide()
	#calc_state()
	

func _physics_process(delta):
	pass
	
func turn_torso():
	torso.look_at(get_global_mouse_position())
	
func get_input() -> void:
	velocity.x = 0
	velocity.y = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -RUN_SPEED
		legs.rotation = deg_to_rad(270)
	elif Input.is_action_pressed("move_right"):
		velocity.x = RUN_SPEED
		legs.rotation = deg_to_rad(90)
	if Input.is_action_pressed("move_up"):
		velocity.y = -RUN_SPEED
		if Input.is_action_pressed("move_left"):
			legs.rotation = deg_to_rad(315)
		elif Input.is_action_pressed("move_right"):
			legs.rotation = deg_to_rad(45)
		else:
			legs.rotation = 0
	elif Input.is_action_pressed("move_down"):
		velocity.y = RUN_SPEED
		if Input.is_action_pressed("move_left"):
			legs.rotation = deg_to_rad(225)
		elif Input.is_action_pressed("move_right"):
			legs.rotation = deg_to_rad(135)
		else:
			legs.rotation = deg_to_rad(180)

		
	# velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)
	

#func calc_state() -> void:
	#if _state == PLAYER_STATE.HURT:
		#return
		#
	#if is_on_floor():
		#if velocity.x == 0:
			#set_state(PLAYER_STATE.IDLE)
		#else:
			#set_state(PLAYER_STATE.RUN)  
	#else:
		#if velocity.y > 0:
			#set_state(PLAYER_STATE.FALL)
		#else:
			#set_state(PLAYER_STATE.JUMP)
	

#func set_state(new_state: PLAYER_STATE) -> void:
	#if new_state == _state:
		#return
		#
	#if _state == PLAYER_STATE.FALL:
		#if new_state == PLAYER_STATE.IDLE or new_state == PLAYER_STATE.RUN:
			#SoundManager.play_clip(sound_player, SoundManager.SOUND_LAND)
	#
	#_state = new_state
	#
	#match _state:
		#PLAYER_STATE.IDLE:
			#animation_player.play("idle")
		#PLAYER_STATE.RUN:
			#animation_player.play("run")
		#PLAYER_STATE.JUMP:
			#animation_player.play("jump")
		#PLAYER_STATE.FALL:
			#animation_player.play("fall")	
#
#
#func _on_hit_box_area_entered(area):
	#print("Player HitBox: ", area)

