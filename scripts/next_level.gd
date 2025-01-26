extends Area2D

func _on_body_entered(body: Node2D) -> void:
	GlobalVariables.level += 1  # Incrementa el nivel
	print("next_level" + str(GlobalVariables.level))
	var next_level_path = "res://scenes/levels/level_" + str(GlobalVariables.level) + ".tscn"
	if ResourceLoader.exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)  # Cambia a la siguiente escena
	else:
		print("¡No hay más niveles!")  # Mensaje si no hay más niveles
