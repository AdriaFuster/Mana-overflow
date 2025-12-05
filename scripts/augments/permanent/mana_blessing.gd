extends PermanentAugment
class_name ManaBlessing

@export var refund: float = 0.05
	

func on_equip() -> void:
	super.on_equip()
	GameEvents.deduce_mana.connect(_on_mana_spended)


func _on_mana_spended(mana_cost: float) -> void:
	var refunded_mana: float = mana_cost
	refunded_mana *= refund
	#print("fem refund de ", refunded_mana.toAmericanName())
	Stats.add_mana(refunded_mana)
	
func _augment_efect() -> void:
	pass
	
func enhance() -> void:
	enhanced = true
	refund = 0.1
	d_replacements["REFUND_P"][1] = true
	super.enhance()
	
