extends Node

class_name Base_Skill

enum TargetType {
	SINGLE_ENEMY,      # Chọn 1 kẻ địch
	SINGLE_ALLY,       # Chọn 1 đồng minh
	MULTIPLE_ENEMIES,  # Chọn nhiều kẻ địch
	MULTIPLE_ALLIES,   # Chọn nhiều đồng minh
	ALL_ENEMIES,       # Tất cả kẻ địch
	ALL_ALLIES,        # Tất cả đồng minh
	SELF,             # Bản thân
}

var skill_name: String
var target_type: TargetType
var max_targets: int = 1  # Số lượng mục tiêu tối đa cho multiple targets
