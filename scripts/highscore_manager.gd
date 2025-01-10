extends Node

signal score_updated(score: int)

var highscore: int = 0
var current_score: int = 0

func update_score(val: int) -> void:
	current_score += val
	
	# Update UI
	score_updated.emit(current_score)

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
	
func reset_state() -> void:
	current_score = 0
	highscore = load_highscore()
