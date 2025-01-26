extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_shooted = false
@onready var game_manager: Node = %GameManager


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("fire"):
		var player_shots = game_manager.bubble_bottles
		game_manager.remove_bubble_bottle()
		if(player_shots > 0):
			var mouse_position = get_global_mouse_position()
			var direction_vector = (global_position - mouse_position).normalized()
			velocity = direction_vector * SPEED * 2
	
	move_and_slide()
