extends Node2D

#Definimos la ruta para guardar nuestros archivos de item
var item_dir:String 			= "res://data/item/";
#cargamos la platilla de item generico
var item_defaults:Resource  	= load("res://scripts/defaults/item_defaults.gd")
#Aqui guardaremos la informacion del item creado/editado
var item_default:Resource;
#Coleccion de sprites de items
var portraits: Array[String] 	= [];
#Coleccion de items de nuestro directorio
var items:Array[String]			= []
#indice para navegar el arreglo de imagenes
var current_portrait:int 		= 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#instanciar la plantilla de item
	item_default = item_defaults.new();
	#Seteamos el icono del input de opciones de items
	var sprite:Texture2D = load("res://assets/sprites/items/Skeleton Key - 2.png")
	
	#LLenamos el input de opciones de tipo de item con nuestro listado
	for type in item_default.types:
		%item_type.add_icon_item(sprite,type)
		#$Panel/VBoxContainer/tipo/item_type.add_item(type)
	#Actualizamos el input
	update_item_list();
	
	#llenamos nuestra lista de sprites de items
	portraits = dir_contents("res://assets/sprites/items","png")
	print("se encontrarion:"+str(portraits.size())+" Elementos!")
	#actualizamos el sprite por defecto
	update_portrait();	
	%borrar.visible = false;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_item_list()->void:
	#limpiamos el contenido del input de items
	%item_list.clear();
	#escaneamos y traemos de nuevo todo el contenido de la carpeta
	items = dir_contents("res://data/item","res")
	#creamos la opcion de nuevo item
	%item_list.add_item("NUEVO");
	#agregamos el contenido de la carpeta 
	for item in items:
		var load_path 				= item_dir+item;
		var load_item 				= load(load_path);
		var sprite:Texture2D 		= load("res://assets/sprites/items/"+load_item.sprite)
		#sprite.set("scale",Vector2(0.5,0.5))
	
		##%item_list.add_item(item);
		%item_list.add_icon_item(sprite,item)
	%item_list.fit_to_longest_item = false
	pass

#cabiamos de sprite hacia atras
func _on_prev_sprite_button_up() -> void:
	
	var current_elements = portraits.size();
	current_portrait -= 1;
	if(current_portrait < 0):
		current_portrait = (current_elements-1)
	update_portrait();
	pass # Replace with function body.

#cabiamos de sprite hacia adelante
func _on_next_sprite_button_up() -> void:
	var current_elements = portraits.size();
	current_portrait += 1;
	if(current_portrait > (current_elements -1)):
		current_portrait = 0;
	update_portrait();
	pass # Replace with function body.
	
##Funciones de ayuda
#Actualizamos el sprite
func update_portrait()->void:
	#$AudioStreamPlayer2D.play();
	#sobree escribimos la textura 
	var texture:Texture2D 	= load("res://assets/sprites/items/"+portraits[current_portrait]);
	%Sprite2D.set_texture(texture);
	%Sprite2D.scale = Vector2(0.9,0.9)
	pass

#Escaneamos el contenido de una carpeta en busca de los elementos
#con la extension solicitada
func dir_contents(path,extension)->Array[String]:
	#explorador de archivos
	var item_list:Array[String] = []
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
				if(ext!="import" && extension==ext):
					#agregamos los archivos al arreglo
					item_list.push_back(file_name)
					pass
				#print("Found file: " + file_name)
			#asignamos el siguiente archivo	
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return item_list;

#Funcion de guardado, señal lanzado por el boton guardar
func _on_save_button_up() -> void:
	#solo guardamos si el input de itemkey tiene contenido
	if(%item_key.text !=""):
		#seteamos la ruta de nuestro nuevo archivo
		var file 					= item_dir+%item_key.text+".res";
		#llnamos los datos de nuestro objeto con los inputs
		item_default.key 			= %item_key.text;
		item_default.name 			= %item_name.text;
		#obtenemos el texto del input a partir el id que nos regresa
		item_default.type 			= %item_type.get_item_text(%item_type.get_selected_id());
		item_default.sprite 		= portraits[current_portrait];
		item_default.description	= %item_desc.text;
		item_default.unique			= %item_unique.button_pressed;
		print(item_default.key)
		print(item_default.name)
		print(item_default.type)
		print(item_default.sprite)
		print(item_default.description)
		print(item_default.unique)
		print("item uico:")
		print( item_default.unique)
		#guardamos
		ResourceSaver.save(item_default, file);
		#actualizamos la lista de items disponibles
		update_item_list();
		clear_inputs();
	pass # Replace with function body.

func clear_inputs()->void:
	$"%item_list".select(0)
	%item_key.text	 			= ""
	%item_name.text	 			= ""
	%item_type.select(0);
	%item_desc.text				= "";
	#%item_unique.toggle_mode	= false;	
	%item_unique.button_pressed = false;
	%item_key.editable			= true;
	%borrar.visible 			= false;
	current_portrait			= 0;
	update_portrait();
	pass

#Cargar un item de la lista
func _on_item_list_item_selected(index: int) -> void:
	#print("OPCION SELECCIONADA")
	#print(index)
	#Si el index es 0 limpiamos los items para crear un item nuevo
	if(index==0):
		clear_inputs();
		%borrar.visible = false;
	else:
		#Si no buscamos el item y lo cargamos
		#recuperamos el nombre del archivo de la lista
		var target 					= %item_list.get_item_text(%item_list.get_selected_id());
		#definimos la ruta
		var load_path 				= item_dir+target;
		#cargamos la informacion
		var load_item 				= load(load_path);
		#seteamos los inputs con los valores cargos de nuestro item
		%item_key.text	 			= load_item.key;
		%item_name.text	 			= load_item.name;
		%item_desc.text				= load_item.description;
		#%item_unique.toggle_mode	= unique_item;
		%item_unique.button_pressed =load_item.unique;
		##SETEAR SPRITE
		current_portrait = 0;
		var finded = false;
		for portrait in portraits:
			if(portrait == load_item.sprite):
				finded = true;
			if(finded):
				update_portrait();
				break
			current_portrait+=1;
		#SETEAR TIPO
		var type_count = 0;
		finded = false;
		for type in item_default.types:
			if(type==load_item.type):
				finded=true;
			if(finded):
				break
			type_count+=1;
		#Seteamos el switch button
		%item_type.select(type_count);
		#bloqueamos la edicion de key para evitar duplicar archivos
		%item_key.editable	= false;
		%borrar.visible 	= true;
	pass # Replace with function body.


func _on_borrar_button_up() -> void:
	var target 					= %item_list.get_item_text(%item_list.get_selected_id())
	var path 					= item_dir+target;
	DirAccess.remove_absolute(path)
	update_item_list();
	clear_inputs()
	
	pass # Replace with function body.
