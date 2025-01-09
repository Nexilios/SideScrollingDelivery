class_name HoveringLabel extends Label

@export var animation_player: AnimationPlayer


func _ready() -> void:
	stop_animation()

func stop_animation() -> void:
	hide()
	if animation_player:
		animation_player.stop()

func start_animation() -> void:
	show()
	if animation_player and animation_player.get_animation_list().size() > 0:
		animation_player.play(animation_player.get_animation_list()[0])

func _physics_process(_delta: float) -> void:
	# Prevent label from rotating if parent is a RigidBody
	if get_parent() is RigidBody2D:
		rotation = -get_parent().global_rotation
