extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const RUN_SPEED = 120
const RUN_DECEL = 12

func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = Input.get_axis("left", "right")
	sprite_flip(direction)
	
	if direction:
		# Accel/decel to normal speed.
		velocity.x = move_toward(velocity.x, RUN_SPEED*direction, RUN_DECEL)
		# If we are not moving.
	else:
			# Decelerate to 0.
		velocity.x = move_toward(velocity.x, 0, RUN_DECEL)
	
	move_and_slide()
	
# Function that handles the flipping of the sprite based on direction.
func sprite_flip(direction):
	if direction > 0:
		animated_sprite.flip_h = false # right
	elif direction < 0:
		animated_sprite.flip_h = true
