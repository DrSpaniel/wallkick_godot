extends CollisionShape2D

@onready var game_manager: Node = %"Game Manager"

func _on_lower_bound_body_entered(_body: Node2D) -> void:
	game_manager.reset_game()
