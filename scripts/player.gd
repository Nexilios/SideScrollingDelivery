class_name Player extends CharacterBody2D

# Jump configuration
@export var cell_size: int = 18 # World's cell size in pixels
@export var jump_height: float = 3.0  # Desired jump height in cells (multiply by cell_size)
@export var jump_time_to_peak: float = 0.4  # Time to reach peak of jump
@export var jump_time_to_descent: float = 0.28 # Time to fall from peak

# Movement configuration
@export var speed: float = 125.0
@export var push_force: float = 30.0

# Automatically calculated physics variables
var jump_velocity: float
var jump_gravity: float
var fall_gravity: float

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	# Calculate initial jump velocity needed to reach desired height
	jump_velocity = (-2.0 * jump_height * cell_size) / jump_time_to_peak
	
	# Calculate gravity for upward movement
	jump_gravity = (2.0 * jump_height * cell_size) / pow(jump_time_to_peak, 2)
	
	# Calculate gravity for falling
	fall_gravity = (2.0 * jump_height * cell_size) / pow(jump_time_to_descent, 2)

func _physics_process(delta: float) -> void:
	# Apply appropriate gravity based on vertical movement
	if not is_on_floor():
		var gravity = jump_gravity if velocity.y < 0.0 else fall_gravity
		velocity.y += gravity * delta
	
	# Handle jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Cut the jump short if button is released (for variable jump height)
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= 0.5
	
	# Handle horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	
	# Handle animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("jump")
	
	# Handle sprite direction
	if direction > 0:
		animated_sprite.flip_h = true
	elif direction < 0:
		animated_sprite.flip_h = false
	
	# Apply horizontal movement
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	# Apply impulse if colliding with RigidBody
	for i in get_slide_collision_count():
		if get_slide_collision_count() > 1:
			print(get_slide_collision(i))
		var c: KinematicCollision2D = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
