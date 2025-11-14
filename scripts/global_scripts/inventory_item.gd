extends Resource
class_name InventoryItem

@export var name: String
@export_multiline var description: String
@export var locked: bool = false

var locked_name: String = "????"
var locked_description: String = "??????"
