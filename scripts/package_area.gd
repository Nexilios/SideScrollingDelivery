class_name PackageCollectArea extends PriorityArea2D

@onready var label: HoveringLabel = %Label

const pickup_sound_scene: PackedScene = preload("res://scenes/pickup_sound.tscn")

func _on_body_entered(body: Node2D) -> void:
	super(body)
	if body is Player:
		if label:
			label.start_animation()

func _on_body_exited(body: Node2D) -> void:
	super(body)
	if body is Player:
		if label:
			label.stop_animation()

func _handle_interaction(player: Player) -> void:
	if not player.package_held.is_empty():
		return
		
	if pickup_sound_scene:
		var pickup_sound: AudioStreamPlayer2D = pickup_sound_scene.instantiate()
		get_tree().root.add_child(pickup_sound)
		pickup_sound.finished.connect(
			func(): pickup_sound.queue_free()
		, CONNECT_ONE_SHOT)
	
	var package_data: Dictionary = {
		"ID" = get_parent().get_package_id(),
		"Score" = get_parent().package_score,
		"Destination" = get_parent().get_recipient_location(),
	}
	
	player.package_collected(package_data)
	
	get_parent().queue_free.call_deferred()
