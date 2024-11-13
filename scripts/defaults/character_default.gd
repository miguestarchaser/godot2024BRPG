extends Resource

class_name character_data

@export var name:String 		= "chara";
@export var portrait:String		= "chara";
@export var sprite:String 		= "chara";

@export var level:int 			= 1;
@export var experience:int 		= 0;
@export var strength:int 		= 5;
@export var intelligence:int 	= 3;
@export var charisma:int 		= 2;

@export var max_hp:int			= 10;
@export var hp:int 				= 10;
@export var max_mp:int			= 5;
@export var mp:int 				= 5;

@export var position:Vector2 	= Vector2(0,0)
@export var color:Color 		= Color.AZURE;
@export var ready:bool 			= true;
