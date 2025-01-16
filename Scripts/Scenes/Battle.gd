extends Node2D

var current_skill: Base_Skill = null
var selected_targets: Array = []
var max_selections: int = 1

#@onready var skill_container = $SkillContainer
#@onready var enemy_container = $EnemyContainer
#@onready var ally_container = $AllyContainer

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
