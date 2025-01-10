class_name Recipient extends PriorityArea2D

signal update_truck(recipient_id: int)

@onready var label: HoveringLabel = $HoveringLabel
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var recipient_location: Vector2

func get_recipient_position() -> Vector2:
	return %PositionMarker.global_position

var _id: int: 
	set = set_id

func set_id(id: int) -> void:
	if id >= 0:
		_id = id

func get_id() -> int:
	return _id
	
func _player_have_correct_package(player: Player) -> bool:
	if player.package_held.is_empty():
		return false
		
	return player.package_held.ID == get_id()
	
func _on_body_entered(body: Node2D) -> void:
	super(body)
	if body is Player and _player_have_correct_package(body):
		label.start_animation()
	
func _on_body_exited(body: Node2D) -> void:
	super(body)
	if body is Player:
		label.stop_animation()

func _on_handle_interaction(player: Player) -> void:
	if _player_have_correct_package(player):
		# Hide interaction label
		label.stop_animation()
		
		# Update truck to be able to spawn 1 more package to this recipient
		update_truck.emit(get_id())
		
		# Update Score
		HighscoreManager.update_score(player.package_held.Score)
		
		# Clear player package_held so player able to pick up another package
		player.package_delivered()
		
		# Play sound
		audio.play()
