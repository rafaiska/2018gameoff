extends Node2D

var angle
var speed = 0.0
onready var main_scene = get_tree().current_scene
onready var rigid_body = get_node("RigidBody2D")

func _ready():
	randomize()
	angle = rand_range(PI/2.0 -(PI/6.0), PI/2.0 + PI/6.0)

func _update_velocity():
	rigid_body.set_axis_velocity(Vector2(speed * cos(angle), speed * sin(angle)))

func _update_scale():
	var scale_mul = self.rigid_body.position.y
	scale_mul /= 80.0
	self.rigid_body.scale.x *= scale_mul
	self.rigid_body.scale.y *= scale_mul

func _process(delta):
	if main_scene.chicken_speed != speed:
		speed = main_scene.chicken_speed
		_update_velocity()
	if self.rigid_body.position.y >= 340:
		queue_free()
	_update_scale()


func _on_RigidBody2D_body_entered(body):
	main_scene.crash()
	queue_free()
