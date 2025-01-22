extends Control

@onready var btn_skill_1 = $VBoxContainer/step1/skill_0
@onready var btn_skill_2 = $VBoxContainer/step2/skill_1
@onready var btn_skill_3 = $VBoxContainer/step2/skill_2
@onready var btn_skill_4 = $VBoxContainer/step3/skill_3
@onready var btn_skill_5 = $VBoxContainer/step3/skill_4
@onready var btn_skill_6 = $VBoxContainer/step4/skill_5
@onready var btn_skill_7 = $VBoxContainer/step4/skill_6

@onready var v_step_2 = $tree/HBoxContainer2/ProgressBar
@onready var v_step_3 = $tree/HBoxContainer3/ProgressBar
@onready var v_step_4 = $tree/HBoxContainer4/ProgressBar

@onready var h_step_2_l = $tree2/HBoxContainer2/VBoxContainer/ProgressBar
@onready var h_step_2_r = $tree2/HBoxContainer2/VBoxContainer2/ProgressBar

@onready var h_step_3_l = $tree2/HBoxContainer3/VBoxContainer/ProgressBar
@onready var h_step_3_r = $tree2/HBoxContainer3/VBoxContainer2/ProgressBar

@onready var h_step_4_l = $tree2/HBoxContainer4/VBoxContainer/ProgressBar
@onready var h_step_4_r = $tree2/HBoxContainer4/VBoxContainer2/ProgressBar

@onready var description_skill = $VBoxContainer/description

@onready var btn_yes = $VBoxContainer/HBoxContainer/yes
@onready var btn_no = $VBoxContainer/HBoxContainer/no

@onready var shader = ResourceLoader.load("res://Shader/blackwhite.gdshader") as Shader

var selected_skill = ""
var selected_opposing_skill = ""

func _ready():

	var shader_material = ShaderMaterial.new() 
	shader_material.shader = shader 


	setup_connections()
	load_texture()
	load_ui()

func setup_connections():
	var buttons = get_tree().get_nodes_in_group("btn_skill")
	for button in buttons:
		button.connect("pressed", Callable(self, "on_skill_pressed").bind(button))

func on_skill_pressed(button):
	var idx = get_index_btn(button)
	print("Pressed: " + str(idx) + " " + str(button.name))
	show_description_skill(button)

	if Globals.player.stats_skills[button.name] == 1 or Globals.player.stats_skills[button.name] == -1:
		return
	else :
		selected_skill = button.name
		selected_opposing_skill = get_opposing_skill(button)
		$VBoxContainer/HBoxContainer.visible = true

func get_opposing_skill(button):
	match button.name:
		"skill_0":
			return -1
		"skill_1":
			return "skill_2"
		"skill_2":
			return "skill_1"
		"skill_3":
			return "skill_4"
		"skill_4":
			return "skill_3"
		"skill_5":
			return "skill_6"
		"skill_6":
			return "skill_5"

func get_index_btn(button):
	match button.name:
		"skill_0":
			return 0
		"skill_1":
			return 1
		"skill_2":
			return 2
		"skill_3":
			return 3
		"skill_4":
			return 4
		"skill_5":
			return 5
		"skill_6":
			return 6

func load_ui():

	load_shader()

	# Update vertical progress based on level
	if Globals.player.stats.level >= 10:  # Tầng 2
		v_step_2.value = 65
	if Globals.player.stats.level >= 20:  # Tầng 3
		v_step_2.value = 100
		v_step_3.value = 65
	if Globals.player.stats.level >= 50:  # Tầng 4
		v_step_2.value = 100
		v_step_3.value = 100
		v_step_4.value = 100
	
	update_horizontal_bars()

func update_horizontal_bars() -> void:
	# Tầng 2
	if Globals.player.stats_skills["skill_1"] == 1:
		h_step_2_l.value = 100
		h_step_2_r.value = 0
	if Globals.player.stats_skills["skill_2"] == 1:
		h_step_2_r.value = 100
		h_step_2_l.value = 0
		
	# Tầng 3
	if Globals.player.stats_skills["skill_3"] == 1:
		h_step_3_l.value = 100
		h_step_3_r.value = 0
	if Globals.player.stats_skills["skill_4"] == 1:
		h_step_3_r.value = 100
		h_step_3_l.value = 0
		
	# Tầng 4
	if Globals.player.stats_skills["skill_5"] == 1:
		h_step_4_l.value = 100
		h_step_4_r.value = 0
	if Globals.player.stats_skills["skill_6"] == 1:
		h_step_4_r.value = 100
		h_step_4_l.value = 0

func load_shader():
	var buttons = get_tree().get_nodes_in_group("btn_skill")
	for button in buttons:
		if Globals.player.stats_skills[button.name] < 1:
			var shader_material = ShaderMaterial.new()
			shader_material.shader = shader
			button.material = shader_material
		else:
			button.material = null


func load_texture():
	var buttons = get_tree().get_nodes_in_group("btn_skill")
	for i in range(buttons.size()):
		var path : String = Globals.player.all_skill[i].texture_path
		buttons[i].texture_normal = load(path)

func show_description_skill(button):
	print("Show description: " + str(button.name))
	var idx = get_index_btn(button)
	var skill = Globals.player.all_skill[idx]
	description_skill.text = skill.description


func _on_no_pressed() -> void:
	$VBoxContainer/HBoxContainer.visible = false
	selected_skill = ""
	selected_opposing_skill = ""


func _on_yes_pressed() -> void:
	Globals.player.stats_skills[selected_skill] = 1
	Globals.player.stats_skills[selected_opposing_skill] = -1
	update_learned_skills()
	load_ui()
	$VBoxContainer/HBoxContainer.visible = false

func update_learned_skills() -> void:
	 # Clear mảng learned_skills để tránh trùng lặp
	Globals.player.learned_skills.clear()
	# Kiểm tra từng skill trong stats_skills
	for i in range(0, 7):  # từ skill_1 đến skill_7
		var skill_key = "skill_" + str(i)
		# Nếu giá trị là 1 (đã học), thêm vào learned_skills
		if Globals.player.stats_skills[skill_key] == 1:
			Globals.player.learned_skills.append(Globals.player.all_skill[i-1])
