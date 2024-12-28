extends Effects

class_name IncreaseHpEffect

var percentage: float

func _init(_percentage = 0.1):
	super._init("Increase HP")
	percentage = _percentage

func active(target):
	var increase_amount = int(target.hp * percentage)
	target.increaseHp(increase_amount)

func deactivate(target): 
	# Không cần làm gì khi hiệu ứng kết thúc 
	pass
