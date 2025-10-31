extends Node

enum MODIFIER_TYPE {
	MANA,
	MPS
}

var mana = Big.new(0)
var mps = Big.new(100)
var mps_timer: float = 1

#MODIFIERS
var active_modifiers_mps: Dictionary = {}
var active_modifiers_mana: Dictionary = {}


func add_percent_modifier(m_name: String, percent: float, ticks: int, type: MODIFIER_TYPE, permanent: bool = false) -> void:
	var mod = Modifier.new(m_name,
		func(base_gain: Big):
		print("executing percent modifier ",m_name)
		print("multiply by ",percent+1)
		base_gain.multiplyEquals(percent+1), 
		ticks,
		permanent)
		
	if type == MODIFIER_TYPE.MPS:	
		#print("afegim als mps ",Stats.mps.toAmericanName(), " ", percent+1)
		active_modifiers_mps[m_name] = mod
	else:
		#print("afegim al mana ",Stats.mana.toAmericanName(), " ", percent+1)
		active_modifiers_mana[m_name] = mod
		
	
func add_flat_modifier(m_name: String, flat_value: float, ticks: int, type: MODIFIER_TYPE, permanent: bool = false) -> void:
	var mod = Modifier.new(m_name, 
		func(base_gain: Big):
		print("executing flat modifier ",m_name)
		print("sum by ",flat_value)
		base_gain.plusEquals(flat_value), 
		ticks,
		permanent)
	
	if type == MODIFIER_TYPE.MPS:	
		active_modifiers_mps[m_name] = mod
	else:
		active_modifiers_mana[m_name] = mod
	
	
func remove_modifier(m_name: String, type: MODIFIER_TYPE) -> void:
	if type == MODIFIER_TYPE.MPS:	
		active_modifiers_mps.erase(m_name)
	else:
		active_modifiers_mana.erase(m_name)
	
	
#UPGRADES
var upgrades: Dictionary = {}

#func get_upgrade_amount(upgrade: Upgrade) -> int:
	#if upgrades.has(upgrade):
		#return upgrades[upgrade]
	#return 0
#
#func add_upgrade(upgrade: Upgrade, amount: int = 1):
	#upgrades[upgrade] = get_upgrade_amount(upgrade) + amount
	
