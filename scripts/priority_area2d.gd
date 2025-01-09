## Class to handle input priority conflict.
## Used in conjunction with InputManager.
class_name PriorityArea2D extends Area2D

## Will emit this signal when there's interaction input.
signal handle_interaction

## Lower number = higher priority
@export var input_priority = 0
