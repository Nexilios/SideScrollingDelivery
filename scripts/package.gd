class_name BasePackage extends RigidBody2D

@export var package_score: float = 50.0

var _recipient_location: Vector2:
	set = set_recipient_location,
	get = get_recipient_location

var _package_id: int:
	set = set_package_id,
	get = get_package_id
	
	
func set_recipient_location(loc: Vector2) -> void:
	_recipient_location = loc
	
func get_recipient_location() -> Vector2:
	return _recipient_location

func set_package_id(id: int) -> void:
	if id >= 0:
		_package_id = id

func get_package_id() -> int:
	return _package_id
