extends RigidBody2D


func _ready() -> void:
	gravity_scale = 1

func _on_body_entered(body: Node2D) -> void:
	print("Inside on_body_entered bounce_block.gd")
	print(body)
	
	
# This code goes in player's physics_process func
# Put it after move_and_slide() and it will allow rigid bodies to be pushed

	# I probably don't want to keep this code but I'm not sure.
	# I think I do because the player may need to push stuff buuuut we'll see.
	#for collision_index in get_slide_collision_count():
	#	var collision = get_slide_collision(collision_index)
	#	if collision.get_collider() is RigidBody2D:
	#		print(collision_index , ": ", collision)
	#		collision.get_collider().apply_central_impulse(-collision.get_normal() * PUSH_FORCE)
	
