extends Node


var mana: float = 0
var mps: float = 370
var mps_timer: float = 1

#UPGRADES
var upgrades: Dictionary = {}

func get_upgrade_amount(upgrade_name: String) -> int:
	if upgrades.has(upgrade_name):
		return upgrades[upgrade_name]
	return 0

func add_upgrade(upgrade_name: String, amount: int = 1):
	upgrades[upgrade_name] = get_upgrade_amount(upgrade_name) + amount
	
