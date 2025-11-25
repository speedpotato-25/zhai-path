extends CharacterBody2D

#variables
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
var SPEED : int = 1000
var JUMP_VELOCITY : int = -1250
var sprint : bool = false
var drag_coeff: float
var drag_force : float
var max_fall_speed : float = 800.0


func _ready() -> void:
	gravity = 2500
	position.y = -1000

func _physics_process(delta: float) -> void:
	_movement()
	_sprint()
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)	
	
	

func _sprint():
	if Input.is_action_just_pressed("sprint"):
		sprint = true
	else :
		sprint = false
	if sprint:
		SPEED += 500

func _movement():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
