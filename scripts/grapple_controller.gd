extends Node2D

# The grappling hook needs:
#	Max length
#	A texture
#	Fine tune the hook's law vars.


# Grappling hook will use hook's law.
# These variables represent that.
@export var rest_length = 2.0
@export var stiffness = 30.0
@export var damping = 2.0

@export var max_launch_length = 100.0
@export var max_hold_length = 200.0

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var player: CharacterBody2D = $".."
@onready var rope: Line2D = $Rope

var launched = false
var target: Vector2

func _process(delta):
	
	ray_cast.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple"):
		launch()
		print("In grapple process: launch")
	if Input.is_action_just_released("grapple"):
		retract()
		print("In grapple process: release")
		
	if launched:
		handle_grapple(delta)

func launch():
	rope.show()
	if ray_cast.is_colliding():
		print("ray cast is colliding in launch()")
		launched = true
		target = ray_cast.get_collision_point()
	
func retract():
	launched = false
	rope.hide()

func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	# This restricts the length of the rope.
	if target_dist >= max_launch_length:
		retract()
		return
	
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = spring_force + damping
	
	player.velocity += force * delta
	print("In grap_contr.handle_grapple(): player.vel = ", player.velocity)
	update_rope()

# First point always centered on the player.
# Second point is the target con verted to local coords.
func update_rope():
	rope.set_point_position(1, to_local(target))
