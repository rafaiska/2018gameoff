extends Position2D

onready var rock = preload("res://scenes/ObstacleRock.tscn")
onready var scen_item = preload("res://scenes/SceneryItem.tscn")
onready var road_limit_l = get_parent().get_parent().get_node("RoadLLimit")
onready var road_limit_r = get_parent().get_parent().get_node("RoadRLimit")
var spawn_angle
const angle_correction = 0.2
var obs_types = ['rock', 'haystack', 'stump']

func _ready():
	var src_to_l = road_limit_l.position - self.position
	var src_to_r = road_limit_r.position - self.position
	var dot_ = src_to_l.dot(src_to_r)
	var cos_angle = dot_ / (src_to_l.length() * src_to_r.length())
	spawn_angle = acos(cos_angle) + angle_correction

func spawn(difficulty):
	var new_rock = rock.instance()
	new_rock.position = self.position
	randomize()
	new_rock.angle = rand_range(0.0, spawn_angle)
	new_rock.angle += (PI / 2.0) - (spawn_angle / 2.0)
	var type_roll = obs_types[int(rand_range(0.0, difficulty - 1.0))]
	owner.add_child(new_rock)
	new_rock.set_type(type_roll)

func spawn_scen():
	var new_scen = scen_item.instance()
	new_scen.position = self.position
	randomize()
	new_scen.angle = rand_range(0.0, PI/6.0)
	if randi() % 2 == 0:
		new_scen.angle = (PI / 2.0) - (spawn_angle / 2.0) - 0.05 - new_scen.angle
	else:
		new_scen.angle = (PI / 2.0) + (spawn_angle / 2.0) + 0.05 + new_scen.angle
	owner.add_child(new_scen)