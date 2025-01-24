extends Node

class_name EquipmentManager

signal equipment_changed(slot_index, item)

var inventory = Globals.player.inventory
var equipped_items = Globals.player.inventory.equipped_items

func setup(inv: Inventory):
	inventory = inv

func equip_item(item, slot_index: int) -> bool:
	if not is_valid_slot(slot_index):
		return false
	if not can_equip_in_slot(item, slot_index):
		return false
		
	# Nếu slot đã có item, unequip trước
	if equipped_items[slot_index]:
		unequip_item(slot_index)
		
	equipped_items[slot_index] = item
	inventory.remove_item(item, "equipment")
	equipment_changed.emit(slot_index, item)
	return true

func unequip_item(slot_index: int) -> bool:
	if not is_valid_slot(slot_index) or not equipped_items[slot_index]:
		return false
		
	var item = equipped_items[slot_index]
	equipped_items[slot_index] = null
	inventory.add_item(item)
	equipment_changed.emit(slot_index, null)
	return true

func is_valid_slot(slot_index: int) -> bool:
	return slot_index >= 0 and slot_index < equipped_items.size()

func can_equip_in_slot(item, slot_index: int) -> bool:
	# Logic kiểm tra type của item có phù hợp với slot không
	match slot_index:
		0: return item.type == "helmet"
		1: return item.type == "ring"
		2: return item.type == "necklace"
		3, 4: return item.type == "weapon"
		5, 6: return item.type == "armor"
		7: return item.type == "gloves"
		8: return item.type == "boots"
	return false

func get_equipped_item(slot_index: int):
	if is_valid_slot(slot_index):
		return equipped_items[slot_index]
	return null
