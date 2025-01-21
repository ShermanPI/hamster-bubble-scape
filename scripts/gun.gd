extends Node2D

const BULLET = preload("res://scenes/Character/bullet.tscn")
@onready var muzzle: Marker2D = $Marker2D

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("fire"):
		shoot()

func shoot():
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
