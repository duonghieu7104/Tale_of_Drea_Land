extends Node

class_name CharacterManager

func add_char(_Character : CharacterBase):
	Globals.player.all_characters.append(_Character)

func get_char_by_name(_name : String) -> CharacterBase:
	for character in Globals.player.all_characters:
		if character.name == _name:
			return character
	return null

func gain_exp(_char : CharacterBase, amount : int):
	_char.gain_exp(amount)

func show_stat_progression(stat_name: String, start_level: int = 1, end_level: int = 10):
	Globals.player.show_stat_progression(stat_name, start_level, end_level)

func calculate_stats(_char : CharacterBase, level: int) -> Dictionary:
	return _char.calculate_stats(level)

func get_current_stats(_char : CharacterBase, level: int) -> Dictionary:
	return _char.get_current_stats(level)

func get_skill(_char : CharacterBase) -> Array:
	return _char.skills
