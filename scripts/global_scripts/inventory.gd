extends Node


var upgrades: Dictionary = {}
var augments: Dictionary = {}

var location = ResourceManager.LOCATION.INVENTORY

func _init() -> void:
	add_augment("augment1")
	add_augment("augment2")
	add_augment("augment3")
	add_augment("augment4")
	add_upgrade("upgrade1")
	add_upgrade("upgrade2")
	
	GameTick.tick.connect(_on_tick)
	
	
#AUGMENTS
func add_augment(a_name: String) -> void:
	if !augments.has(a_name):
		var a: Augment = ResourceManager.get_augment(a_name, location)
		if a != null:
			augments[a_name] = a
			print("afegim augment ", a_name)
			a.on_equip()
			GameEvents.inventory_changed.emit()
	
func get_n_augments(type: Augment.AugmentType) -> int:
	var cont: int = 0
	for a_name in augments.keys():
		var a: Augment = augments[a_name]
		if a.type == type:
			cont += 1
	
	return cont

#func remove_augment(a_name: String) -> void:
	#if augments.has(a_name):
		#augments.erase(a_name)
		#ResourceManager.augment_removed(a_name, location)
		#
		#GameEvents.inventory_changed.emit()
	

#UPGRADES
func add_upgrade(u_name: String) -> void:
	if !upgrades.has(u_name):
		var u: Upgrade = ResourceManager.get_upgrade(u_name, location)
		if u != null:
			upgrades[u_name] = u
			print("afegim upgrade ", u_name)
			GameEvents.inventory_changed.emit()


#func remove_upgrade(u_name: String) -> void:
	#if upgrades.has(u_name):
		#upgrades.erase(u_name)
		#
		
func _on_tick() -> void:
	for a_name:String in augments.keys():
		var a: Augment = augments[a_name]
		if a is TickAugment:
			a.tick()
	
	
	
	
	
	
