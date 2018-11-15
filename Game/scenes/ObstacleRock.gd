extends Node2D

var angle
const intensity = 300
onready var rigid_body = get_node("RigidBody2D")

func _ready():
	randomize()
	angle = rand_range(PI/2.0 -(PI/6.0), PI/2.0 + PI/6.0)
	rigid_body.apply_impulse(Vector2(0,0), Vector2(intensity*cos(angle), intensity*sin(angle)))

func _process(delta):
	if self.rigid_body.position.y >= 340:
		queue_free()
	var scale_mul = self.rigid_body.position.y + 70.0
	scale_mul /= 100.0
	self.rigid_body.scale.x *= scale_mul
	self.rigid_body.scale.y *= scale_mul