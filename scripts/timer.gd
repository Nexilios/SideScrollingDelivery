class_name GameTimer extends Control

signal timeout

@onready var timer: Timer = $Timer
@onready var label: Label = $Label


func _process(_delta: float) -> void:
	if not timer.is_stopped() and not timer.paused:
		update_display()

func start_timer(time: float) -> void:
	timer.start(time)
	timer.timeout.connect(func():
		_on_timer_timeout()
		timeout.emit()
	, CONNECT_ONE_SHOT)
	
func update_display() -> void:
	var time: float = timer.time_left
	var seconds: int = int(time)
	var milliseconds: int = int((time - seconds) * 100)  # Get 2 decimal places for milliseconds
	label.text = "%02d:%02d" % [seconds, milliseconds]

func _on_timer_timeout() -> void:
	label.text = "00:00"
