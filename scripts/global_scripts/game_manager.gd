extends Node

var optional_add_mana = Big.new(0)

func _ready() -> void:
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	GameEvents.calculate_mps.connect(_on_calculate_mps)
		

func reset_mod_values() -> void:
	Stats.mod_cauldron_power = Stats.cauldron_power
	Stats.mod_mps = Big.new(Stats.mps)

func calculate_cauldron_modifiers() -> void:
	Stats.mod_cauldron_power = Stats.cauldron_power
	
	for m_name in Stats.cauldron_modifiers.keys():
		Stats.mod_cauldron_power += Stats.cauldron_modifiers[m_name]
		
	_delete_mod(Stats.cauldron_modifiers)

func calculate_permanent_modifiers() -> void:
	Stats.mod_mps = Big.new(Stats.mps)
	
	for m_name in Stats.permanent_modifiers_mps.keys():
		Stats.mod_mps.plusEquals(Stats.permanent_modifiers_mps[m_name]as Big)
		#print("permanent mod ",Stats.permanent_modifiers_mps[m_name].toAmericanName())

	#print ("mod_mps ",Stats.mod_mps.toAmericanName())

	_delete_mod(Stats.permanent_modifiers_mps)
	
func calculate_tick_modifiers():
	var tick_mps = Big.new(Stats.mod_mps)
	
	#tick mps
	tick_mps.multiplyEquals(GameTick.tick_interval)
	
	var final_mps := Big.new(tick_mps)
	
	#Add tick modifiers
	for m_name in Stats.tick_modifiers_mps.keys():
		final_mps.plusEquals(Stats.tick_modifiers_mps[m_name]as Big)
	
	_delete_mod(Stats.tick_modifiers_mps)
	
	Stats.mana.plusEquals(final_mps)
	
	

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
