class_name GameManager extends Node

signal game_ended(score: int)

# UI
@export var pause_menu: PauseMenu
@export var game_over_menu: Control

# Gameplay relevant
@export var truck: Truck
@export var recipients_folder: Node

var recipients: Array[Recipient]
var _timer: SceneTreeTimer

func _ready() -> void:
	if recipients_folder:
		for recp in recipients_folder.get_children():
			recipients.append(recp)
	
		if recipients.size() > 0 and truck:
			# Randomize Recipient Order
			recipients.shuffle()
			
			set_recipient_id()
			truck.setup_recipients(recipients)
		
	if truck:
		truck.package_spawned.connect(start_game, CONNECT_ONE_SHOT)
	
	if pause_menu:
		pause_menu.exit_game.connect(stop_game)

func start_game() -> void:
	_timer = get_tree().create_timer(60)
	_timer.timeout.connect(game_over)

func set_recipient_id() -> void:
	for recipient in recipients:
		recipient.set_id(recipients.find(recipient))

func game_over() -> void:
	HighscoreManager.save_highscore()
	_timer = null
	
	# Show game over scene
	

func stop_game(quit: bool) -> void:
	HighscoreManager.save_highscore()
	
	if quit:
		get_tree().quit()
	else:
		# Back to main menu
		pass
