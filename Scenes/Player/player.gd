extends CharacterBody2D

const RUN_SPEED: float = 350.0
const TURN_SPEED: float = .05
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3

@export var Bullet: PackedScene
@export var fire_rate: float = 0.2
@export var cooldown_timer: float
var left_cooldown_timer: float = 0.0
var right_cooldown_timer: float = 0.0
var fireLeft: bool = false
var torso: Sprite2D = null
var legs: Sprite2D = null

enum PLAYER_STATE { IDLE, RUN, JUMP, FALL, HURT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE

func _ready():
	torso = $Torso
	legs = $Legs
	
func _process(delta):
	decrement_cooldown(delta)
	turn_torso()
	get_input()
	move_and_slide()
	#calc_state()
	

func _physics_process(delta):
	pass

func decrement_cooldown(delta):
	if left_cooldown_timer > 0.0:
		left_cooldown_timer -= (10 * delta)
		
	if right_cooldown_timer > 0.0:
		right_cooldown_timer -= (10 * delta)
	
func turn_torso():
	torso.look_at(get_global_mouse_position())
	
func get_input() -> void:
	velocity.x = 0
	velocity.y = 0
	
	# Left and Right Bullet
	if Input.is_action_pressed("move_left"):
		velocity.x = -RUN_SPEED
		legs.rotation = deg_to_rad(270)
	elif Input.is_action_pressed("move_right"):
		velocity.x = RUN_SPEED
		legs.rotation = deg_to_rad(90)
	# Up and Down buttons	
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
	
	if Input.get_action_raw_strength("shoot"):
		# Check if the weapons are cooled down
		if left_cooldown_timer <= 0.0 or right_cooldown_timer <= 0.0:
			var temp = Bullet.instantiate()
			add_sibling(temp)
			
			# Alternate firing from left and right cannons
			if fireLeft:
				# Aim the laser towards the mouse
				
				temp.global_position = $Torso.get_node("CannonLeft").get("global_position")
				fireLeft = false
				left_cooldown_timer = cooldown_timer
				right_cooldown_timer = cooldown_timer
			else:
				temp.global_position = $Torso.get_node("CannonRight").get("global_position")
				fireLeft = true
				right_cooldown_timer = cooldown_timer
				left_cooldown_timer = cooldown_timer
			
			# Turn the laser to face the mouse/cursor
			temp.rotation = get_local_mouse_position().angle() - deg_to_rad(90)
			temp.set("area_direction", (get_global_mouse_position() - self.global_position).normalized())

	

#func _on_hit_box_area_entered(area):
	#print("Player HitBox: ", area)

