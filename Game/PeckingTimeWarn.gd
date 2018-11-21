extends Node2D

onready var main_scene = get_tree().current_scene
onready var peckingtime_warn = get_node("PeckingTime")
onready var press_warn = get_node("Press")
onready var key_warn = get_node("Key")
const time_to_peck = 8.0
const time_to_warn = 2.0
var elapsed_time = null
const key_map = {
		'A': KEY_A,
		'B': KEY_B,
		'C': KEY_C
	}
var chosen_key = 'A'

func _ready():
	pass

func start():
	randomize()
	elapsed_time = 0.0
	chosen_key = key_map.keys()[randi() % len(key_map)]
	get_node("Key/Label").text = chosen_key

func end():
	elapsed_time = null
	key_warn.visible = false
	press_warn.visible = false
	main_scene.is_pecking_time = false

func _process(delta):
	if elapsed_time != null:
		elapsed_time += delta
		if elapsed_time <= time_to_warn and not peckingtime_warn.visible:
			peckingtime_warn.visible = true
		elif time_to_warn < elapsed_time and elapsed_time <= time_to_peck + time_to_warn and not key_warn.visible:
			peckingtime_warn.visible = false
			key_warn.visible = true
			press_warn.visible = true
		elif elapsed_time > time_to_peck:
			end()