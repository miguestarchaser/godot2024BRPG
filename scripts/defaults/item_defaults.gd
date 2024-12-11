extends Resource

class_name item_data

enum types {WEAPON,ARMOR,KEY,CONSUMABLE,MATERIAL,QUEST}

@export var key:String 			= "";
@export var name:String 		= "";
@export var type:String 		= "";
@export var sprite:String 		= "";
@export var description:String 	= "";
@export var unique:bool 		= false;
