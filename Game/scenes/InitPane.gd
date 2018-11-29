extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func next():
	if get_node("Background").visible:
		get_node("Background").visible = false
		get_node("Logo").visible = false
		get_node("Label").visible = false
		get_node("controls1").visible = true
	elif get_node("controls1").visible:
		get_node("controls1").visible = false
		get_node("controls2").visible = true
	elif get_node("controls2").visible:
		get_node("controls2").visible = false
		self.visible = false
		global.intro_enabled = false
