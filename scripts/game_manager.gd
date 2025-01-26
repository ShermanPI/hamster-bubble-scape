extends Node

@onready var player_bottles: Label = $PlayerBottles
@onready var bubble_bottles = 3

@onready var bottles_container: HBoxContainer = $CanvasLayer/BottlesContainer/HBoxContainer

func _ready() -> void:
	bottles_container.setBottles(bubble_bottles)
	

func add_bubble_bottle():
	if bubble_bottles < 3:
		bubble_bottles += 1
		bottles_container.setBottles(bubble_bottles)

func remove_bubble_bottle():
	if bubble_bottles > 0:
		bubble_bottles -= 1
		bottles_container.setBottles(bubble_bottles)
