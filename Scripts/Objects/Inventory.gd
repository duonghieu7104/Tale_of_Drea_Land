extends Resource

class_name Inventory

@export var equipments : Array = [] 
@export var items : Array = [] 
@export var materials : Array = [] 
@export var story_items : Array = []
@export var others : Array = []

@export var equipped_items : Array = []
# index 0 : helmet (giáp mũ)
# index 1 : ring (nhẫn)
# index 2 : necklace (vòng cổ)
# index 3 : weapon (vũ khí)
# index 4 : weapon (vũ khí)
# index 5 : armor1 (giáp thân)
# index 6 : armor2 (giáp)
# index 7 : gloves (găng tay)
# index 8 : boots (giày)

func _init() -> void:
	equipped_items.resize(9)
	for i in range(equipped_items.size()):
		equipped_items[i] = null

func add_to_inventory(object):
	if object is Items:
		add_item(object)
	elif object is Equipments:
		add_equipmet(object)
	elif object is Gems:
		add_material(object)
	elif object is Story_items:
		add_story_item(object)
	elif object is Others:
		add_other(object)
	else:
		print("Unkown this Obj")

func add_equipmet(equipment : Equipments):
	self.equipments.append(equipment)

func add_item(item : Items):
	self.items.append(item)

func add_material(material : Materials):
	self.materials.append(material)

func add_story_item(story_team : Story_items):
	self.story_items.append(story_team)

func add_other(other : Others):
	self.others.append(other)
