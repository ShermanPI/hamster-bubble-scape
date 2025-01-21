extends Node2D

const SPEED = 300
@onready var sprites = [$BUBBLE_2, $BUBBLE_1]

func _ready() -> void:
	set_random_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func set_random_sprite() -> void:
	for sprite in sprites:
		sprite.visible = false  

	var random_index = randi() % sprites.size()
	sprites[random_index].visible = true
