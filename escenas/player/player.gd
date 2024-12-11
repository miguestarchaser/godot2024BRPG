extends CharacterBody2D

var _defaults					= load("res://scripts/defaults/defaults.gd");
var defaults;
var character_info;


@export var speed = 400

func _ready() -> void:
	#print()
	defaults 						= _defaults.new();
	character_info 					= defaults.load_data();	
	var i = 0
	for item in character_info.inventory:
		character_info.inventory.pop_at(i);
		i+=1;
	defaults.save_data();
	print(character_info.inventory)
	pass

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func add_item(key):
	character_info.inventory.push_back(key)
	defaults.save_data();
	pass

func _physics_process(delta):
	get_input()
	move_and_slide()
	for index in get_slide_collision_count():
		var collider := get_slide_collision(index).get_collider();
		if(collider.name=="StaticBody2D"):
			print(collider.name)
			var i = 0;
			for item in character_info.inventory:
				if(item == "key"):
					character_info.inventory.pop_at(i);
					collider.remove();
					defaults.save_data();
					i += 1;
					
	
	
