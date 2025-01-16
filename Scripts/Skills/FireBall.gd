extends Base_Skill

class_name FireBall

func _init() -> void:
	name = "FireBall"
	target_type = TargetType.SINGLE_ENEMY

func active(target: Array):
	if target.size() > 0:
		pass
		#get_damage
