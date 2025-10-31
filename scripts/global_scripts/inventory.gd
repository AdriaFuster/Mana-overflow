extends Node


var upgrades: Dictionary = {}
var augments: Dictionary = {}

var location = AugmentManager.AUGMENT_LOCATION.INVENTORY

func _init() -> void:
	add_augment("augment1")
	add_augment("augment2")
	
	GameTick.tick.connect(_on_tick)
	
	
#AUGMENTS
func add_augment(a_name: String) -> void:
	if !augments.has(a_name):
		var a: Augment = AugmentManager.get_augment(a_name, location)
		if a != null:
			augments[a_name] = a
			print("afegim augment ", a_name)
			a.augment_efect()
			GameEvents.inventory_changed.emit()
	


func remove_augment(a_name: String) -> void:
	if augments.has(a_name):
		augments.erase(a_name)
		AugmentManager.augment_removed(a_name, location)
		
		GameEvents.inventory_changed.emit()
	
func _on_tick() -> void:
	for a_name:String in augments.keys():
		var a: Augment = augments[a_name]
		a.tick()

#UPGRADES
func add_upgrade(u_name: String, upgrade: Upgrade) -> void:
	if !upgrades.has(u_name):
		upgrades[u_name] = upgrade


func remove_upgrade(u_name: String) -> void:
	if upgrades.has(u_name):
		upgrades.erase(u_name)
		
		

	
	
	
	
	
	
