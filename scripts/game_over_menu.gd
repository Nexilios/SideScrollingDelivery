class_name GameOverMenu extends Control

@onready var header: Label = $Header
@onready var highscore: Label = $Highscore


func _ready() -> void:
	hide()

func show_game_over() -> void:
	highscore.text = "HI-SCORE: " + str(HighscoreManager.highscore) 
	show()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	# Move to main menu
	pass
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()
