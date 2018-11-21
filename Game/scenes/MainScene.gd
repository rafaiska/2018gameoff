extends Node2D

const farmer_speed = 70.0  # How much he wants you for dinner
var chicken_speed = 0.0  # Your desire to live
var farmer_position = 0.0
var chicken_position = 300.0  # > 0 for a head start
var boosting = false
var difficulty = 1.0

# Chicken speed constants
const regular_acceleration = 25.0
const boost_acceleration = 50.0
const regular_max_speed = 150.0
const boost_max_speed = 300.0

# Goal
const goal_position = 3000.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func accelerate(accel_rate, delta):
	chicken_speed += accel_rate * delta

func crash():
	chicken_speed = 0.0

func _process(delta):
	if boosting and chicken_speed < boost_max_speed:
		accelerate(boost_acceleration, delta)
	elif not boosting and chicken_speed < regular_max_speed:
		accelerate(regular_acceleration, delta)
	farmer_position += farmer_speed * delta
	chicken_position += chicken_speed * delta
