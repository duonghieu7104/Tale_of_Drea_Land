extends Resource

class_name Equipments

@export var name : String
@export var type : String # helmet (giáp mũ) - ring (nhẫn) - necklace (vòng cổ) - weapon (vũ khí) - weapon (vũ khí) - armor1 (giáp thân) - armor2 (giáp) - gloves (găng tay) - boots (giày)
@export var rank : String # Grey - Green - Blue - Orange - Red - Purple - Black
@export var level : int
@export var description : String
@export var weight : int
@export var stats : Dictionary
@export var effects : Dictionary

@export var texture_path : String
@export var rank_texture_path : String

var effectable : Effectable = Effectable.new()

#const IncreaseHpEffect = preload("res://Scripts/Objects/Effects/IncreaseHpEffect.gd")

func _init(_name = "", _type = "", _description = "", _stats = {}, _effects = {}):
	name = _name
	type = _type
	description = _description
	stats = _stats
	effects = _effects

func apply_equipment_effects(target):
	effectable.effects = self.stats
	effectable.apply_item_effects(target)
