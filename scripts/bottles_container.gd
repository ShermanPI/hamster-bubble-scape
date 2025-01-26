extends HBoxContainer

# Precargar la escena de la botella
@onready var BOTTLE_GUI = preload("res://scenes/UI/bottle_gui.tscn")

# Variables para controlar la sincronización
var current_frame: int = 0
var animation_speed: float = 10.0  # Fotogramas por segundo (FPS)
var time_since_last_frame: float = 0.0

func _process(delta: float):
	# Acumula el tiempo transcurrido
	time_since_last_frame += delta

	# Calcula el tiempo que debe pasar entre fotogramas
	var frame_duration = 1.0 / animation_speed

	# Si ha pasado suficiente tiempo, avanza al siguiente fotograma
	if time_since_last_frame >= frame_duration:
		time_since_last_frame -= frame_duration  # Reinicia el contador
		current_frame = (current_frame + 1) % get_max_frames()  # Avanza al siguiente fotograma
		sync_animations(current_frame)  # Sincroniza las animaciones

# Función para obtener el número máximo de fotogramas
func get_max_frames() -> int:
	var max_frames = 0
	for bottle in get_children():
		if bottle.has_method("set_frame") and bottle.current_animation:
			var frames = bottle.animated_sprite.sprite_frames.get_frame_count(bottle.current_animation)
			if frames > max_frames:
				max_frames = frames
	return max_frames

# Función para sincronizar las animaciones
func sync_animations(frame: int):
	for bottle in get_children():
		if bottle.has_method("set_frame"):
			bottle.set_frame(frame)  # Establece el fotograma actual en cada botella

func setBottles(max: int):
	var current_children = get_children()  # Obtener todas las botellas actuales
	var current_count = current_children.size()

	if max < current_count:
		# Cambiar la animación de las botellas sobrantes a "empty"
		for i in range(max, current_count):
			var bottle = current_children[i]
			if bottle.has_method("set_animation"):
				bottle.set_animation("empty")  # Cambiar la animación a "empty"
			else:
				print("Error: La función 'set_animation' no está definida en la botella.")
	elif max > current_count:
		# Agregar nuevas botellas si es necesario
		for i in range(current_count, max):
			var bottle = BOTTLE_GUI.instantiate()
			add_child(bottle)
			if bottle.has_method("set_animation"):
				bottle.set_animation("full")  # Asegurarse de que la nueva botella esté en estado "full"
			else:
				print("Error: La función 'set_animation' no está definida en la botella.")
	else:
		# No hacer nada si max es igual al número actual de botellas
		pass

	# Asegurarse de que las botellas visibles sean exactamente max
	for i in range(min(max, current_count)):
		current_children[i].visible = true
		if current_children[i].has_method("set_animation"):
			current_children[i].set_animation("full")  # Cambiar la animación a "full"
		else:
			print("Error: La función 'set_animation' no está definida en la botella.")
