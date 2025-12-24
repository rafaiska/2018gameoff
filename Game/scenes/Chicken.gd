extends Node2D

var speed = 0

@onready var main_scene = get_tree().current_scene
@onready var sprite = get_node("AnimatedSprite")
@onready var thumble_timer = get_node("ThumbleTimer")
var chicken_limit_l
var chicken_limit_r
var thumbling = false
var crashing = false
var crashing_speed = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#Input.connect("joy_connection_changed", "joy_con_changed")
	pass

func move(move_rate):
	self.position.x += int(speed * move_rate / 20.0)
	if self.position.x <= chicken_limit_l:
		self.position.x = chicken_limit_l
	elif self.position.x >= chicken_limit_r:
		self.position.x = chicken_limit_r

func start_crashing(speed_):
	if speed_ < 100.0:
		crashing_speed = 100.0
	else:
		crashing_speed = speed_
	crashing = true
	get_node("Crashing").start()

func peck():
	sprite.animation = "peck"
	get_node("Pecking").start()

func _update_animation_speed():
	sprite.sprite_frames.set_animation_speed('run', int(speed / 10.0))

func _set_thumble(is_thumbling):
	if is_thumbling:
		if thumble_timer.is_stopped():
			thumble_timer.start()
	else:
		if not thumble_timer.is_stopped():
			thumble_timer.stop()

func _check_movement():
	"""Check if user is moving the joypad sticks accodingly"""
	var l_x_axis = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
	var l_y_axis = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	var r_x_axis = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	var r_y_axis = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	var LR_is_OK = Input.is_action_pressed('controller_L') and Input.is_action_pressed('controller_R')
	if LR_is_OK and l_x_axis < 0.0 and r_x_axis > 0.0:
		_set_thumble(false)
		move((l_y_axis - r_y_axis) / 2.0)
	else:
		_set_thumble(true)

func _process(_delta):
	if main_scene.chicken_speed != speed:
		speed = main_scene.chicken_speed
		_update_animation_speed()
	if crashing:
		sprite.rotation += crashing_speed * 0.001
	_check_movement()

func _on_ThumbleTimer_timeout():
	main_scene.crash()

func _on_Crashing_timeout():
	crashing = false
	sprite.rotation = 0.0


func _on_Pecking_timeout():
	sprite.animation = "run"
