extends NinePatchRect

const green_texture = preload("res://assets/green_panel.png")

@onready var level_label = $LevelLabel
@onready var check_mark = $CheckMark

var _level_number: String = "2"

func _ready():
	level_label.text = _level_number


func _process(delta):
	pass


func set_level_number(level_number: String) -> void:
	_level_number = level_number


func _on_gui_input(event: InputEvent):
	if (event.is_action_pressed("select")):
		texture = green_texture
		SignalManager.on_level_selected.emit(_level_number)





