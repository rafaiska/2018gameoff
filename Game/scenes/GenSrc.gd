extends Position2D

onready var rock = preload("res://scenes/ObstacleRock.tscn")

func _ready():
	pass

func spawn():
	var new_rock = rock.instance()
	new_rock.position = self.position
	owner.add_child(new_rock)