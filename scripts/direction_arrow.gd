## Arrow node that points to the delivery location
class_name DeliveryArrow extends Node2D

@onready var arrow_sprite: Sprite2D = $Sprite2D
@export var player: CharacterBody2D

var target_position: Vector2
var is_active: bool = false

func _ready() -> void:
	# Hide arrow initially
	arrow_sprite.hide()
	
func _process(_delta) -> void:
	if !is_active:
		return
	
	# Calculate direction to target
	if target_position:
		var direction = (target_position - player.global_position).normalized()
	
		# Calculate rotation angle
		var angle = direction.angle()
		
		# Set arrow rotation
		arrow_sprite.rotation = angle
	
func activate(delivery_position: Vector2) -> void:
	target_position = delivery_position
	is_active = true
	arrow_sprite.show()
	
func deactivate() -> void:
	is_active = false
	arrow_sprite.hide()
