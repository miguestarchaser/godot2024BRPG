extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		print("check button activo")
	else:
		print("check button morido")
	
	pass # Replace with function body.


func _on_check_box_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		print("check  activo")
	else:
		print("check  morido")
	pass # Replace with function body.
