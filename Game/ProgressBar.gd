extends Node2D

onready var main_scene = get_tree().current_scene
onready var farmer = get_node("Farmer")
onready var chicken = get_node("Chicken")
onready var bar = get_node("Bar")

func _ready():
	bar.color.b8 = 0

func _process(delta):
	farmer.position.x = (main_scene.farmer_position / main_scene.goal_position) * 200
	chicken.position.x = (main_scene.chicken_position / main_scene.goal_position) * 200
	if main_scene.difficulty <= 2.5:
		bar.color.r8 = int(main_scene.difficulty * 255.0 / 2.5)
		bar.color.g8 = 255
	else:
		bar.color.r8 = 255
		bar.color.g8 = 255 - int(main_scene.difficulty * 255 / 4.0)
