class_name BasePackage extends RigidBody2D

@onready var label: HoveringLabel = $Label
@onready var collect_area: Area2D = $CollectArea

@export var package_score: float = 50.0


var _package_id: int:
	set = set_package_id
	
func handle_interaction() -> void:
	pass

func set_package_id(id: int) -> void:
	if id >= 0:
		_package_id = id

func get_package_id() -> int:
	return _package_id

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InputManager.register_area(collect_area)
		if label:
			label.start_animation()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		InputManager.unregister_area(collect_area)
		if label:
			label.stop_animation()

func _handle_interaction() -> void:
	pass # Replace with function body.
