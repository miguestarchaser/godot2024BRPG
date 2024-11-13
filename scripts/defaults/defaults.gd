extends Node

var default_character = load("res://scripts/defaults/character_default.gd");
var save_path = "user://character.res"

#ruta del archivo de guardado
"""var save_path = "user://character.sincopeso"

#informacion por defecto
var data =  {
	"name"			: "chara",
	"portrait"		: "chara",
	"sprite"		: "chara",
	"level"			: 1,
	"max_hp"		: 10,
	"hp"			: 10,
	"max_mp"		: 10,
	"mp"			: 10,
	"intelligence"	:1,
	"strenght"		:2,
	"charisma"		:3
}"""

var data:Resource
"""
#Tratamos de cargar la informacion del archivo si existe, si no 
#regresamos la estructura por defecto.
func load_data():
	if(FileAccess.file_exists(save_path)):
		var json_as_text 	= FileAccess.get_file_as_string(save_path)
		data 			= JSON.parse_string(json_as_text)
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
	
func set_value(key,value)->void:
	data[key] = value;
	#default_character.set_value(key,value);
	pass
	"""

func load_data():
	
	if ResourceLoader.exists(save_path):
		print("cargar")
		data =  ResourceLoader.load(save_path)
	else:
		print("error al cargar")
		get_default_data();
		#save_default_data()
	return data
	
func get_default_data():
	data = default_character.new()
	print(data.name)
	return data;

func save_default_data():
	#data = default_character.new()
	print(data.name)
	print("creando")
	print(data)
	ResourceSaver.save(data, save_path)
	
func set_value(key,value)->void:
	data[key] = value;
	#default_character.set_value(key,value);
	pass

func save_data():
	print("guardar")
	print(data.name)
	
	#default_character.set_value["name"] = data.name;
	#default_character.set_value["portrait"] = data.portrait;
	ResourceSaver.save(data, save_path)
