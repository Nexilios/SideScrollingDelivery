class_name GameManager extends Node2D

signal game_over(score: int)

@onready var truck: Truck = $Truck

@export var recipients: Array[Recipient]


func _ready() -> void:
	if recipients.size() > 0 and truck:
		# Randomize Recipient Order
		recipients.shuffle()
		
		set_recipient_id()
		truck.setup_recipients(recipients)
		
		var start_timer: Callable = Callable(func():
			get_tree().create_timer(60).timeout.connect(stop_game)
		)
		
		start_timer.call_deferred()
		

func set_recipient_id() -> void:
	for recipient in recipients:
		recipient.set_id(recipients.find(recipient))

func stop_game() -> void:
	pass
