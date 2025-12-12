extends Node


var shop_menu_scene: PackedScene = preload("uid://bt6o07o4c605o")
var shop_menu :ShopMenu

var augments: Dictionary

var location = GlobalEnum.LOCATION.SHOP

var shop_bought: bool = false


func _ready() -> void:
	GameEvents.augment_bought.connect(_on_augment_bought)
	GameEvents.new_upgrade_bought.connect(_on_new_upgrade_bought)
	_setup_ui()	
	update_shop()


func update_shop() -> void:
	augments.clear()
	
	var valid_augments: Dictionary = _get_valid_augments()
	
	var valid_keys = valid_augments.keys()
	valid_keys.shuffle()
	
	var shop_keys = valid_keys.slice(0,3)
	
	for n in shop_keys:
		augments[n] = ResourceManager.augments[n].resource
		ResourceManager.set_augment_location(n, location) 	
	

func _get_valid_augments() -> Dictionary:
	var d: Dictionary
	for r_name in ResourceManager.augments.keys():
		var r: ResourceManager.ResourceEntry = ResourceManager.augments[r_name]
		if r.location != GlobalEnum.LOCATION.INVENTORY:
			d[r.resource.name] = r.resource
			#print("augment disponible per la botiga ",r.resource.name)
	
	return d
	
	
func _setup_ui() -> void:
	shop_menu = shop_menu_scene.instantiate()
	
	var ui_layer = get_tree().root.get_node("Main/SceneManager/CanvasLayer/Game")
	ui_layer.add_child(shop_menu)
	shop_menu.call_deferred("hide_menu")
	
	#GameEvents.augment_bought.connect(_on_augment_bought)

func show_shop() -> void:
	if !shop_bought:
		shop_menu.set_items()
		shop_menu.show_menu()


func hide_shop() -> void:	
	shop_menu.hide_menu()


func _on_augment_bought(a: Augment) -> void:
	Inventory.add_augment(a.name)
	shop_bought = true
	GameEvents.shop_disabled.emit(shop_bought)
	hide_shop()
	

func _on_new_upgrade_bought() -> void:
	shop_bought = false
	GameEvents.shop_disabled.emit(shop_bought)
	update_shop()
	
	
	
