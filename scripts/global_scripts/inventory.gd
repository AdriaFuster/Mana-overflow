extends Node


var upgrades: Dictionary = {}
var augments: Dictionary = {}

var location = ResourceManager.LOCATION.INVENTORY

func _init() -> void:
	add_augment("Growing leaf")
	#add_augment("Mana potion")
	#add_augment("augment3")
	add_augment("Mighty force")
	add_augment("Cauldron dogma")
	
	add_upgrade("upgrade1")
	add_upgrade("upgrade2")
	
	TickManager.register(self, 1)
	
	
#AUGMENTS
func add_augment(a_name: String) -> void:
	if !augments.has(a_name):
		var a: Augment = ResourceManager.get_augment(a_name, location)
		if a != null:
			augments[a_name] = a
			print("afegim augment ", a_name)
			a.on_equip()
			GameEvents.inventory_changed.emit()
	
func get_n_augments(type: GlobalEnum.AugmentType) -> int:
	var cont: int = 0
	for a_name in augments.keys():
		var a: Augment = augments[a_name]
		if a.type == type:
			cont += 1
	
	return cont


#UPGRADES
func add_upgrade(u_name: String) -> void:
	if !upgrades.has(u_name):
		var u: Upgrade = ResourceManager.get_upgrade(u_name, location)
		if u != null:
			upgrades[u_name] = u
			print("afegim upgrade ", u_name)
			GameEvents.inventory_changed.emit()


func _on_tick_permanent_a() -> void:
	for a_name:String in augments.keys():
		var a: Augment = augments[a_name]
		if a is PermanentAugment:
			a.tick()

func _on_tick_tick_a() -> void:
	for a_name:String in augments.keys():
		var a: Augment = augments[a_name]
		if a is TickAugment:
			a.tick()
	
	
	
	
	
	
