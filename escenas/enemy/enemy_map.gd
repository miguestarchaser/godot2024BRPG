extends Area2D

signal battle_start(enemy_id);
#Navigation agent para el nav mesh
@onready var navigation_agent:NavigationAgent2D = $NavigationAgent2D;
@export var target_to_chase:CharacterBody2D;

var enemy_id:int 					= 0;
var rng:RandomNumberGenerator 		= RandomNumberGenerator.new()
@onready var tween:Tween 					= get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR);
@onready var chase_tween:Tween 				= get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR);

#obtenemos la instancia del player
@onready var player = get_parent().get_node("Player")

#var speed = 100;
var SPEED = 50.0
var player_pos:Vector2;
var target_pos:Vector2;

var chase:bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("player pos"+str(player.position))

	var my_random_number:int = rng.randi_range(1,5)
	enemy_id = my_random_number;
	var monster:String = "monster"+str(my_random_number);
	#print(monster);
	$AnimatedSprite2D.play(monster)
	$AnimatedSprite2D.pause();
	tween.set_loops(0)
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(1.1,1.1),0.3)
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(1.0,1.0),0.3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#solo si ni se a visto al jugador se tratara de buscar
	if(!chase):
		#obtenemos su poscicion
		player_pos = player.position;
		target_pos = (player_pos - position);
		#raycast alrededor del enemigo
		#$RayCast2D.rotation += 1;
		#raycast hacia la pocision del jugador
		$RayCast2D.target_position = target_pos;
		pass
	if($RayCast2D.is_colliding()):
		#funciones de raycast
		var collider 	= $RayCast2D.get_collider();
		#var col_point 	=  $RayCast2D.get_collision_point();
		#var local_point = to_local(col_point);
		#print(collider.name )
		if(collider.name == "Player"):
			#vimos al jugador
			#print("te vi")
			if(chase==false):
				#perseguir al jugador
				$AudioStreamPlayer2D.play();
				#chase_tween.tween_property($AnimatedSprite2D,"modulate",Color.RED,0.3)
				chase = true;
		elif(collider.name == "TileMapLayer"):
			#perdimos de vista al jugador
			#print("no te vi")
			chase = false;
			
	
	# PERSEGUIR AL JUGADOR USANDO EL NAVIGATION MESH
	#player_pos = player.position;
	#target_pos = (player_pos - position).normalized();
	#validamos la distancia del jugador
	#if(position.distance_to(player_pos)<400.00):
	#if(chase):
	#	navigation_agent.target_position = player.global_position;
	#	var target_pos = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED 
	#	position += (target_pos) * delta;

	# PERSEGUIR AL JUGADOR USANDO SIN EL NAVIGATION MESH
	if(chase):
		player_pos = player.position;
		target_pos = (player_pos - position).normalized();
		#print(target_position)
		#print(position.distance_to(player_pos))
		#validamos la distancia del jugador
		#if(position.distance_to(player_pos)<1000.00):
		position += (target_pos * SPEED) * delta;
		#print("perseguir")
		#pass"""
	pass


func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		#emit_signal("battle_start",enemy_id);
		get_parent().get_parent().combat_start(enemy_id)
		queue_free();
		#var tween:Tween = create_tween();
	
	pass # Replace with function body.
