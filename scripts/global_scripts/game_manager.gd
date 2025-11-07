extends Node

var optional_add_mana = Big.new(0)

func _ready() -> void:
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	GameEvents.calculate_mps.connect(_on_calculate_mps)
	
	GameTick.tick.connect(_on_tick)	
	
func _on_tick():
	#ADD MODIFIERS TO MPS
	var mps_modified = Big.new(_add_modifiers_mps())
	Stats.mana.plusEquals(mps_modified)	
	
	
	#ADD MODIFIERS TO MANA
	#var mana_modified = Big.new(_add_modifiers_mana())
	#Stats.mana.plusEquals(mana_modified)	

	
func _add_modifiers_mana() -> Big:
	var total_gain = Big.new(0)
	
	for m_name in Stats.active_modifiers_mana.keys():
		var mod: Modifier = Stats.active_modifiers_mana[m_name]
		mod.function.call(total_gain)
		if !mod.permanent:
			mod.ticks_remaining -= 1
	
	return total_gain

func _add_modifiers_mps() -> Big:
	var total_gain = Big.new(Stats.mps)
	for m_name in Stats.active_modifiers_mps.keys():
		total_gain.plusEquals(Stats.active_modifiers_mps[m_name]as Big)
	
	_delete_mod(Stats.active_modifiers_mps)
	
	return total_gain

func _delete_mod(d: Dictionary) -> void:
	
	for m_name in d.duplicate():
		d.erase(m_name)


func _on_add_mana(mana_add: float):
	Stats.mana.plusEquals(mana_add)
	
func _on_deduced_mana(mana_deduced: float):
	Stats.mana.minusEquals(mana_deduced)

	
func _on_calculate_mps() -> void:
	var total_mps: Big = Big.new(0)
	
	for u_name:String in Inventory.upgrades.keys():
		var u: Upgrade = Inventory.upgrades[u_name]
		total_mps.plusEquals(u.mps*u.amount)
	
	Stats.mps = Big.new(total_mps)
