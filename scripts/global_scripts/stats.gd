extends Node

var mana = Big.new(0)
var mps = Big.new(0)
var mps_timer: float = 1

#UPGRADES
var upgrades: Dictionary = {}

func get_upgrade_amount(upgrade: Upgrade) -> int:
	if upgrades.has(upgrade):
		return upgrades[upgrade]
	return 0

func add_upgrade(upgrade: Upgrade, amount: int = 1):
	upgrades[upgrade] = get_upgrade_amount(upgrade) + amount
	
