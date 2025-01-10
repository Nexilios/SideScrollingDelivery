## Class to handle input priority conflict.
## Used in conjunction with InputManager.
class_name PriorityArea2D extends Area2D

## Will emit this signal when there's interaction input.
signal handle_interaction(player: Player)

## Lower number = higher priority
@export var input_priority = 0


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InputManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		InputManager.unregister_area(self)
