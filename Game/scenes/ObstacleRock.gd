extends Node2D

var angle
onready var static_body = get_node("StaticBody2D")

func _ready():
	randomize()
	angle = rand_range(PI/2.0 -(PI/6.0), PI/2.0 + PI/6.0)
	set_velocity(1000)

func set_velocity(vel):
	static_body.constant_linear_velocity = Vector2(vel * cos(angle), vel * sin(angle))

func _update_scale():
	var scale_mul = self.static_body.position.y
	scale_mul /= 80.0
	self.static_body.scale.x *= scale_mul
	self.static_body.scale.y *= scale_mul

func _process(delta):
	if self.static_body.position.y >= 340:
		queue_free()
	#_update_scale()