@tool
extends Control
class_name CompositeEdit

const RunConfig := preload("res://addons/run-configs/models/run_config.gd")

@onready var grid_container: GridContainer = $GridContainer
@onready var add_item_btn: Button = $BtnContainer/AddConfig
@onready var del_item_btn: Button = $BtnContainer/DelConfig

signal changed(envs: Array[int])

var _all_configs: Array[RunConfig]

func _ready():
	add_item_btn.pressed.connect(_add_item)
	del_item_btn.pressed.connect(_del_item)

func render(composite_configs: Array[StringName], all_configs: Array[RunConfig]):
	del_item_btn.disabled = composite_configs.size() <= 0
	_all_configs = all_configs

	for child in grid_container.get_children():
		child.queue_free()

	for item in composite_configs:
		var opt = create_option(item)

func create_option(cur_name: StringName = "") -> OptionButton:
	var option = OptionButton.new()

	var index = 0
	for c in _all_configs:
		if c.play_mode != RunConfig.PlayMode.Composite:
			option.add_item(c.name)
		if index >= 0 and index < option.item_count and cur_name == option.get_item_text(index):
			option.select(index)
		index += 1

	option.item_selected.connect(_on_item_selected)
	grid_container.add_child(option)
	return option

func _emit_changes():
	var new_configs: Array[StringName] = []
	for child in grid_container.get_children():
		new_configs.append(child.get_item_text(child.selected))
	changed.emit(new_configs)

func _add_item():
	create_option()
	_emit_changes()

func _del_item():
	var children = grid_container.get_children()
	if children.size() <= 0: return 

	children[children.size() - 1].queue_free()
	_emit_changes()

func _on_item_selected(id):
	_emit_changes()
