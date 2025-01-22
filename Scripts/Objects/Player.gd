extends Resource

class_name Player

@export var inventory = Inventory.new()

@export var stats = PlayerStats.new()

@export var GP: int # Đơn vị tiền GP (Gold Point)

@export var all_skill: Array = [Skill1.new(), Skill2.new(), Skill3.new(), Skill4.new(), Skill5.new(), Skill6.new(), Skill7.new()] # tat ca skill cua class
@export var stats_skills = {
	"skill_0": 1,
	"skill_1": 0,
	"skill_2": 0,
	"skill_3": 0,
	"skill_4": 0,
	"skill_5": 0,
	"skill_6": 0
}
@export var learned_skills: Array = [] # skill da hoc	

func add_oject_to_inventory(object):
	if object is Items:
		inventory.add_item(object)
	elif object is Equipments:
		inventory.add_equipmet(object)
	elif object is Gems:
		inventory.add_material(object)
	elif object is Story_items:
		inventory.add_story_item(object)
	else:
		inventory.add_other(object)

func equip_equipment(equipment: Equipments):
	inventory.equip_equipment(equipment)

func unequip_equipment(equipment: Equipments):
	inventory.unequip_equipment(equipment)

func add_equipment_stats_to_player():
	for equipment in inventory.equipped_items:
		if equipment != null:
			for stat in equipment.stats.keys():
				match stat:
					"hp":
						stats.total_hp += equipment.stats[stat]
					"mana":
						stats.total_mana += equipment.stats[stat]
					"atk_phys":
						stats.total_atk_phys += equipment.stats[stat]
					"atk_spec":
						stats.total_atk_spec += equipment.stats[stat]
					"spd":
						stats.total_spd += equipment.stats[stat]
					"def_phys":
						stats.total_def_phys += equipment.stats[stat]
					"def_spec":
						stats.total_def_spec += equipment.stats[stat]
