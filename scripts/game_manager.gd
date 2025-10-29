extends Control

@onready var mana_label: Label = %Mana
@onready var mps_label: Label = %MPS


func _ready() -> void:
	GameEvents.add_mana.connect(_on_add_mana)
	GameEvents.deduce_mana.connect(_on_deduced_mana)
	GameEvents.calculate_mps.connect(_on_calculate_mps)
	
	GameTick.tick.connect(_on_tick)	
	

func _process(delta: float) -> void:
	var amount = Stats.mps.multiply(delta)
	Stats.mana.plusEquals(amount)
	

func _display_values():
	mana_label.text = "Mana = " + Stats.mana.toAmericanName(true)
	mps_label.text = "MPS = " + Stats.mps.toAmericanName()
	
	
func _on_tick():
	_display_values()	
	
	
func _on_add_mana(mana_add: float):
	Stats.mana.plusEquals(mana_add)
	
func _on_deduced_mana(mana_deduced: float):
	Stats.mana.minusEquals(mana_deduced)
	print(Stats.mana.toAmericanName())
	
func _on_calculate_mps() -> void:
	var total_mps: float = 0
	
	for u:Upgrade in Stats.upgrades:
		total_mps += u.upgrade_res.mps * Stats.get_upgrade_amount(u)	
	
	Stats.mps = Big.new(total_mps)
