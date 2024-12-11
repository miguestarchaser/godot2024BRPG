extends Node2D

var _battle_defaults			= load("res://scripts/defaults/battle_default.gd");
var _defaults					= load("res://scripts/defaults/defaults.gd");
var _main_scene					= load("res://escenas/main/main.tscn");

var action_menu:PackedScene		= preload("res://escenas/ui/dinamic_menu/dinamic_menu.tscn")
var _character:PackedScene		= preload("res://escenas/character_menu/character_menu.tscn");
var _enemy:PackedScene			= preload("res://escenas/enemy/enemy.tscn");

var enemies:Array[Node]			= [];
var characters:Array[Node]		= [];
var turn:int 					= 0;
var current_character:int 		= 0;
var player_turn:bool			= true;
var rng 						= RandomNumberGenerator.new()

var battle_defaults;
var character_info;
var defaults;
var data;
var menus = [];
var total_enemies = 0;

var current_state;
var current_menu:int 	= 0;
var menu_loaded:bool 	= false;
var current_battler:int = 0;
var turn_actions 		= [];
var is_atacking:bool 	= false;
enum phases  {SELECT,ACTION,CONFIRM,END}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_defaults = _battle_defaults.new();
	var data = battle_defaults.load_data();
	defaults 						= _defaults.new();
	character_info 					= defaults.load_data();	
	create_enemies(data);
	create_battle_interface(character_info);
	print(character_info)
	current_state = phases.SELECT;
	if(player_turn):
		actions();
	pass # Replace with function body.
	
func create_enemies(data)->void:
	total_enemies = rng.randi_range(1,3);
	for e in total_enemies:
		enemies.push_back(_enemy.instantiate())
		add_child(enemies[e]);
		enemies[e]._set_data(data)
		if(e > 0):
			enemies[e].position.x =  (enemies[e-1].position.x + 200);
			enemies[e].position.y =  (enemies[e-1].position.y);
		else:
			enemies[e].position = $enemy.position;
		pass
	pass

func create_battle_interface(character_info)->void:
	
	var current_characters = 1;
	for chara in current_characters:
		characters.push_back(_character.instantiate())
		add_child(characters[chara])
		characters[chara].set_data(character_info);
		#current_character += 1;
		#characters[current_character].create(character);
		if(chara > 0):
			characters[chara].position.x =  (characters[chara-1].position.x + 400);
			characters[chara].position.y =  (characters[chara-1].position.y);
		else:
			characters[chara].position = $player.position;
		pass
	pass
	
func actions() -> void:
	if(current_state == phases.SELECT):
		menu_loaded = false;
		select_battler();
	elif(current_state == phases.ACTION):
		show_menu();
	pass
	
func show_menu()->void:
	if(!menu_loaded):
		menu_loaded = true;
		menus.push_back(action_menu.instantiate());
		add_child(menus[current_menu])
		var options = menus[current_menu].get_dict_from_json("action_menu"	)
		menus[current_menu].create_menu(options);
		menus[current_menu].connect("selected_action",menu_actions,1)
	pass

func menu_actions(action)->void:
	print(action)
	if(action=="CANCEL"):
		#REGRESA AL MENU ANTERIOR O LO QUITA
		is_atacking = false;
		menus[current_menu].queue_free();
		menus.pop_at(current_menu)
		current_menu -= 1;
		if(current_menu>=0):
			menus[current_menu].eneable_menu();
		else:
			if(current_state==phases.ACTION):
				current_menu = 0;
				current_state=phases.SELECT;
				actions();
		pass
	else:
		#CARGA EL CONTENIDO DE LA OPCION SELECCIONADA
		var options = {};
		if(is_atacking == true):
			print("cerrar ataque")
		elif(action=="ATACK"):
			is_atacking = true;
			options = get_enemy_list();#menus[current_menu].get_dict_from_json("atacks_menu"	)
		elif(action=="SCAPE"):
			abort_combat();	
		#if(action=="SLASH"):
		#	options = menus[current_menu].get_dict_from_json("enemies"	)
		elif(action=="DEFEND"):
			print("defender")
			
		elif(action=="ITEM"):
			print("items")
		else:
			print(action)
		if("actions" in options):
			##CREA EL MENU A APRTIR DE LAS OPCIONES	
			current_menu += 1;
			menus.push_back(action_menu.instantiate());
			add_child(menus[current_menu])
			menus[current_menu].create_menu(options);
			menus[current_menu].connect("selected_action",menu_actions,1)
			menus[current_menu].position.x += menus[current_menu-1].position.x +200;
			if(is_atacking):
				menus[current_menu].connect("change_option",select_enemy,2)
	pass
	
func abort_combat():
	print("salir!")
	get_tree().change_scene_to_packed(_main_scene)
	pass
	
func get_enemy_list():
	var list 		= {};
	list["actions"] =[];
	var e = 0;
	for enemy in enemies:
		var tmp = {"key":e,"text":{"es":"Monster "+str(e),"en":"Monster"}}
		list["actions"].push_back(tmp);
		e +=1;
		pass
	var tmp = {"key":"CANCEL","text":{"es":"Cancelar","en":"Cancelar"}}
	list["actions"].push_back(tmp);
	print(list)
	return list;

func select_enemy(enemyID) -> void:
	print(enemyID)
	var e = 0;
	for enemy in enemies:
		enemy.scale = Vector2(1,1);
		if(e == int(enemyID)):
			enemy.scale = Vector2(1.2,1.2);
		pass
		e += 1;
		
	pass	
	
func select_battler() ->void:
	for item in characters:
		item.scale = Vector2(1,1)
	characters[current_battler].scale = Vector2(1.1,1.1)
	pass

func _input(event: InputEvent) -> void:
	var  charas=  characters.size();
	if(Input.is_action_just_pressed("ui_right")):
		current_battler += 1;
		if(current_battler > (charas-1)):
			current_battler = 0;
	elif(Input.is_action_just_pressed("ui_left")):
		current_battler -= 1;
		if(current_battler < 0):
			current_battler = charas-1;
	elif(Input.is_action_just_pressed("ui_accept")):
		if(current_state == phases.SELECT):
			current_state = phases.ACTION;
		pass
	actions();
pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#actions();
	pass
