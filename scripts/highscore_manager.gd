extends Node

var highscore: int = 0
var current_score: int = 0

func _ready():
	# Load the high score when the game starts
	highscore = load_highscore()

func save_highscore(new_score: int):
	highscore = new_score
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_var(highscore)
	file.close()

func load_highscore() -> int:
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		var saved_score = file.get_var()
		file.close()
		return saved_score
	return 0