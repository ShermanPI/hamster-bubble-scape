extends HBoxContainer
@onready var BOTTLE_GUI = preload("res://scenes/UI/bottle_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setBottles(max: int):
	var current_children = get_children()  # Obtener todas las botellas actuales
	var current_count = current_children.size()

	if max < current_count:
		# Ocultar o desactivar las botellas sobrantes
		for i in range(max, current_count):
			current_children[i].visible = false  # O usar current_children[i].queue_free() si no las necesitas
	elif max > current_count:
		# Agregar nuevas botellas si es necesario
		for i in range(current_count, max):
			var bottle = BOTTLE_GUI.instantiate()
			add_child(bottle)
	else:
		# No hacer nada si max es igual al número actual de botellas
		pass

	# Asegurarse de que las botellas visibles sean exactamente max
	for i in range(min(max, current_count)):
		current_children[i].visible = true
