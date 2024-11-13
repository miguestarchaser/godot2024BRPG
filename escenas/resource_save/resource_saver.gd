extends Node2D

var _player_data 	= load("res://escenas/resource_save/player_data.gd")
var save_path 		= "user://player_info.res"

var player_data:Resource; 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player_data = _player_data.new();
	#print(player_data.position)
	player_data = load_data(); 
	_on_leer_pressed();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_data():
	
	if ResourceLoader.exists(save_path):
		print("cargar")
		player_data =  ResourceLoader.load(save_path)
	else:
		print("error al cargar")
		player_data = _player_data.new()
		#save_default_data()
	return player_data
	
func set_value(key,value)->void:
	player_data[key] = value;
	#default_character.set_value(key,value);
	pass

func save_data():
	print("guardar")
	ResourceSaver.save(player_data, save_path)


func _on_guardar_pressed() -> void:
	player_data.position 	= $CharacterBody2D.position;
	player_data.color 		= $CharacterBody2D/Sprite2D.modulate;
	save_data();
	pass # Replace with function body.


func _on_leer_pressed() -> void:
	$CharacterBody2D.position = player_data.position;
	$CharacterBody2D/Sprite2D.modulate = player_data.color ;
	pass # Replace with function body.
