extends Node

const level_scene: PackedScene = preload("res://level/level.tscn")
const main_scene: PackedScene = preload("res://main/main.tscn")

var _level_selected: String

func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)


func get_level_selected() -> String:
	return _level_selected


func on_level_selected(level_number: String) -> void:
	_level_selected = level_number
	get_tree().change_scene_to_packed(level_scene)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)



