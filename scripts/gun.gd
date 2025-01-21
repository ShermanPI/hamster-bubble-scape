extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")
@onready var muzzle: Marker2D = $Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	
	if rotation_degrees > 90 and rotation < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	if Input.is_action_pressed("fire"):
		shoot()

func shoot():
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
