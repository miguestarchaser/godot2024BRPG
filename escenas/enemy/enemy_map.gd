extends Area2D

signal battle_start(enemy_id);

var enemy_id 	= 0;
var rng 		= RandomNumberGenerator.new()
var tween 		= create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR);
@onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("player pos"+str(player.position))

	var my_random_number = rng.randi_range(1,5)
	enemy_id = my_random_number;
	var monster = "monster"+str(my_random_number);
	print(monster);
	$AnimatedSprite2D.play(monster)
	$AnimatedSprite2D.pause();
	tween.set_loops(0)
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(1.1,1.1),0.3)
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(1.0,1.0),0.3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_position = (player.position - position).normalized()
	#print(target_position)
	#if(position.direction_to(player.position)>3):
	#	print("perseguir")
	#	pass
	pass


func _on_body_entered(body: Node2D) -> void:
	emit_signal("battle_start",enemy_id);
	queue_free();
	#var tween:Tween = create_tween();
	#tween.tween_property(self,"position",body.position,0.5)
	
	pass # Replace with function body.
