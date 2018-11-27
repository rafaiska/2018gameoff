extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var minutes = int(global.elapsed_time / 60.0)
	var seconds = int(global.elapsed_time - minutes * 60.0)
	var fracsecs = int(100 * (global.elapsed_time - minutes * 60.0 - seconds))
	get_node("Time").text = '%02d:%02d.%02d' % [minutes, seconds, fracsecs]

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
