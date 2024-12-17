@tool
extends Area2D

var item_dir:String 	= "res://data/item/";
var utilities 			= load("res://scripts/utilities/utilities.gd")
var utility  			= utilities.new()
#var items 				= utility.dir_contents(item_dir,"res");
@export_group("Propiedades del item")
#@export var item_list:Array[String] = items;
var previus_file			 = ""; 
@export var item_key:String  = "";
@export var item_name:String = "";
@export var item_type:String = "";
@export var item_icon:String = "";
@export var item_desc:String = "";
@export var item_unique:bool = false;

#@export_subgroup("Enums")
#enum NamedEnum {UNO,DOS,TRES,CUATRO}
#@export var x:NamedEnum

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(items)
	#print(item_list)

	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(previus_file!=item_key):
		print("actuaizar item")
		var file_path = "res://data/item/"+item_key+".res"
		print(file_path)
		#Verificamos si existe el archivo
		if ResourceLoader.exists(file_path):
			#cargamos la informacion a nuestro item
			var item_data = load(file_path)
			var texture = "res://assets/sprites/items/"+item_data.sprite
			$Sprite2D.set_texture(load(texture))
			previus_file = item_key;
			item_name=item_data.name
			item_icon=item_data.sprite
			item_type=item_data.type
			item_desc=item_data.description
			item_unique=item_data.unique
		else:
			print("no existe")
	pass


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name=="Player"):
		body.add_item(item_key);
		queue_free();
	pass # Replace with function body.
