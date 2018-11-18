extends Node2D

onready var chicken = get_node("Chicken")
onready var gen_src = get_node("ObstacleGen/GenSrc")
onready var timer = get_node("ObstacleGen/Timer")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	gen_src.vel = chicken.speed
	if chicken.speed > 0:
		timer.wait_time = 100.0 / chicken.speed
	else:
		timer.wait_time = 5000
	
