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

func equip_equipment(equipment : Equipments):
	if equipment.type == "weapon":
		if equipped_items[3] == null:
			equipped_items[3] = equipment
			equipments.erase(equipment)
			print("Equipped in slot 3: ", equipment)
		elif equipped_items[4] == null:
			equipped_items[4] = equipment
			equipments.erase(equipment)
			print("Equipped in slot 4: ", equipment)
		else:
			print("Both weapon slots are full. Please unequip one of the weapons to continue.")
	else:
		var index = get_equipment_idex_on_type(equipment)
		if index != -1:
			if equipped_items[index] != null:
				#Chuyển trang bị đang trang bị vào hành trang
				add_equipmet(equipped_items[index])
			#Gắn trang bị mới
			equipped_items[index] = equipment
			#và xóa trang bị mới đó ra khỏi hành trang
			equipments.erase(equipment)
			print("Equipped: ", equipment, " in slot index: ", index)
		else:
			print("Invalid equipment type")

func unequip_equipment(equipment : Equipments):
	pass

func get_equipment_idex_on_type(equipment) -> int:
	match equipment.type:
		"helmet":
			return 0
		"ring":
			return 1
		"necklace":
			return 2
		"weapon":
			return -1 # Xử lí riêng (vì cần logic khi trang bị vũ khí ở 2 tay)
		"armor1":
			return 5
		"armor2":
			return 6
		"gloves":
			return 7
		"boots":
			return 8
		_:
			return -1
