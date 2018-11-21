extends Node2D

onready var chicken = get_node("Chicken")
onready var gen_src = get_node("ObstacleGen/GenSrc")
onready var main_scene = get_tree().current_scene

var time_since_last_spawn = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var speed = main_scene.chicken_speed
	var difficulty = main_scene.difficulty
	time_since_last_spawn += delta
	if speed > 0.0 and time_since_last_spawn > 350.0 / (speed * difficulty):
		gen_src.spawn()
		time_since_last_spawn = 0.0
	
