extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_Y:
			_on_TextureButton_pressed()
		elif event.scancode == KEY_N:
			_on_TextureButton2_pressed()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/MainScene.tscn")

func _on_TextureButton2_pressed():
	get_tree().quit()
