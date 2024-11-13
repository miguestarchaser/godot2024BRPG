extends Node2D
var _defaults					= load("res://scripts/defaults/defaults.gd");
var _main_scene					= preload("res://escenas/main/main.tscn");
#recopilamos los archivos encontrados
var portraits: Array[String] 	= [];
#indice para navegar el arreglo
var current_portrait:int 		= 0;


var defaults;
var data;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	##Cargamos la info por defecto
	defaults 	= _defaults.new();
	data 		= defaults.load_data();	
	print(data)
	
	##cargamos todas las imagenes de una ruta
	dir_contents("res://assets/sprites/characters")
	print("se encontrarion:"+str(portraits.size())+" Elementos!")
	update_portrait();

	$TextEdit.text = data.name;
	$TextEdit.grab_focus(); 
	
	pass # Replace with function body.

func update_portrait()->void:
	$AudioStreamPlayer2D.play();
	var tweenpt:Tween 		= create_tween();
	tweenpt.tween_property($Sprite2D,"modulate:a",0,0.1);
	tweenpt.tween_property($Sprite2D,"modulate:a",1,0.3);
	#sobree escribimos la textura 
	var texture:Texture2D 	= load("res://assets/sprites/characters/"+portraits[current_portrait]);
	$Sprite2D.set_texture(texture);
	$Sprite2D.scale = Vector2(0.2,0.2)
	pass
	
func _input(event: InputEvent) -> void:
	var current_elements = portraits.size();
	if(Input.is_action_just_pressed("ui_left")):
		current_portrait -= 1;
		if(current_portrait < 0):
			current_portrait = (current_elements-1)
		update_portrait();
	elif(Input.is_action_just_pressed("ui_right")):
		current_portrait += 1;
		if(current_portrait > (current_elements -1)):
			current_portrait = 0;
		update_portrait();
		
	elif(Input.is_action_just_pressed("ui_accept")):
		
		$TextEdit.scroll_vertical = 0;
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func dir_contents(path):
	#explorador de archivos
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			#validamos si es un directorio
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print(file_name);
				#obtenemos la extension
				var ext = file_name.get_extension();
				if(ext!="import"):
					#agregamos los archivos al arreglo
					portraits.push_back(file_name)
					pass
				#print("Found file: " + file_name)
			#asignamos el siguiente archivo	
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _on_button_pressed() -> void:
	var name = $TextEdit.text;
	if(name != ""):
		defaults.set_value("name",name);
		defaults.set_value("portrait", portraits[current_portrait]);
		#data.name 		= name;
		#data.portrait 	= portraits[current_portrait];
		#print(data.name);
		#print(data.portrait);
		$TextEdit.text = "";
		defaults.save_data();
		get_tree().change_scene_to_packed(_main_scene)
	else:
		print("No tiene nombre!")
		pass
	pass # Replace with function body.
