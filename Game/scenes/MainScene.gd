extends Node2D

const farmer_speed = 160.0  # How much he wants you for dinner
var chicken_speed = 0.0  # Your desire to live
var farmer_position = 0.0
var chicken_position = 800.0  # > 0 for a head start
var boosting = false
var difficulty = 1.0

var is_pecking_time = false
var pecking_time_check = {1: false, 2: false, 3:false, 4:false}
onready var pecking_time_warn = get_node("PeckingTimeWarn")
onready var chicken = get_node("Road/Chicken")

# Chicken speed constants
const regular_acceleration = 25.0
const regular_deacceleration = -25.0
const boost_acceleration = 50.0
const regular_max_speed = 150.0
const boost_max_speed = 300.0

# Goal
const goal_position = 20000.0

func _ready():
	global.reset_time()

func _reset():
	global.reset_time()
	chicken_speed = 0.0  # Your desire to live
	farmer_position = 0.0
	chicken_position = 800.0  # > 0 for a head start
	boosting = false
	difficulty = 1.0
	is_pecking_time = false
	pecking_time_check = {1: false, 2: false, 3:false, 4:false}

func accelerate(accel_rate, delta):
	chicken_speed += accel_rate * delta

func crash():
	get_node("CrashSFX").play()
	chicken.start_crashing(chicken_speed)
	chicken_speed = 0.0
	if boosting:
		boosting = false

func boost():
	get_node("BoostSFX").play()
	chicken.peck()
	boosting = true

func _start_pecking_time():
	get_node("PeckingTimeSFX").play()
	is_pecking_time = true
	pecking_time_warn.start()

func _check_pecking_time():
	if difficulty >= 1.5 and not pecking_time_check[1]:
		_start_pecking_time()
		pecking_time_check[1] = true
	elif difficulty >= 2.0 and not pecking_time_check[2]:
		_start_pecking_time()
		pecking_time_check[2] = true
	elif difficulty >= 2.5 and not pecking_time_check[3]:
		_start_pecking_time()
		pecking_time_check[3] = true
	elif difficulty >= 3.0 and not pecking_time_check[4]:
		_start_pecking_time()
		pecking_time_check[4] = true

func _game_over():
	get_tree().change_scene("res://scenes/GameOver.tscn")

func _victory():
	get_tree().change_scene("res://scenes/Victory.tscn")

func _process(delta):
	global.elapsed_time += delta
	if farmer_position >= chicken_position:
		_game_over()
	elif chicken_position >= goal_position:
		_victory()
	_check_pecking_time()
	if boosting and chicken_speed < boost_max_speed:
		accelerate(boost_acceleration, delta)
	elif not boosting:
		if chicken_speed < regular_max_speed:
			accelerate(regular_acceleration, delta)
		elif chicken_speed > regular_max_speed:
			accelerate(regular_deacceleration, delta)
	farmer_position += farmer_speed * delta
	chicken_position += chicken_speed * delta
	difficulty = 1.0 + (chicken_position / goal_position) * 3.0
