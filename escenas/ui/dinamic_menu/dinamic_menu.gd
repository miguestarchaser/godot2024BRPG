extends Control
#conten
var menu_data 				= {}
#Idioma
var lang:String 			= "es";
#determinamos si esta activo
var active:bool 			= true;
#Posicion actual del cursor
var current_position:int 	= 1;
#Guardamos el set de llaves del menu
var actions:Array[String] 	= [];

#Ayuda a determinar el tamaño maximo del contenedor
var last_item_position:Vector2; 

#Notifica la opcion seleccionada
signal 	selected_action(action);
signal  change_option(option) 

var ui_enter 	= preload("res://assets/sounds/22.wav") 			
var ui_move 	= preload("res://assets/sounds/06.wav")

var ui_tween:Tween;  			

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func get_dict_from_json(filename):#->Dictionary{String}
	#leemos y cargamos el JSON en un diccionario
	var file = "res://data/menus/"+filename+".json"
	var json_as_text 	= FileAccess.get_file_as_string(file)
	var json_dict 		= JSON.parse_string(json_as_text)
	#if menu_data:
	return json_dict;
	

func create_menu(dataset)->void:
	#Creamos el menu a partir del set de datos 
	menu_data = dataset;
	last_item_position = Vector2($Cursor.position.x + 30, $Cursor.position.y-10)
	for action in menu_data.actions:
		#print(action.key)
		actions.append(str(action.key))
		var lbl = Label.new();
		$Labels.add_child(lbl);
		lbl.set_text(action["text"][lang]);
		lbl.position = last_item_position;
		last_item_position.y += 30; 
		pass
		size = Vector2(200,last_item_position.y+10);
		update_labels(current_position);
	pass
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_labels(target) -> void:
	var current = 1;
	for label in $Labels.get_children():
		if(current == target):
			label.add_theme_color_override("font_color",Color.WEB_GREEN)
			#print("emitiendo:")
			#print(actions[current_position-1])
			emit_signal("change_option",(current-1));
		else:
			label.add_theme_color_override("font_color",Color.WHITE)
		current += 1;
		pass
	pass
	
func eneable_menu()->void:
	active = true;
	pass	

func _input(event: InputEvent) -> void:
	if(active):
		$AudioStreamPlayer2D.stream = ui_move;
		if(Input.is_action_just_pressed("ui_up")):
			if(ui_tween):
				ui_tween.kill();
			ui_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN);
			$AudioStreamPlayer2D.play()
			if(current_position == 1):
				current_position = $Labels.get_child_count();
			else:
				current_position -= 1;
			pass
			var label = $Labels.get_child(current_position-1)
			#$Cursor.global_position.y = label.global_position.y+10;
			ui_tween.tween_property($Cursor,"global_position:y",( label.global_position.y+10),0.1)#.as_relative();
			update_labels(current_position);			
		if(Input.is_action_just_pressed("ui_down")):
			$AudioStreamPlayer2D.play()
			if(ui_tween):
				ui_tween.kill();
			ui_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN);
			if(current_position >= $Labels.get_child_count()):
				current_position = 1;
			else:
				current_position += 1;
			pass
			var label = $Labels.get_child(current_position-1)#get_node("Control/Label"+str(current_position));
			#$Cursor.global_position.y = label.global_position.y+10;
			ui_tween.tween_property($Cursor,"global_position:y",( label.global_position.y+10),0.1)#.as_relative();
			
			update_labels(current_position);
		if(Input.is_action_just_pressed("ui_accept")):
			active = false;
			$AudioStreamPlayer2D.stream = ui_enter;
			$AudioStreamPlayer2D.play()
			print(actions.size())
			emit_signal("selected_action",actions[current_position-1]);#menu_data["actions"][current_position].values
			pass
	pass
