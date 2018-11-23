extends Position2D

onready var rock = preload("res://scenes/ObstacleRock.tscn")
onready var road_limit_l = get_parent().get_parent().get_node("RoadLLimit")
onready var road_limit_r = get_parent().get_parent().get_node("RoadRLimit")
var spawn_angle
const angle_correction = 0.2

func _ready():
	var src_to_l = road_limit_l.position - self.position
	var src_to_r = road_limit_r.position - self.position
	var dot_ = src_to_l.dot(src_to_r)
	var cos_angle = dot_ / (src_to_l.length() * src_to_r.length())
	spawn_angle = acos(cos_angle) + angle_correction

func spawn():
	var new_rock = rock.instance()
	new_rock.position = self.position
	randomize()
	new_rock.angle = rand_range(0.0, spawn_angle)
	new_rock.angle += (PI / 2.0) - (spawn_angle / 2.0)
	owner.add_child(new_rock)