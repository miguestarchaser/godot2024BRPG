extends Node2D

var _battle_defaults			= load("res://scripts/defaults/battle_default.gd");
var _defaults					= load("res://scripts/defaults/defaults.gd");


var action_menu:PackedScene				= preload("res://escenas/ui/dinamic_menu/dinamic_menu.tscn")
var _character:PackedScene				= preload("res://escenas/character_menu/character_menu.tscn");
var _enemy:PackedScene					= preload("res://escenas/enemy/enemy.tscn");

var enemies:Array[Node]					= [];
var characters:Array[Node]				= [];
var turn:int 							= 0;
var current_character:int 				= 0;
var player_turn:bool					= true;
var rng 								= RandomNumberGenerator.new()

var battle_defaults;
var character_info;
var defaults;
var data;
var total_enemies = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_defaults = _battle_defaults.new();
	var data = battle_defaults.load_data();
	defaults 						= _defaults.new();
	character_info 					= defaults.load_data();	
	create_enemies(data);
	create_battle_interface(character_info);
	print(character_info)
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
		add_child(characters[current_character])
		characters[current_character].set_data(character_info);
		characters[current_character].position = $player.position;
		#characters[current_character].create(character);
		current_character += 1;
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
