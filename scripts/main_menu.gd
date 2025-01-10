class_name MainMenuUI extends Control

@onready var hightscore_label: Label = $HightscoreLabel

const game_level: PackedScene = preload("res://scenes/game.tscn")

func _ready() -> void:
	if get_tree().paused:
		get_tree().paused = false
		
	hightscore_label.text = "HI-SCORE\n" + str(HighscoreManager.highscore)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_level)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
