extends Node2D

var controllerIsPresent = false
var controllerInPosition = false
var controllerLROK = false
onready var nocontroller_warn = get_node("NoController")
onready var controller = get_node("Controller")
onready var presskey = get_node("PressKey")

func _ready():
	set_process_input(global.intro_enabled)
	get_node("InitPane").visible = global.intro_enabled

func _check_sticks():
	var l_x = Input.get_joy_axis(0, 0)
	var r_x = Input.get_joy_axis(0, 2)
	controllerInPosition = l_x < -0.6 and r_x > 0.6
	get_node("Controller/ControllerOK").visible = controllerLROK and controllerInPosition
	get_node("Controller/ControllerNOTOK").visible = not get_node("Controller/ControllerOK").visible
	presskey.visible = get_node("Controller/ControllerOK").visible

func _check_LR():
	if Input.is_action_pressed('controller_L') and Input.is_action_pressed('controller_R'):
		controllerLROK = true
	else:
		controllerLROK = false

func _process(delta):
	if not global.intro_enabled:
		controllerIsPresent = len(Input.get_connected_joypads()) > 0
		nocontroller_warn.visible = not controllerIsPresent
		controller.visible = controllerIsPresent
		
		if controllerIsPresent:
			_check_LR()
			_check_sticks()
		else:
			presskey.visible = false
		
		if controllerIsPresent and controllerInPosition and controllerLROK and Input.is_key_pressed(KEY_G):
			get_tree().change_scene("res://scenes/MainScene.tscn")

func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		if event.is_pressed():
			get_node("InitPane").next()
