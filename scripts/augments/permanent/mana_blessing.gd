extends PermanentAugment
class_name ManaBlessing

@export var refund: float
@export var enhanced_refund: float
var _current_refund: float
	
func setup() -> void:
	_current_refund = refund
	super.setup()

func on_equip() -> void:
	GameEvents.deduce_mana.connect(_on_mana_spended)
	super.on_equip()
	
func setup_description() -> void:
	description_replacements["ARG1P"].variable = "refund"
	description_replacements["ARG1P"].enhanced_variable = "enhanced_refund"

func _on_mana_spended(mana_cost: float) -> void:
	var refunded_mana: float = mana_cost
	refunded_mana *= _current_refund
	#print("fem refund de ", refunded_mana.toAmericanName())
	Stats.add_mana(refunded_mana)

	
func enhance() -> void:
	enhanced = true
	_current_refund = enhanced_refund
	description_replacements["ARG1P"].enhanced = true
	super.enhance()
	
