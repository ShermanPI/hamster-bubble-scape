extends Node2D

const SPEED = 150  # Velocidad de la burbuja
const FLOAT_SPEED = 50  # Velocidad de flotación hacia arriba
const FLOAT_DISTANCE = 100  # Distancia desde el borde de la pantalla para comenzar a flotar
const MIN_LIFETIME = 0.3  # Tiempo mínimo de vida de la burbuja (en segundos)
const MAX_LIFETIME = 0.8  # Tiempo máximo de vida de la burbuja (en segundos)
const FADE_DURATION = 0.2  # Duración del desvanecimiento (en segundos)
const MIN_EXPLOSION_SCALE = 1  # Escala mínima durante la "explosión"
const MAX_EXPLOSION_SCALE = 2.0  # Escala máxima durante la "explosión"

@onready var sprites = [$BUBBLE_1, $BUBBLE_2, $BUBBLE_3]
@onready var screen_size = get_viewport_rect().size  # Tamaño de la pantalla

# Variable para almacenar la dirección de movimiento de la burbuja
var direction: Vector2 = Vector2.RIGHT
var is_fading = false  # Indica si la burbuja está desvaneciéndose
var fade_timer = 0.0  # Temporizador para el desvanecimiento
var explosion_scale = 1.0  # Escala máxima de la explosión (aleatoria)

func _ready() -> void:
	set_random_sprite()
	_start_lifetime_timer()
	# Asigna una escala máxima aleatoria para la explosión
	explosion_scale = randf_range(MIN_EXPLOSION_SCALE, MAX_EXPLOSION_SCALE)

# Función para establecer la dirección de la burbuja
func set_direction(new_direction: Vector2):
	direction = new_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Movimiento normal de la burbuja en la dirección fija
	position += direction * SPEED * delta

	# Verifica si la burbuja está cerca del borde de la pantalla
	if _is_near_screen_edge():
		# Aplica un movimiento adicional hacia arriba (flotación)
		position.y -= FLOAT_SPEED * delta

	# Si la burbuja está desvaneciéndose, actualiza el desvanecimiento y la escala
	if is_fading:
		fade_timer += delta
		# Calcula el progreso del desvanecimiento (0 a 1)
		var progress = fade_timer / FADE_DURATION

		# Aplica el desvanecimiento (transparencia)
		var alpha = 1.0 - progress
		for sprite in sprites:
			if sprite.visible:
				sprite.modulate.a = alpha

		# Aplica el aumento de escala (explosión)
		var scale_value = 1.0 + (explosion_scale - 1.0) * progress
		scale = Vector2(scale_value, scale_value)

		# Si el desvanecimiento ha terminado, elimina la burbuja
		if fade_timer >= FADE_DURATION:
			queue_free()

# Función para verificar si la burbuja está cerca del borde de la pantalla
func _is_near_screen_edge() -> bool:
	# Calcula la distancia a los bordes de la pantalla
	var distance_to_top = global_position.y
	var distance_to_bottom = screen_size.y - global_position.y
	var distance_to_left = global_position.x
	var distance_to_right = screen_size.x - global_position.x

	# Comienza a flotar si está cerca de cualquier borde
	return (
		distance_to_top < FLOAT_DISTANCE or
		distance_to_bottom < FLOAT_DISTANCE or
		distance_to_left < FLOAT_DISTANCE or
		distance_to_right < FLOAT_DISTANCE
	)

# Función para iniciar el temporizador de vida de la burbuja
func _start_lifetime_timer():
	var timer = Timer.new()
	timer.wait_time = randf_range(MIN_LIFETIME, MAX_LIFETIME)  # Tiempo de vida aleatorio
	timer.one_shot = true
	timer.timeout.connect(_on_lifetime_end)
	add_child(timer)
	timer.start()

# Función que se llama cuando el temporizador de vida termina
func _on_lifetime_end():
	# Inicia el desvanecimiento y la explosión
	is_fading = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func set_random_sprite() -> void:
	for sprite in sprites:
		sprite.visible = false  

	var random_index = randi() % sprites.size()
	sprites[random_index].visible = true
