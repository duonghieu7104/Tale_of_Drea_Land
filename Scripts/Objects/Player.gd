extends Resource

class_name Player

@export var class_player : String
# 1. Guardian: Vật lí Def cao, phòng thủ phản đòn, chậm chạp.
# 2. Assassin: Nhanh nhẹn nhất, sát thương vật lí dựa vào tốc độ để ra đòn nhanh.
# 3. Mage: Máu ít, sát thương phép.
# 4. Berserker: Chậm vừa, sát thương vật lí cực cao.
# 5. Paladin: Kết hợp giữa phòng thủ và hồi máu, có khả năng bảo vệ đồng đội.
# 6. Ranger: Sử dụng cung tên hoặc vũ khí tầm xa, nhanh nhẹn và linh hoạt.
# 7. Warlock: Sử dụng phép thuật hắc ám, có khả năng triệu hồi và gây sát thương theo thời gian.
# 8. Druid: Sử dụng phép thuật tự nhiên, có khả năng biến hình và hồi máu.
# 9. Monk: Sử dụng võ thuật, nhanh nhẹn và có khả năng né tránh cao.

@export var inventory = Inventory.new()

@export var stats = PlayerStats.new()

func add_oject_to_inventory(object):
	if object is Items :
		inventory.add_item(object)
	elif object is Equipments :
		inventory.add_equipmet(object)
	elif object is Materials :
		inventory.add_material(object)
	elif object is Story_items :
		inventory.add_story_item(object)
	else :
		inventory.add_other(object)

func equip_equipment(equipment : Equipments):
	inventory.equip_equipment(equipment)

func unequip_equipment(equipment : Equipments):
	inventory.unequip_equipment(equipment)

func add_equipment_stats_to_player():
	for equipment in inventory.equipped_items:
		if equipment != null:
			for stat in equipment.stats.keys():
				match stat:
					"hp":
						stats.base_hp += equipment.stats[stat]
					"mana":
						stats.base_mana += equipment.stats[stat]
					"atk_phys":
						stats.base_atk_phys += equipment.stats[stat]
					"atk_spec":
						stats.base_atk_spec += equipment.stats[stat]
					"spd":
						stats.base_spd += equipment.stats[stat]
					"def_phys":
						stats.base_def_phys += equipment.stats[stat]
					"def_spec":
						stats.base_def_spec += equipment.stats[stat]
