extends Panel  # O el nodo raíz que estés usando

# Referencia al AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D

# Variable para almacenar la animación actual
var current_animation: String = ""

# Función para cambiar la animación
func set_animation(animation_name: String):
	if animated_sprite and animated_sprite.sprite_frames:
		# Verifica si la animación ya está activa
		if current_animation != animation_name:
			if animated_sprite.sprite_frames.has_animation(animation_name):  # Verifica si la animación existe
				animated_sprite.play(animation_name)  # Cambia la animación
				current_animation = animation_name  # Actualiza la animación actual
			else:
				print("Error: La animación '", animation_name, "' no existe.")
	else:
		print("Error: AnimatedSprite2D no está configurado correctamente.")

# Función para establecer el fotograma actual
func set_frame(frame: int):
	if animated_sprite:
		animated_sprite.frame = frame  # Establece el fotograma actual
