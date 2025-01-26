extends Node

var bubble_bottles = 3

@onready var player_bottles: Label = $PlayerBottles

func _ready() -> void:
	player_bottles.text = "Botellas: " + str(bubble_bottles)

func add_bubble_bottle():
	if bubble_bottles < 3:
		bubble_bottles += 1
		player_bottles.text = "Botellas: " + str(bubble_bottles)
		print("Botella agregada. Total:", bubble_bottles)
	else:
		print("No se puede recoger más botellas. Límite alcanzado.")

func remove_bubble_bottle():
	if bubble_bottles > 0:
		bubble_bottles -= 1
		player_bottles.text = "Botellas: " + str(bubble_bottles)
		print("Botella removida. Total:", bubble_bottles)
	else:
		print("No hay botellas para remover.")
