extends Area2D

@onready var rc_up: RayCast2D = $"../RayCast2D Up"
@onready var rc_left: RayCast2D = $"../RayCast2D Left"

func _on_body_entered(body: Node2D) -> void:
	body.bounce_player( rc_up.is_colliding(), rc_left.is_colliding() )
