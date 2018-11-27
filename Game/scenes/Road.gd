extends Node2D

const spawn_rate = 1.0

onready var chicken = get_node("Chicken")
onready var gen_src = get_node("ObstacleGen/GenSrc")
onready var main_scene = get_tree().current_scene

var time_since_last_spawn = 0.0
var time_since_last_scen_spawn = 0.0

func _ready():
	chicken.chicken_limit_l = get_node("RoadLLimit").position.x
	chicken.chicken_limit_r = get_node("RoadRLimit").position.x

func _process(delta):
	var speed = main_scene.chicken_speed
	var difficulty = main_scene.difficulty
	time_since_last_spawn += delta
	time_since_last_scen_spawn += delta
	if not main_scene.is_pecking_time and speed > 0.0 and time_since_last_spawn > 200.0 / (speed * difficulty * spawn_rate):
		gen_src.spawn(difficulty)
		time_since_last_spawn = 0.0
	if speed > 0.0 and time_since_last_scen_spawn > 120.0 / (speed * spawn_rate):
		gen_src.spawn_scen()
		time_since_last_scen_spawn = 0.0
	
