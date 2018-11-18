extends Node2D

var speed = 0
var boosting = false

const regular_acceleration = 25.0
const boost_acceleration = 50.0
const regular_max_speed = 150.0
const boost_max_speed = 300.0

onready var sprite = get_node("AnimatedSprite")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Input.connect("joy_connection_changed",self,"joy_con_changed")

func move_left():
	self.position.x -= int(speed / 20.0)

func move_right():
	self.position.x += int(speed / 20.0)

func accelerate(accel_rate, delta):
	speed += accel_rate * delta
	sprite.frames.set_animation_speed('run', int(speed / 10.0))

func _process(delta):
	if boosting and speed < boost_max_speed:
		accelerate(boost_acceleration, delta)
	elif not boosting and speed < regular_max_speed:
		accelerate(regular_acceleration, delta)
	
	if Input.is_action_pressed("ui_left"):
		move_left()
	elif Input.is_action_pressed("ui_right"):
		move_right()
