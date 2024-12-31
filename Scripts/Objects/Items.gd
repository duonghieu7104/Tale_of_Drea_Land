extends Resource

class_name Items

@export var name : String
@export var type : String
@export var description : String
@export var effects : Dictionary

var effectable : Effectable = Effectable.new()

func _init(_name = "", _type = "", _description = "", _effects = {}):
	name = _name
	type = _type
	description = _description
	effects = _effects

func apply_equipment_effects(target):
	effectable.apply_item_effects(target)
