class_name Truck extends Area2D

@export var packages: Array[String]

var recipients_data: Dictionary
var on_delivery: bool = false

@onready var label: Label = $Label
@onready var spawn_point: Marker2D = $PackageSpawnPoint


func _ready() -> void:
	InputManager.register_area(self)
	
func _exit_tree() -> void:
	InputManager.unregister_area(self)

func setup_recipients(recipients: Array[Recipient]) -> void:
	randomize()
	recipients_data.clear()
	
	for recipient in recipients:
		recipients_data[recipient.get_id()] = {
			"Status": false
		}

func give_random_recp_id() -> int:
	var available: Array = []
	for key in recipients_data.keys():
		# Check if recipient is available
		if recipients_data[key]:
			available.insert(key, key)
			
	if available.is_empty():
		return -1
	
	return available.pick_random()

func package_delivered() -> void:
	on_delivery = false

func handle_interaction() -> void:
	_spawn_package()

func _spawn_package() -> void:
	on_delivery = true
	var recipient_id: int = give_random_recp_id()
	var package: BasePackage = load(packages.pick_random()).instantiate()
	get_tree().root.add_child(package)
	package.set_package_id(recipient_id)
	package.global_position = spawn_point.global_position
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		label.start_animation()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		label.stop_animation()
