extends Resource

class_name Inventory

@export var equipments: Array = [] 
@export var items: Array = [] 
@export var materials: Array = [] 
@export var story_items: Array = []

func add_equipmet(equipment : Equipments):
	self.equipments.append(equipment)
