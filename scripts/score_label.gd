class_name ScoreLabel extends Control

@onready var label: Label = $Label

func _ready() -> void:
	label.text = "Score: " + str(HighscoreManager.current_score)
	HighscoreManager.score_updated.connect(update_score)

func update_score(score: int) -> void:
	label.text = "Score: " + str(score)
