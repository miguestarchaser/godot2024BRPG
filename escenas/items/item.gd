extends Area2D
@export var item_key:String  = "";
@export var item_name:String = "";
@export var item_type:String = "";
@export var item_icon:String = "";
@export var item_unique:bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _set_item_data(filename:String)->void:
	var file = "res://data/menus/"+filename+".json"
	var json_as_text 	= FileAccess.get_file_as_string(file)
	var json_dict 		= JSON.parse_string(json_as_text)
	item_key 			= json_dict.key;
	item_name 			= json_dict.name;
	item_type 			= json_dict.type;
	item_icon 			= json_dict.icon;
	item_unique 		= json_dict.unique;
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if(body.name=="Player"):
		body.add_item(item_key);
		queue_free();
	pass # Replace with function body.
