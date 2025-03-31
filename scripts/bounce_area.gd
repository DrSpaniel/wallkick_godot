extends Area2D

@onready var rc_up_1: RayCast2D = $"RayCast2D Up 1"
@onready var rc_up_2: RayCast2D = $"RayCast2D Up 2"

@onready var rc_left_1: RayCast2D = $"RayCast2D Left 1"
@onready var rc_left_2: RayCast2D = $"RayCast2D Left 2"

@onready var rc_right_1: RayCast2D = $"RayCast2D Right 1"
@onready var rc_right_2: RayCast2D = $"RayCast2D Right 2"

@onready var rc_down_1: RayCast2D = $"RayCast2D Down 1"
@onready var rc_down_2: RayCast2D = $"RayCast2D Down 2"


func _on_body_entered(body: Node2D) -> void:
	# print("Inside on body entered, bounce area. ")
	body.bounce_player( rc_up_1.is_colliding() or rc_up_2.is_colliding(), 
						rc_left_1.is_colliding() or rc_left_2.is_colliding(), 
						rc_right_1.is_colliding() or rc_right_2.is_colliding(), 
						rc_down_1.is_colliding() or rc_down_2.is_colliding() )
