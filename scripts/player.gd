extends CharacterBody2D


func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
		
	
	# var direction = Input.get_axis("left", "right")
	
	move_and_slide()
