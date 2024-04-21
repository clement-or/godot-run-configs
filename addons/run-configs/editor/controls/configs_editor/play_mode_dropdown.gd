@tool
extends OptionButton

@export var tooltips : Array[String]

func _ready():
	clear()
	add_icon_item(get_theme_icon(&"Play", &"EditorIcons"), "Main Scene")
	add_icon_item(get_theme_icon(&"PlayScene", &"EditorIcons"), "Current Scene")
	add_icon_item(get_theme_icon(&"PlayCustom", &"EditorIcons"), "Custom Scene")
	add_icon_item(get_theme_icon(&"Duplicate", &"EditorIcons"), "Multiple Instances")

	item_selected.connect(_on_item_selected)

	select(0)

func _on_item_selected(idx: int):
	tooltip_text = tooltips[idx]
