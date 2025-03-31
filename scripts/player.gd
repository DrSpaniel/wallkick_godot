extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const RUN_SPEED = 120
const RUN_DECEL = 12
const JUMP_SPEED = -290
const BOUNCE_SPEED = JUMP_SPEED * 1.1
const WALL_KICK_SPEED = 400  # Horizontal speed when kicking off a wall
const PUSH_FORCE = 80

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var kickCount = 0 #used to only allow 2 kicks per wall until you touch ground

var just_wallkicked := false  # Add this variable at the top

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		#print("not on floor")
		velocity += get_gravity() * delta
		
		if is_on_wall():
			if Input.is_action_just_pressed("jump"): #when the player is jumping and touching a wall, then jumps again
				#print("beep!")
				
				print(kickCount)
				if kickCount < 9:		#prevents cheating cause im a sore loser
					var collision = get_last_slide_collision()
					if collision:		#if the player hits the wall
						var wall_normal = collision.get_normal()	#negatesthe need to care about whether the player is kicking from left or right.
						velocity.x = wall_normal.x * WALL_KICK_SPEED 
						velocity.y = JUMP_SPEED * 1.1 #makes the kick weaker than an actual jump
						just_wallkicked = true
				kickCount = kickCount+1
				
	else:
		kickCount = 0		#resets kick count
		#print("floor")
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED
	
	var direction = Input.get_axis("left", "right")
	_update_animations(direction)
	sprite_flip(direction)
	
	#if direction == 0:
		#animated_sprite.play("idle")		#if ur not moving, play idle
	#else:		#for when player moves
		#if Input.is_action_just_pressed("jump"):
			#if not is_on_floor():
				#if is_on_wall():
					#if kickCount < 9:
						#animated_sprite.play("wallkick")		#all this bullshit so you only play wallkick when you can wallkick.
				#
			#else:
				#animated_sprite.play("jump")	#when not wallkicking and just jumping.
		##else:
			##animated_sprite.play("walk")
	##

	
			#play anims

	
	if direction:
		# Accel/decel to normal speed.
		velocity.x = move_toward(velocity.x, RUN_SPEED*direction, RUN_DECEL)
		# If we are not moving.
	else:
		# Decelerate to 0.
		velocity.x = move_toward(velocity.x, 0, RUN_DECEL)
	
	move_and_slide()
	
func bounce_player(rc_up, rc_left):
	if rc_up:
		velocity.y = BOUNCE_SPEED
	if rc_left:
		velocity.x = BOUNCE_SPEED

	
# Function that handles the flipping of the sprite based on direction.
func sprite_flip(direction):
	if direction > 0:
		animated_sprite.flip_h = false # right
	elif direction < 0:
		animated_sprite.flip_h = true

func _update_animations(direction: float) -> void:
	# 1. Highest priority: Wallkick (plays once per kick)
	if just_wallkicked:
		animated_sprite.play("wallkick")
		
		just_wallkicked = false  # Reset immediately
		return  # Exit early to prioritize this animation
	else:
			# 2. Jumping or falling
		if not is_on_floor():
			#animated_sprite.play("jump")
			return
			
	# 3. Moving on ground
	if direction != 0:
		# print("boop!")
		animated_sprite.play("walk")
	# 4. Idle
	else:
		animated_sprite.play("idle")
