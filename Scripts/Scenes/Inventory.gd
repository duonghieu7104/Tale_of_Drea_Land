extends Control

@onready var equipment_tab = %Equipment
@onready var item_tab = %Item
@onready var material_tab = %Material
@onready var storyitem_tab = %StoryItem
@onready var other_tab = %Other

@onready var equipment_tb = $HBoxContainer/Equipment
@onready var item_tb = $HBoxContainer/Item
@onready var material_tb = $HBoxContainer/Marterial
@onready var storyitem_tb = $HBoxContainer/StorytItem
@onready var other_tb = $HBoxContainer/Other

@onready var equipments_ui = $PanelContainer/Equipment/Grid

var slot = preload("res://UI/InventorySlot.tscn")

var saveload = SaveLoad.new()



func _ready() -> void:
	saveload.load_data() #load data nhanh, dành cho việc test
	
	setup_connections() #setup connect signal tab menu (Equipment, Item,...)
	
	update_ui_equipment()
	
	$PanelContainer/Equipment.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)
	$PanelContainer/Item.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)
	$PanelContainer/Material.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)
	$PanelContainer/StoryItem.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)
	$PanelContainer/Other.get_v_scroll_bar().modulate = Color(0, 0, 0, 0)

func setup_connections():
	var touch_areas = get_tree().get_nodes_in_group("touch_screen_button")
	for area in touch_areas:
		area.connect("pressed", Callable(self, "on_touch_area_pressed").bind(area))

func on_touch_area_pressed(TouchArea):
	print("touch area: " + str(TouchArea.name))

func update_ui_equipment():
	if equipments_ui.get_child_count() > 0:
		var children = equipments_ui.get_children()
		for c in children:
			equipments_ui.remove_child(c)
			c.queue_free()
	var equipments = Globals.player.inventory.equipments
	for equipment in equipments:
		var instantiate = slot.instantiate()
		instantiate.load_ui_object(equipment)
		equipments_ui.add_child(instantiate)
