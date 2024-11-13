extends Node2D

@export  var id:int      = 0;
@export  var hp:int      = 0;  
@export  var max_hp:int  = 100;  
@export  var max_mp:int  = 0;  
@export  var level:int   = 0;
@export  var armor:int   = 0;
@export  var power:int   = 0;
@export  var luck:int    = 0;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#crear un tween 
	var tween_bar:Tween = get_tree().create_tween(); 
	tween_bar.set_parallel(true)
	#tween_bar.set_loops()
	tween_bar.tween_method(initial_hp,hp,100,1);
	tween_bar.tween_property($ProgressBar,"modulate",Color.RED,1).from(Color.WHITE)#.from(Vector2(2.0,2.0))
	#tween_bar.tween_property($ProgressBar,"scale",Vector2(1,1),1).from(Vector2(2,2))#.from(Vector2(2.0,2.0))
	_animate()
	$Label.text = "Draconido"
	pass # Replace with function body.
	
func _set_data(data)->void:
	print(data);
	id = data.monster_id;
	$AnimatedSprite2D.play("monster"+str(id))
	$AnimatedSprite2D.pause();
	pass
	
func _test():
	print("saludos!")
	pass
	
func _animate() -> void:
	var tween:Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT);
	tween.set_loops()
	#Nodo Objetivo, propiedad, valor, tiempo
	#tween.set_parallel(true)
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(1.1,1.2),1.5)#.from(Vector2(2.0,2.0))
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(1.0,1.0),1.5)
	#tween.tween_interval(2)
	#tween.tween_property($AnimatedSprite2D,"modulate",Color.RED,1.5)
	#tween.tween_property($AnimatedSprite2D,"modulate",Color.WHITE,1.5)
	
	#se mana llamar cuando se termina la animacion
	#tween.tween_callback(_animate)
	#tween.stop();
	
	var tween_rotate:Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT);
	tween_rotate.set_loops()
	tween_rotate.tween_property($AnimatedSprite2D,"rotation",deg_to_rad(1),1.5)#.from(Vector2(2.0,2.0))
	tween_rotate.tween_property($AnimatedSprite2D,"rotation",deg_to_rad(0),1.5)
	
	#var tween_move:Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT);
	#tween_move.set_loops()
	#tween_move.tween_property($AnimatedSprite2D,"modulate:a",0,0.5).from(1);
	#tween_move.tween_property($AnimatedSprite2D,"modulate:a",1,0.5);
	pass	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _input(event: InputEvent) -> void:
	#if(event.as_text()=="Space"):
		#demage(10);
	if(event.is_action_pressed("inflar")):
		print("demage_press")
		demage(10);
	pass
	
func demage(_demage) -> void:
	print("demage")
	var tween_demage:Tween = get_tree().create_tween(); 
	tween_demage.set_parallel(true)
	tween_demage.tween_method(initial_hp,hp,(hp-_demage),0.5);
	#var tween_demage:Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT);
	tween_demage.tween_property($AnimatedSprite2D,"modulate:v",1,0.3).from(15)#.from(Vector2(2.0,2.0))
	var tween_scale:Tween = get_tree().create_tween(); 
	
	tween_scale.tween_property($AnimatedSprite2D,"scale",Vector2(0.8,0.8),0.1)
	tween_scale.tween_property($AnimatedSprite2D,"scale",Vector2(1.0,1.0),0.1)#.from(Vector2(0.5,0.5))
	pass	
	
func initial_hp(_hp)->void:
	print("current hp:"+str(_hp))
	#$Label.set_text(str(_hp))
	$TextureProgressBar.value = hp;
	hp = _hp;
	pass
