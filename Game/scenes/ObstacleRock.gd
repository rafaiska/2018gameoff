extends Node2D

var angle = 0.0
var speed = 0.0
var starting_y: float
var horizon_y: float
@onready var main_scene = get_tree().current_scene
@onready var rigid_body = get_node("RigidBody2D")
@onready var sprites = {
	'rock': get_node("RigidBody2D/RockSprite"),
	'haystack': get_node("RigidBody2D/HaystackSprite"),
	'stump': get_node("RigidBody2D/StumpSprite")
	}
@onready var shapes = {
	'rock': get_node("RigidBody2D/RockShape"),
	'haystack': get_node("RigidBody2D/HaystackShape"),
	'stump': get_node("RigidBody2D/StumpShape")
	}

func _ready():
	_update_scale()
	starting_y = global_position.y

func _update_velocity(y):
	var y_rate = (y + 170.0) / 170.0
	rigid_body.set_velocity(Vector2(speed * y_rate * cos(angle), speed * y_rate * sin(angle)))

func _update_scale():
	var scale_mul = abs(1.0 - ((main_scene.chicken_y - rigid_body.global_position.y) / (main_scene.chicken_y - starting_y)))
	self.rigid_body.scale = Vector2(scale_mul * 2, scale_mul * 2)

func _process(_delta):
	if horizon_y != null:
		visible = rigid_body.global_position.y >= horizon_y
	if main_scene.chicken_speed != speed:
		speed = main_scene.chicken_speed
	_update_velocity(self.rigid_body.global_position.y)
	rigid_body.move_and_slide()
	if self.rigid_body.global_position.y >= main_scene.chicken_y + 50.0:
		queue_free()
	_update_scale()

func set_type(obstacle_type):
	for shape in shapes:
		if shape == obstacle_type:
			shapes[shape].monitoring = true
			shapes[shape].visible = true
		else:
			shapes[shape].monitoring = false
			shapes[shape].visible = false

	for sprite in sprites:
		if sprite == obstacle_type:
			sprites[sprite].visible = true
		else:
			sprites[sprite].visible = false

func _on_RigidBody2D_body_entered(body):
	if body.name == "ChickenBody":
		main_scene.crash()
	queue_free()
