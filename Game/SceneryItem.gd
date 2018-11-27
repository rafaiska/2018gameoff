extends Node2D

onready var sprites = {
		'bush': get_node("Bush"),
		'tree': get_node("Tree")
	}
onready var main_scene = get_tree().current_scene
var angle
var chosen_type

func _ready():
	randomize()
	_set_type(sprites.keys()[randi() % len(sprites)])

func _set_type(scitem_type):
	chosen_type = scitem_type
	for sprite in sprites:
		if sprite == scitem_type:
			sprites[sprite].visible = true
		else:
			sprites[sprite].visible = false

func _test_limits():
	if position.x < -200 or position.x > 200 or position.y >= 340:
		queue_free()

func _update_scale():
	var new_scale = (self.position.y + 55.0)/80.0
	if new_scale < 0.0:
		new_scale = 0.0
	self.scale.x = new_scale
	self.scale.y = new_scale

func _process(delta):
	_update_scale()
	var speed = main_scene.chicken_speed
	var y_rate = (self.position.y + 170.0) / 170.0
	if y_rate < 0.1:
		y_rate = 0.1
	self.position.x += speed * y_rate * delta * cos(angle)
	self.position.y += speed * y_rate * delta * sin(angle)
	_test_limits()
