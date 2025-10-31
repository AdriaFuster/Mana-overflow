extends Node

var optional_add_mana = Big.new(0)

func _ready() -> void:
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	GameEvents.calculate_mps.connect(_on_calculate_mps)
	
	GameTick.tick.connect(_on_tick)	

func _process(_delta: float) -> void:
	pass
	
	
func _on_tick():
	#ADD MODIFIERS TO MPS
	var mps_modified = Big.new(_add_modifiers_mps())
	Stats.mana.plusEquals(mps_modified)	
	
	#ADD MODIFIERS TO MANA
	var mana_modified = Big.new(_add_modifiers_mana())
	Stats.mana.plusEquals(mana_modified)	
	
	
func _add_modifiers_mana() -> Big:
	var total_gain = Big.new(0)
	
	for m_name in Stats.active_modifiers_mana.keys():
		var mod: Modifier = Stats.active_modifiers_mana[m_name]
		mod.function.call(total_gain)
		if !mod.permanent:
			mod.ticks_remaining -= 1
	
	#Delete modifiers with 0 ticks
	_delete_0_ticks_mod(Stats.active_modifiers_mana)
	return total_gain

func _add_modifiers_mps() -> Big:
	var total_gain = Big.new(Stats.mps)
	
	for name in Stats.active_modifiers_mps.keys():
		var mod: Modifier = Stats.active_modifiers_mps[name]
		mod.function.call(total_gain)
		if !mod.permanent:
			mod.ticks_remaining -= 1
	
	#Delete modifiers with 0 ticks
	_delete_0_ticks_mod(Stats.active_modifiers_mps)
	return total_gain

func _delete_0_ticks_mod(d: Dictionary) -> void:
	
	for name in d.duplicate():
		var mod: Modifier = d[name]
		if mod.ticks_remaining <= 0 and !mod.permanent:
			d.erase(name)


func _on_add_mana(mana_add: float):
	Stats.mana.plusEquals(mana_add)
	
func _on_deduced_mana(mana_deduced: float):
	Stats.mana.minusEquals(mana_deduced)

	
func _on_calculate_mps() -> void:
	var total_mps: float = 0
	
	for u:Upgrade in Stats.upgrades:
		total_mps += u.upgrade_res.mps * Stats.get_upgrade_amount(u)	
	
	Stats.mps = Big.new(total_mps)
