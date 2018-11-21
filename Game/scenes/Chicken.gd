extends Node2D

var speed = 0

onready var main_scene = get_tree().current_scene
onready var sprite = get_node("AnimatedSprite")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Input.connect("joy_connection_changed",self,"joy_con_changed")

func move_left():
	self.position.x -= int(speed / 20.0)

func move_right():
	self.position.x += int(speed / 20.0)

func _update_animation_speed():
	sprite.frames.set_animation_speed('run', int(speed / 10.0))

func _process(delta):
	if main_scene.chicken_speed != speed:
		speed = main_scene.chicken_speed
		_update_animation_speed()
	if Input.is_action_pressed("ui_left"):
		move_left()
	elif Input.is_action_pressed("ui_right"):
		move_right()
