extends Node2D

@onready var sprites = {
		'bush': get_node("Bush"),
		'tree': get_node("Tree")
	}
@onready var main_scene = get_tree().current_scene
var angle
var chosen_type
var starting_y: float
var horizon_y: float

func _ready():
	randomize()
	_set_type(sprites.keys()[randi() % len(sprites)])
	starting_y = global_position.y

func _set_type(scitem_type):
	chosen_type = scitem_type
	for sprite in sprites:
		if sprite == scitem_type:
			sprites[sprite].visible = true
		else:
			sprites[sprite].visible = false

func _test_limits():
	if position.y > main_scene.chicken_y + 50.0:
		queue_free()

func _update_scale():
	var scale_mul = abs(1.0 - ((main_scene.chicken_y - global_position.y) / (main_scene.chicken_y - starting_y)))
	self.scale = Vector2(scale_mul * 3, scale_mul * 3)

func _process(delta):
	if horizon_y != null:
		visible = global_position.y >= horizon_y
	_update_scale()
	var speed = main_scene.chicken_speed
	var y_rate = (self.position.y + 170.0) / 170.0
	if y_rate < 0.1:
		y_rate = 0.1
	self.position.x += speed * y_rate * delta * cos(angle)
	self.position.y += speed * y_rate * delta * sin(angle)
	_test_limits()
