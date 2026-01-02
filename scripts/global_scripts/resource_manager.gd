extends Node

var augments: Dictionary = {}
const  AUGMENTS_DIR: String = "res://resources/augment/"

var upgrades: Dictionary = {}
const  UPGRADES_DIR: String = "res://resources/upgrade/"

var rewards: Dictionary = {}
const  REWARDS_DIR: String = "res://resources/reward/"

enum RESOURCE_TYPE{
	AUGMENT,
	UPGRADE
}

class ResourceEntry:
	var resource: InventoryItem
	var location: GlobalEnum.LOCATION
	var type: RESOURCE_TYPE
	
	func _init(r: InventoryItem, l: GlobalEnum.LOCATION, t:RESOURCE_TYPE) -> void:
		resource = r
		location = l
		type = t
		


func _init() -> void:
	_load_augments()
	_load_upgrades()
	_load_rewards()
	#for d_key: String in augments.keys():
		#var augment: Augment = augments[d_key].augment
		#print(augment.name)

func get_augment(a_name: String, loc: GlobalEnum.LOCATION) -> ResourceEntry:
	if augments.has(a_name) and augments[a_name].location != loc and augments[a_name].type == RESOURCE_TYPE.AUGMENT:
		return augments[a_name]
	print_debug("No s'ha trobat l'augment ", a_name, " al AugmentManager o ja esta a la location demanada")
	return null
	
func get_upgrade(u_name: String, loc: GlobalEnum.LOCATION) -> Upgrade:
	if upgrades.has(u_name) and upgrades[u_name].location != loc and upgrades[u_name].type == RESOURCE_TYPE.UPGRADE:
		return upgrades[u_name].resource
	print_debug("No s'ha trobat l'upgrade ", u_name, " al UpgradeManager o ja esta a la location demanada")
	return null

func set_augment_location(a_name: String, loc: GlobalEnum.LOCATION) -> void:
	augments[a_name].location = loc

func get_augment_location(a_name: String) -> GlobalEnum.LOCATION:
	return augments[a_name].location

func set_upgrade_location(u_name: String, loc: GlobalEnum.LOCATION) -> void:
	upgrades[u_name].location = loc
	
	
func _load_augments() -> void:
	var dir = DirAccess.open(AUGMENTS_DIR)
	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var augment_entry: ResourceEntry = ResourceEntry.new(load(AUGMENTS_DIR + file), GlobalEnum.LOCATION.MANAGER, RESOURCE_TYPE.AUGMENT) 
				augment_entry.resource.setup()
				augments[augment_entry.resource.name] = augment_entry


func _load_upgrades() -> void:
	var dir = DirAccess.open(UPGRADES_DIR)
	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var upgrade_entry: ResourceEntry = ResourceEntry.new(load(UPGRADES_DIR + file), GlobalEnum.LOCATION.MANAGER, RESOURCE_TYPE.UPGRADE) 
				upgrade_entry.resource.setup()
				upgrades[upgrade_entry.resource.name] = upgrade_entry

func _load_rewards() -> void:
	var dir = DirAccess.open(REWARDS_DIR)
	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var reward: Reward = load(REWARDS_DIR + file)
				reward.setup()
				rewards[reward.name] = reward
