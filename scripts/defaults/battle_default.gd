extends Node

var save_path 		= "user://battle.dat";
#var data;
var data	= {
	"monster_id":0,
	"escenary_type":""
}

func set_value(key,value)->void:
	data[key] = value;
	#default_character.set_value(key,value);
	pass

func load_data():
	if(FileAccess.file_exists(save_path)):
		var json_as_text 	= FileAccess.get_file_as_string(save_path)
		data 				= JSON.parse_string(json_as_text)
		print(data)
		print("entre")
	return data;

func save_data() ->void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	# Store the save dictionary as a new line in the save file.
	save_file.store_line(json_string)
	save_file.close();
	pass
