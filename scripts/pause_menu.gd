class_name PauseMenu extends Control

signal exit_game(state: bool)

@export var game_manager: GameManager

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if game_manager and not game_manager.game_is_over:
			if get_tree().paused:
				resume_game()
			else:
				pause_game()

func pause_game() -> void:
	get_tree().paused = true
	show()
	
func resume_game() -> void:
	get_tree().paused = false
	hide()
	
func back_to_menu() -> void:
	exit_game.emit(false)

func quit_game() -> void:
	exit_game.emit(true)
