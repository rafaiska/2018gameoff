extends Node2D

var controllerIsPresent = false
var controllerInPosition = false
onready var nocontroller_warn = get_node("NoController")
onready var controller = get_node("Controller")
onready var presskey = get_node("PressKey")

func _ready():
	pass

func _set_in_position():
	get_node("Controller/ControllerOK").visible = controllerInPosition
	get_node("Controller/ControllerNOTOK").visible = not controllerInPosition
	presskey.visible = controllerInPosition

func _process(delta):
	controllerIsPresent = len(Input.get_connected_joypads()) > 0
	nocontroller_warn.visible = not controllerIsPresent
	controller.visible = controllerIsPresent
	
	if controllerIsPresent:
		var l_x = Input.get_joy_axis(0, 0)
		var r_x = Input.get_joy_axis(0, 2)
		controllerInPosition = l_x < 0.5 and r_x > 0.5
		_set_in_position()
	else:
		presskey.visible = false
	
	if controllerIsPresent and controllerInPosition and Input.is_key_pressed(KEY_G):
		get_tree().change_scene("res://scenes/MainScene.tscn")
