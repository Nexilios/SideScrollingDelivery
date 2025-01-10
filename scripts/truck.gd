class_name Truck extends PriorityArea2D

signal package_spawned

@export var packages: Array[String]

const package_particle: PackedScene = preload("res://scenes/packages/package_spawn_particle.tscn")
const package_spawn_sound: PackedScene = preload("res://scenes/package_spawn_sound.tscn")

var spawned_package: int

# Keep track of when recipients can receive a package.
var recipients_data: Dictionary


@onready var label: Label = $Label
@onready var spawn_point: Marker2D = $PackageSpawnPoint


func setup_recipients(recipients: Array[Recipient]) -> void:
	randomize()
	recipients_data.clear()
	
	for recipient in recipients:
		recipient.update_truck.connect(package_delivered)
		
		recipients_data[recipient.get_id()] = {
			"ID": recipient.get_id(),
			"Status": true,
			"Location": recipient.get_recipient_position(),
		}
		
func package_delivered(recipient_id: int) -> void:
	recipients_data[recipient_id].Status = true
	spawned_package -= 1

func _spawn_package() -> void:
	for key in recipients_data.keys():
		if not recipients_data[key].Status:
			continue
		
		var recipient_id: int = recipients_data[key].ID
		var package: BasePackage = load(packages.pick_random()).instantiate()
		
		get_tree().current_scene.add_child(package)
		package.set_package_id(recipient_id)
		package.set_recipient_location(recipients_data[key].Location)
		package.global_position = spawn_point.global_position
		
		if package_particle:
			var particle: CPUParticles2D = package_particle.instantiate()
			spawn_point.add_child(particle)
			particle.emitting = true
			particle.finished.connect(particle.queue_free, CONNECT_ONE_SHOT)
		
		spawned_package += 1
		
		# Play sound
		if package_spawn_sound:
			var spawn_sound: AudioStreamPlayer2D = package_spawn_sound.instantiate()
			add_child(spawn_sound)
			
			spawn_sound.finished.connect(
				func():
					spawn_sound.queue_free()
			, CONNECT_ONE_SHOT)
		
		# Set recipient availability to false because they are already expecting a package.
		recipients_data[key].Status = false
		
		package_spawned.emit()

func _on_body_entered(body: Node2D) -> void:
	super(body)
	if body is Player:
		label.start_animation()

func _on_body_exited(body: Node2D) -> void:
	super(body)
	if body is Player:
		label.stop_animation()

func _handle_interaction(_player: Player) -> void:
	if spawned_package < recipients_data.size():
		_spawn_package()
