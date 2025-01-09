class_name GameManager extends Node

signal game_over(score: int)

@export var truck: Truck
@export var recipients: Array[Recipient]


func _ready() -> void:
	if recipients.size() > 0 and truck:
		# Randomize Recipient Order
		recipients.shuffle()
		
		set_recipient_id()
		truck.setup_recipients(recipients)
		
	if truck:
		truck.package_spawned.connect(start_game, CONNECT_ONE_SHOT)

func start_game() -> void:
	get_tree().create_timer(60).timeout.connect(stop_game)

func set_recipient_id() -> void:
	for recipient in recipients:
		recipient.set_id(recipients.find(recipient))

func stop_game() -> void:
	pass
