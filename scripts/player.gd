extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const RUN_SPEED = 120
const RUN_DECEL = 12

const JUMP_VELOCITY = -290

const WALL_KICK_SPEED = 200  # Horizontal speed when kicking off a wall

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var kickCount = 0 #used to only allow 2 kicks per wall until you touch ground

func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if is_on_wall():
			if Input.is_action_just_pressed("ui_accept"): #when the player is jumping and touching a wall, then jumps again
				print("beep!")
				
				print(kickCount)
				if kickCount < 2:		#prevents cheating cause im a sore loser
					var collision = get_last_slide_collision()
					if collision:		#if the player hits the wall
						var wall_normal = collision.get_normal()	#negates the need to care about whether the player is kicking from left or right.
						velocity.x = wall_normal.x * WALL_KICK_SPEED
						velocity.y = JUMP_VELOCITY * 0.8  #makes the kick weaker than an actual jump
				kickCount = kickCount+1
				
	if is_on_floor():
		kickCount = 0
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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
