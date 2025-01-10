extends Node

var highscore: int = 0
var current_score: int = 0

func _ready():
	# Load the high score when the game starts
	highscore = load_highscore()

func save_highscore(reset: bool = false) -> void:
	if reset:
		_save_highscore_to_file(0)
		return
		
	if current_score > highscore:
		highscore = current_score
		_save_highscore_to_file(highscore)

func _save_highscore_to_file(score: int) -> void:
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_var(score)
	file.close()

func load_highscore() -> int:
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		var saved_score = file.get_var()
		file.close()
		return saved_score
	return 0
