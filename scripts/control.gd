extends Control

var current_frame = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$animation_timer.connect("timeout", self, "update_frame")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_frame():
	if Input.get_current_cursor_shape() != Input.CURSOR_ARROW:
		return
