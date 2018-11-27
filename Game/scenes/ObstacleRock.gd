extends Node2D

var angle = 0.0
var speed = 0.0
onready var main_scene = get_tree().current_scene
onready var rigid_body = get_node("RigidBody2D")
onready var sprites = {
	'rock': get_node("RigidBody2D/RockSprite"),
	'haystack': get_node("RigidBody2D/HaystackSprite"),
	'stump': get_node("RigidBody2D/StumpSprite")
	}
onready var shapes = {
	'rock': get_node("RigidBody2D/RockShape"),
	'haystack': get_node("RigidBody2D/HaystackShape"),
	'stump': get_node("RigidBody2D/StumpShape")
	}

func _ready():
	_update_scale()

func _update_velocity(y):
	var y_rate = (y + 170.0) / 170.0
	rigid_body.set_axis_velocity(Vector2(speed * y_rate * cos(angle), speed * y_rate * sin(angle)))

func _update_scale():
	var scale_mul = self.rigid_body.position.y - 50
	scale_mul /= 80.0
	if scale_mul < 0.0:
		scale_mul = 0.0
	self.rigid_body.scale.x *= scale_mul
	self.rigid_body.scale.y *= scale_mul

func _process(delta):
	if main_scene.chicken_speed != speed:
		speed = main_scene.chicken_speed
	_update_velocity(self.rigid_body.position.y)
	if self.rigid_body.position.y >= 340:
		queue_free()
	_update_scale()

func set_type(obstacle_type):
	for shape in shapes:
		if shape == obstacle_type:
			shapes[shape].disabled = false
		else:
			shapes[shape].disabled = true

	for sprite in sprites:
		if sprite == obstacle_type:
			sprites[sprite].visible = true
		else:
			sprites[sprite].visible = false

func _on_RigidBody2D_body_entered(body):
	if body.name == "ChickenBody":
		main_scene.crash()
	queue_free()
