extends Control

@onready var augment_container: VBoxContainer = $AugmentContainer
@onready var upgrade_container: VBoxContainer = $UpgradeContainer

@export var a_ui_scene: PackedScene
@export var u_ui_scene: PackedScene


func _ready() -> void:
	GameEvents.inventory_changed.connect(_on_inventory_changed)
	_on_inventory_changed()


func _on_inventory_changed() -> void:
	_queue_free_children()
	
	for i_name in Inventory.augments.keys():
		var aug: Augment = Inventory.augments[i_name]
		var aug_ui: AugmentUI = a_ui_scene.instantiate() as AugmentUI
		augment_container.add_child(aug_ui)
		aug_ui.set_icon(aug.icon)
		
	for i_name in Inventory.upgrades.keys():
		var upg: Upgrade = Inventory.upgrades[i_name]
		var upg_ui: UpgradeUI = u_ui_scene.instantiate() as UpgradeUI
		upgrade_container.add_child(upg_ui)
		upg_ui.setup(upg)
		

func _queue_free_children() -> void:
	for c in augment_container.get_children():
		c.queue_free()	
		
	for c in upgrade_container.get_children():
		c.queue_free()
