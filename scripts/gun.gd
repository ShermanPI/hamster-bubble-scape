extends Node2D

const BULLET = preload("res://scenes/Character/bullet.tscn")

@onready var muzzle: Marker2D = $Marker2D

var total_bullets = 12     # Número total de balas a disparar
var spread_angle = 65     # Apertura del tiro en grados (puedes modificarla)
var max_delay = 0.3       # Retraso máximo entre balas (en segundos)
var initial_direction: Vector2 = Vector2.ZERO  # Dirección inicial al disparar
var is_shooting = false   # Bandera para controlar si estamos disparando

func _process(delta: float) -> void:
	var game_manager = get_node(GlobalVariables.levelString)
	
	look_at(get_global_mouse_position())

	# Verifica si se presionó el botón de disparo, si no se está disparando y si hay balas disponibles
	if Input.is_action_just_pressed("fire") and not is_shooting and game_manager.bubble_bottles > 0:
		# Guarda la dirección inicial hacia el mouse
		initial_direction = (get_global_mouse_position() - muzzle.global_position).normalized()
		is_shooting = true
		shoot()
		game_manager.remove_bubble_bottle()

func shoot():
	var game_manager = get_node(GlobalVariables.levelString)
	
	# Verifica nuevamente si hay balas disponibles antes de disparar
	if game_manager.bubble_bottles >= 0:
		# Dispara todas las balas con un pequeño retraso aleatorio
		for i in range(total_bullets):
			# Calcula un retraso aleatorio para cada bala
			var delay = randf_range(0, max_delay)
			# Usamos un temporizador de un solo uso para cada bala
			var timer = Timer.new()
			timer.wait_time = delay
			timer.one_shot = true
			timer.timeout.connect(_shoot_bullet.bind(i))
			add_child(timer)
			timer.start()

func _shoot_bullet(bullet_index: int):
	var bullet = BULLET.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = muzzle.global_position

	# Aplica un ángulo aleatorio dentro del rango de dispersión
	var random_angle = deg_to_rad(randf_range(-spread_angle / 2, spread_angle / 2))  # Ángulo aleatorio en radianes
	var direction = initial_direction.rotated(random_angle)  # Rota la dirección base

	# Pasa la dirección a la bala
	bullet.set_direction(direction)

	# Si es la última bala, resetea la bandera de disparo
	if bullet_index == total_bullets - 1:
		is_shooting = false
