extends Control

export (Array, Resource) var entries: Array  # вставлять ресурсы типа CodexEntry


func _ready():
	for entry in entries:
		$item_list.add_item(entry.name, entry.icon)


func _on_item_list_item_selected(index: int):
	var entry: CodexEntry = entries[index]
	$icon.texture = entry.icon
	$name.text = entry.name
	$description.text = entry.description
	$health.text = str(entry.health)
	$contact_damage.text = str(entry.contact_damage)
