extends Node2D

const BULLET = preload("res://scenes/Character/bullet.tscn")
@onready var muzzle: Marker2D = $Marker2D
@onready var game_manager = get_node("/root/Level1/GameManager")

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("fire"):
		shoot()
	
	if Input.is_action_just_pressed("fire"):
		game_manager.remove_bubble_bottle()

func shoot():
	
	if(game_manager.bubble_bottles > 0):
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = rotation
