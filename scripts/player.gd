extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_shooted = false
@onready var game_manager: Node = %GameManager
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Get the input direction: -1 or 0 or 1
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("fire"):
		var player_shots = game_manager.bubble_bottles

		if(player_shots > 0):
			var mouse_position = get_global_mouse_position()
			var direction_vector = (global_position - mouse_position).normalized()
			velocity = direction_vector * SPEED * 1.2
	
	move_and_slide()
