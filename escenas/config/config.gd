extends Node2D

var score_data = {}
var config = ConfigFile.new()
var savepath = "user://scores.cfg";
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create new ConfigFile object.
	if(FileAccess.file_exists(savepath)):
		load_config_data();
	else:
		save_default();
		pass
	pass # Replace with function body.


func save_default()->void:
	# Store some values.
	print("crear archivo")
	config.set_value("Player1", "player_name", "Steve")
	config.set_value("Player1", "best_score", 10)
	config.set_value("Player2", "player_name", "V3geta")
	config.set_value("Player2", "best_score", 9001)
	config.set_value("Player3", "player_name", "lolo")
	config.set_value("Player3", "best_score", 9002)
	# Save it to a file (overwrite if already exists).
	config.save(savepath)
	pass
	
func load_config_data()->void:
	print("leer archivo")
	# Load data from a file.
	var err = config.load(savepath)
	# If the file didn't load, ignore it.
	if err != OK:
		return
	# Iterate over all sections.
	for player in config.get_sections():
		# Fetch the data for each section.
		var player_name = config.get_value(player, "player_name")
		var player_score = config.get_value(player, "best_score")
		score_data[player_name] = player_score
	
	print(score_data);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
