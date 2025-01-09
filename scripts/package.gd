class_name BasePackage extends RigidBody2D

@export var package_score: float = 50.0
@onready var label: HoveringLabel = $Label

var _package_id: int:
	set = set_package_id

func set_package_id(id: int) -> void:
	if id >= 0:
		_package_id = id

func get_package_id() -> int:
	return _package_id

func _on_body_entered(body: Node2D) -> void:
	if body is Player and label:
		label.start_animation()

func _on_body_exited(body: Node2D) -> void:
	if body is Player and label:
		label.stop_animation()
