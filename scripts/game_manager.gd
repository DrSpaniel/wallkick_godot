extends Node

func reset_game():
	
	# Normally, we'd use: get_tree().reload_current_scene()
	# However, we are in the middle of a physics frame.
	# There is an error in this case.
	# When we use call_deferred() here, we tell the game to wait until the end of the frame to call this function.
	get_tree().call_deferred("reload_current_scene")
