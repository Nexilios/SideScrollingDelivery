class_name GameManager extends Node

signal game_ended(score: int)

# UI
@export var pause_menu: PauseMenu
@export var game_over_menu: GameOverMenu
@export var timer: GameTimer

# Gameplay relevant
@export var truck: Truck
@export var recipients_folder: Node
@export var time_limit: float

var game_is_over: bool = false

var recipients: Array[Recipient]

func _ready() -> void:
	HighscoreManager.reset_state()
	InputManager.reset_state()
	
	if recipients_folder:
		for recp in recipients_folder.get_children():
			recipients.append(recp)
	
		if recipients.size() > 0:
			# Setup truck
			if truck:
				# Randomize Recipient Order
				recipients.shuffle()
				
				set_recipient_id()
				truck.setup_recipients(recipients)
				truck.package_spawned.connect(start_game, CONNECT_ONE_SHOT)
	
	# Setup pause menu ui
	if pause_menu:
		pause_menu.exit_game.connect(stop_game)
	
	# Setup game_over menu ui
	if game_over_menu:
		game_over_menu.exit_game.connect(stop_game)

func start_game() -> void:
	if timer:
		timer.start_timer(time_limit)
		timer.timeout.connect(game_over, CONNECT_ONE_SHOT)

func set_recipient_id() -> void:
	for recipient in recipients:
		recipient.set_id(recipients.find(recipient))

func game_over() -> void:
	HighscoreManager.save_highscore()
	game_is_over = true
	get_tree().paused = true
	
	# Show game over scene
	game_over_menu.show_game_over()

func stop_game(quit: bool) -> void:
	HighscoreManager.save_highscore()
	
	if quit:
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
