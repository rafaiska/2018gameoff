extends Position2D

onready var rock = preload("res://scenes/ObstacleRock.tscn")
var vel = 100

func _ready():
	randomize()

func _on_Timer_timeout():
	var new_rock = rock.instance()
	new_rock.position = self.position
	owner.add_child(new_rock)
	new_rock.set_velocity(vel)