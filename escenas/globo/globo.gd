extends Node2D
var _tween:Tween;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("inflar")):
		inflar();
	pass
	
func inflar() -> void:
	if(_tween):
		_tween.kill();
	_tween = get_tree().create_tween();
	_tween.tween_property($Sprite2D,"scale",Vector2(0.2,0.2),0.3).as_relative().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	_tween.tween_property($Sprite2D,"scale",Vector2(1.0,1.0),3.0)
	print("infle")
	pass
