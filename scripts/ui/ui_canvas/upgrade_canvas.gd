extends CanvasLayer


@onready var upgrade_container: PanelContainer = %UpgradeContainer
@onready var upgrade_list: VBoxContainer = %UpgradeList


@export var u_ui_scene: PackedScene


func _ready() -> void:
	_setup_upgrades_ui()
	_load_upgrades()

func _setup_upgrades_ui() -> void:
	#Coloquem les upgrades
	var ui_scene: Control = u_ui_scene.instantiate()
	var ui_scene_size: Vector2 = ui_scene.custom_minimum_size
	#Upgrade inventory
	
	#upgrade_inventory.custom_minimum_size.x = ui_scene_size.x
	upgrade_container.custom_minimum_size.y = ui_scene_size.y * 5
	upgrade_container.size.y = upgrade_container.custom_minimum_size.y
	#Upgrade container
	#upgrade_container.size.x = ui_scene_size.x
	#upgrade_container.size.y = ui_scene_size.y * 4
	#upgrade_background.position.x = positions

func _load_upgrades() -> void:
	_queue_free_children()
	
	for c in range(1,Inventory.upgrades.size() + 1):
		for i_name in Inventory.upgrades.keys():
			var upg: Upgrade = Inventory.upgrades[i_name]
			if upg.order == c:
				var upg_ui: UpgradeUI = u_ui_scene.instantiate() as UpgradeUI
				upgrade_list.add_child(upg_ui)
				upg_ui.setup(upg)
				upg_ui.mouse_filter = Control.MOUSE_FILTER_PASS
		

func _queue_free_children() -> void:
	for c in upgrade_list.get_children():
			c.queue_free()
			
func show_upgrade_ui(ui_show: bool) -> void:
	if ui_show:
		upgrade_container.show()
	else:
		upgrade_container.hide()
	
