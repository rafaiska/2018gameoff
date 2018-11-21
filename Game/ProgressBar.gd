extends Node2D

onready var main_scene = get_tree().current_scene
onready var farmer = get_node("Farmer")
onready var chicken = get_node("Chicken")
onready var bar = get_node("Bar")

func _ready():
	bar.color.b8 = 0

func _process(delta):
	farmer.position.x = (main_scene.farmer_position / main_scene.goal_position) * 100
	chicken.position.x = (main_scene.chicken_position / main_scene.goal_position) * 100
	bar.color.r8 = int(main_scene.difficulty * 32)
	bar.color.g8 = 255 - int(main_scene.difficulty * 32)
