extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const FLOOR_DETECTION_DISTANCE = 10.0  # Distance to detect if almost touching the floor

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_shooted = false

@onready var game_manager: Node = %GameManager
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_ray_cast: RayCast2D = $FloorRayCast  # Add a RayCast2D node pointing downward

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, or 1
	var direction := Input.get_axis("ui_left", "ui_right")

	# Flip the sprite based on direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y > 0:
			animated_sprite.play("jumping")  # Rising (jumping up)
		else:
			animated_sprite.play("falling")  # Falling or almost touching the floor

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle shooting
	if Input.is_action_just_pressed("fire"):
		var player_shots = game_manager.bubble_bottles

		if (player_shots > 0  and !is_on_floor()):
			var mouse_position = get_global_mouse_position()
			var direction_vector = (global_position - mouse_position).normalized()
			velocity = direction_vector * SPEED * 5

	move_and_slide()
