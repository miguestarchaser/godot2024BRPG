extends Node2D


var _character_create			= load("res://escenas/ui/character_creation/character_creation.tscn");
var _character_menu				= load("res://escenas/character_menu/character_menu.tscn");
var _player 					= load("res://escenas/player/player.tscn");
var _enemy 						= load("res://escenas/enemy/enemy_map.tscn");
var _defaults					= load("res://scripts/defaults/defaults.gd");
var _battle_defaults			= load("res://scripts/defaults/battle_default.gd");

var defaults:Node;
var battle_defaults:Node;
var player;
var enemy;

#var _menu:PackedScene	 		= preload("res://escenas/ui/dinamic_menu/dinamic_menu.tscn")
#ar _menu_feo:PackedScene 		= preload("res://escenas/ui/battle_menu/battle_menu.tscn")
var _combat_scene 				= preload("res://escenas/combat/combat.tscn")
var enemies:Array[Node2D] 		= [];
var characters:Array[Node2D] 	= [];
#var menus:Array[Control] 		= [];
#var current_menu:int 			= 0;

var combat_screen:Node
var character_create;
var character_menu;
var character_info;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#main_menu();
	#get_tree().root.add_child(_combat_scene)
	#$Area2D.connect("body_entered",combat_start,1);
	#buscamos el archivo de guardado
	#if(FileAccess.file_exists("user://character.sincopeso")):
	if(FileAccess.file_exists("user://character.res")):
		battle_defaults = _battle_defaults.new();
		set_character();
		
	else:
		print("no existe")
		#character_create = _character_create.instantiate();
		#get_tree().set_root() = character_create;
		
		call_deferred("create_character")
		
		
		#get_tree().change_scene_to_file("res://escenas/ui/character_creation/character_creation.tscn");
		#self.queue_free()
	pass

	pass # Replace with function body.
	

func set_character() -> void:
	#defaults 		= _defaults.new();
	#character_info 	= defaults.load_data();	
	player 			= _player.instantiate(); 
	add_child(player)
	enemy 			= _enemy.instantiate();
	add_child(enemy)
	enemy.position = Vector2(900,400)
	enemy.connect("battle_start",combat_start,1);
	
	#print(character_info.name)
	#print(character_info.portrait)
#	character_menu = _character_menu.instantiate();
#	add_child(character_menu)
#	character_menu.set_data(character_info);
	

	pass
	
func create_character()->void:
	#Cambiamos la escena por una pre cargada
	get_tree().change_scene_to_packed(_character_create)
	#cambiamos la escena por otro archivo
	#get_tree().change_scene_to_file("res://escenas/ui/character_creation/character_creation.tscn")
	pass

func combat_start(enemy:int)->void:
	battle_defaults.set_value("monster_id",enemy)
	battle_defaults.set_value("escenary_type","forest")
	battle_defaults.save_data();
	
	print("cargando escena")
	get_tree().change_scene_to_packed(_combat_scene)
	#combat_screen = _combat_scene.instantiate();
	#get_tree().root.add_child(combat_screen)
	#get_tree().change_scene_to_file("res://escenas/combat/combat.tscn")
	pass	
	
"""func main_menu()->void: 
	menus.push_back(_menu.instantiate());
	add_child(menus[current_menu])
	var options = menus[current_menu].get_dict_from_json("action_menu"	)
	menus[current_menu].create_menu(options);
	menus[current_menu].connect("selected_action",actions,1)
	
	pass"""

"""func actions(action)->void:
	
	if(action=="CANCEL"):
		#REGRESA AL MENU ANTERIOR O LO QUITA
		menus[current_menu].queue_free();
		menus.pop_at(current_menu)
		current_menu -= 1;
		if(current_menu>=0):
			menus[current_menu].eneable_menu();
		pass
	else:
		#CARGA EL CONTENIDO DE LA OPCION SELECCIONADA
		var options = {};
		if(action=="ATACK"):
			options = menus[current_menu].get_dict_from_json("atacks_menu"	)
		if(action=="SLASH"):
			options = menus[current_menu].get_dict_from_json("enemies"	)
		elif(action=="DEFEND"):
			options = menus[current_menu].get_dict_from_json("atacks_menu"	)
		elif(action=="ITEM"):
			options = menus[current_menu].get_dict_from_json("item_menu"	)
		else:
			print(action)
		if("actions" in options):
			##CREA EL MENU A APRTIR DE LAS OPCIONES	
			current_menu += 1;
			menus.push_back(_menu.instantiate());
			add_child(menus[current_menu])
			menus[current_menu].create_menu(options);
			menus[current_menu].connect("selected_action",actions,1)
			menus[current_menu].position.x += menus[current_menu-1].position.x +200;
	pass"""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
