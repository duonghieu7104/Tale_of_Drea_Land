extends Control


@onready var btn_skill_1 = $VBoxContainer/step1/TextureButton
@onready var btn_skill_2 = $VBoxContainer/step2/TextureButton
@onready var btn_skill_3 = $VBoxContainer/step2/TextureButton2
@onready var btn_skill_4 = $VBoxContainer/step3/TextureButton
@onready var btn_skill_5 = $VBoxContainer/step3/TextureButton2
@onready var btn_skill_6 = $VBoxContainer/step4/TextureButton
@onready var btn_skill_7 = $VBoxContainer/step4/TextureButton2

@onready var btn_accept = $VBoxContainer/btn_acpt

@onready var v_step_2 = $tree/HBoxContainer2/ProgressBar
@onready var v_step_3 = $tree/HBoxContainer3/ProgressBar
@onready var v_step_4 = $tree/HBoxContainer4/ProgressBar

@onready var h_step_2_l = $tree2/HBoxContainer2/VBoxContainer/ProgressBar
@onready var h_step_2_r = $tree2/HBoxContainer2/VBoxContainer2/ProgressBar

@onready var h_step_3_l = $tree2/HBoxContainer3/VBoxContainer/ProgressBar
@onready var h_step_3_r = $tree2/HBoxContainer3/VBoxContainer2/ProgressBar

@onready var h_step_4_l = $tree2/HBoxContainer4/VBoxContainer/ProgressBar
@onready var h_step_4_r = $tree2/HBoxContainer4/VBoxContainer2/ProgressBar

@onready var shader = ResourceLoader.load("res://Shader/blackwhite.gdshader") as Shader

var selected_skill = ""
var selected_opposing_skill = ""

func _ready() -> void:
	var shader_material = ShaderMaterial.new() 
	shader_material.shader = shader 
	
	# Kết nối signals cho các nút
	btn_skill_1.connect("pressed", Callable(self, "_on_skill_1_pressed"))
	btn_skill_2.connect("pressed", Callable(self, "_on_skill_2_pressed"))
	btn_skill_3.connect("pressed", Callable(self, "_on_skill_3_pressed"))
	btn_skill_4.connect("pressed", Callable(self, "_on_skill_4_pressed"))
	btn_skill_5.connect("pressed", Callable(self, "_on_skill_5_pressed"))
	btn_skill_6.connect("pressed", Callable(self, "_on_skill_6_pressed"))
	btn_skill_7.connect("pressed", Callable(self, "_on_skill_7_pressed"))	
	
	# Kết nối signal cho button accept
	btn_accept.connect("pressed", Callable(self, "_on_accept_pressed"))

	# Cập nhật trạng thái ban đầu
	update_skill_tree_state()
	
	# Load texture
	load_texture()
	
	# Cập nhật trạng thái UI
	update_ui_state()

func setup_button(button: TextureButton) -> void:
	button.mouse_filter = Control.MOUSE_FILTER_PASS
	button.disabled = false
	button.toggle_mode = false

func update_skill_tree_state() -> void:
	# Cập nhật trạng thái visual và interactable của các nút
	var buttons = {
		btn_skill_1: "skill_1",
		btn_skill_2: "skill_2",
		btn_skill_3: "skill_3",
		btn_skill_4: "skill_4",
		btn_skill_5: "skill_5",
		btn_skill_6: "skill_6",
		btn_skill_7: "skill_7"
	}
	for button in buttons:
		var skill_name = buttons[button]
		var skill_value = Globals.player.stats_skills[skill_name]
		
		# Áp dụng shader cho skills chưa học hoặc bị khóa
		if skill_value <= 0:
			var shader_material = ShaderMaterial.new()
			shader_material.shader = shader
			button.material = shader_material
		else:
			button.material = null
		
		# Cập nhật khả năng tương tác
		button.disabled = not is_skill_available(skill_name)

func is_skill_available(skill_name: String) -> bool:
	# Kiểm tra xem skill có thể học được không
		
	# Kiểm tra level requirement
	match skill_name:
		"skill_2", "skill_3":
			if Globals.player.stats.level < 10:
				return false
		"skill_4", "skill_5":
			if Globals.player.stats.level < 20:
				return false
		"skill_6", "skill_7":
			if Globals.player.stats.level < 50:
				return false
	
	# Kiểm tra skill prerequisites
	match skill_name:
		"skill_2", "skill_3":
			return Globals.player.stats_skills["skill_1"] == 1
		"skill_4", "skill_5":
			return (Globals.player.stats_skills["skill_2"] == 1 or Globals.player.stats_skills["skill_3"] == 1)
		"skill_6", "skill_7":
			return (Globals.player.stats_skills["skill_4"] == 1 or Globals.player.stats_skills["skill_5"] == 1)
	
	return true

func learn_skill(skill_name: String, opposing_skill: String) -> void:
	if is_skill_available(skill_name):
		Globals.player.stats_skills[skill_name] = 1
		Globals.player.stats_skills[opposing_skill] = -1
		update_skill_tree_state()
		update_learned_skills()

# Signal handlers cho các nút
func _on_skill_1_pressed() -> void:
	print("pressed skill 1")
	# Skill 1 đã được mở mặc định
	pass
func _on_skill_2_pressed() -> void:
	print("pressed skill 2")
	selected_skill = "skill_2"
	selected_opposing_skill = "skill_3"
	highlight_selected_skill(btn_skill_2, "skill_2")
	learn_skill("skill_2", "skill_3")
	update_ui_state()

func _on_skill_3_pressed() -> void:
	print("pressed skill 3")
	selected_skill = "skill_3"
	selected_opposing_skill = "skill_2"
	highlight_selected_skill(btn_skill_3, "skill_3")
	learn_skill("skill_3", "skill_2")
	update_ui_state()

func _on_skill_4_pressed() -> void:
	print("pressed skill 4")
	selected_skill = "skill_4"
	selected_opposing_skill = "skill_5"
	highlight_selected_skill(btn_skill_4, "skill_4")
	learn_skill("skill_4", "skill_5")
	update_ui_state()

func _on_skill_5_pressed() -> void:
	print("pressed skill 5")
	selected_skill = "skill_5"
	selected_opposing_skill = "skill_4"
	highlight_selected_skill(btn_skill_5, "skill_5")
	learn_skill("skill_5", "skill_4")
	update_ui_state()

func _on_skill_6_pressed() -> void:
	print("pressed skill 6")
	selected_skill = "skill_6"
	selected_opposing_skill = "skill_7"
	highlight_selected_skill(btn_skill_6, "skill_6")
	learn_skill("skill_6", "skill_7")
	update_ui_state()

func _on_skill_7_pressed() -> void:
	print("pressed skill 7")
	selected_skill = "skill_7"
	selected_opposing_skill = "skill_6"
	highlight_selected_skill(btn_skill_7, "skill_7")
	learn_skill("skill_7", "skill_6")
	update_ui_state()

func highlight_selected_skill(selected_button: TextureButton, skill_name: String) -> void:
	# Chỉ highlight và hiện accept button nếu chưa học skill
	if Globals.player.stats_skills[skill_name] != 1:
		# Reset tất cả buttons về trạng thái bình thường
		for button in [btn_skill_1, btn_skill_2, btn_skill_3, btn_skill_4, btn_skill_5, btn_skill_6, btn_skill_7]:
			button.modulate = Color(1, 1, 1, 1)
		# Highlight button được chọn
		selected_button.modulate = Color(1, 0.8, 0, 1)  # Màu vàng nhạt
		# Hiện button accept
		btn_accept.visible = true
	else:
		# Nếu đã học rồi thì không làm gì cả
		selected_skill = ""
		selected_opposing_skill = ""
		btn_accept.visible = false

func _on_accept_pressed() -> void:
	print("pressed accept")
	if selected_skill != "" and is_skill_available(selected_skill):
		# Cập nhật stats_skills
		Globals.player.stats_skills[selected_skill] = 1
		Globals.player.stats_skills[selected_opposing_skill] = -1
		# Cập nhật UI
		update_skill_tree_state()
		update_learned_skills()
		update_ui_state()
		# Reset selection
		selected_skill = ""
		selected_opposing_skill = ""
		btn_accept.visible = false
		
		# Reset highlight
		for button in [btn_skill_1, btn_skill_2, btn_skill_3, btn_skill_4, 
					  btn_skill_5, btn_skill_6, btn_skill_7]:
			button.modulate = Color(1, 1, 1, 1)

func update_ui_state() -> void:
	# Reset all progress bars
	v_step_2.value = 0
	v_step_3.value = 0
	v_step_4.value = 0
	
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
	
	# Update horizontal progress based on skills
	update_horizontal_bars()

func update_horizontal_bars() -> void:
	# Tầng 2
	if Globals.player.stats_skills["skill_2"] == 1:
		h_step_2_l.value = 100
		h_step_2_r.value = 0
	if Globals.player.stats_skills["skill_3"] == 1:
		h_step_2_r.value = 100
		h_step_2_l.value = 0
		
	# Tầng 3
	if Globals.player.stats_skills["skill_4"] == 1:
		h_step_3_l.value = 100
		h_step_3_r.value = 0
	if Globals.player.stats_skills["skill_5"] == 1:
		h_step_3_r.value = 100
		h_step_3_l.value = 0
		
	# Tầng 4
	if Globals.player.stats_skills["skill_6"] == 1:
		h_step_4_l.value = 100
		h_step_4_r.value = 0
	if Globals.player.stats_skills["skill_7"] == 1:
		h_step_4_r.value = 100
		h_step_4_l.value = 0

func load_texture():
	var path : String = Globals.player.all_skill[0].texture_path
	var texture = load(path)
	btn_skill_1.texture_normal = texture

	path = Globals.player.all_skill[1].texture_path
	texture = load(path)
	btn_skill_2.texture_normal = texture

	path = Globals.player.all_skill[2].texture_path
	texture = load(path)
	btn_skill_3.texture_normal = texture

	path = Globals.player.all_skill[3].texture_path
	texture = load(path)
	btn_skill_4.texture_normal = texture

	path = Globals.player.all_skill[4].texture_path
	texture = load(path)
	btn_skill_5.texture_normal = texture

	path = Globals.player.all_skill[5].texture_path
	texture = load(path)
	btn_skill_6.texture_normal = texture

	path = Globals.player.all_skill[6].texture_path
	texture = load(path)
	btn_skill_7.texture_normal = texture

func update_learned_skills() -> void:
	 # Clear mảng learned_skills để tránh trùng lặp
	Globals.player.learned_skills.clear()
	# Kiểm tra từng skill trong stats_skills
	for i in range(1, 8):  # từ skill_1 đến skill_7
		var skill_key = "skill_" + str(i)
		# Nếu giá trị là 1 (đã học), thêm vào learned_skills
		if Globals.player.stats_skills[skill_key] == 1:
			Globals.player.learned_skills.append(Globals.player.all_skill[i-1])
