extends CanvasItem

var 	current_position:int = 1;
#enum 	actions{ATACK,DEFEND,ITEM,END};
var actions = {1:"ATACK",2:"DEFEND",3:"ITEM",4:"END"};
signal 	selected_action(action);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func update_labels(target) -> void:
	var current = 1;
	for label in $Control.get_children():
		if(current == target):
			label.add_theme_color_override("font_color",Color.WEB_GREEN)
		else:
			label.add_theme_color_override("font_color",Color.WHITE)
		current += 1;
		pass
	pass	

func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_up")):
		$AudioStreamPlayer2D.play()
		if(current_position == 1):
			current_position = 4;
		else:
			current_position -= 1;
		pass
		var marker = get_node("Marker2D"+str(current_position));
		#var label = get_node("Control/Label"+str(current_position));
		$Sprite2D.position.y = marker.position.y;
		update_labels(current_position);
		#label.add_theme_color_override("font_color",Color.WEB_GREEN)
		
	if(Input.is_action_just_pressed("ui_down")):
		#reset_labels();
		$AudioStreamPlayer2D.play()
		if(current_position == 4):
			current_position = 1;
		else:
			current_position += 1;
		pass
		var marker = get_node("Marker2D"+str(current_position));
		#var label = get_node("Control/Label"+str(current_position));
		$Sprite2D.position.y = marker.position.y;
		update_labels(current_position);
		#label.add_theme_color_override("font_color",Color.WEB_GREEN)
	if(Input.is_action_just_pressed("ui_accept")):
		emit_signal("selected_action",actions[current_position]);
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
