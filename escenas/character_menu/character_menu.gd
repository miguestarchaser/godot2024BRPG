extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_data(data) -> void:
	var texture:Texture2D 	= load("res://assets/sprites/characters/"+data.portrait);
	#print(texture)
	$Sprite2D.set_texture(texture);
	$Sprite2D.scale = Vector2(0.09,0.09)
	$Label_name.text = data.name
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
