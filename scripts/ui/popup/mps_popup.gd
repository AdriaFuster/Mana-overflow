extends BasePopup

func _set_value(_item: Variant) -> void:
	description_label.text = set_mps_string_value()

func set_mps_string_value() -> String:
	var base_mps: String = Big.new(Stats.mps).sufix()
	var extra_mps: String = ManaCalculator.get_permanent_modifiers_mps()

	var total_mps: String = base_mps + "(%s)"% extra_mps
	return total_mps
