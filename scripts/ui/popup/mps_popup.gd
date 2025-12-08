extends BasePopup

func _set_value(_item: Variant) -> void:
	description_label.text = set_mps_string_value()

func set_mps_string_value() -> String:
	var mps_string: String = "Base MPS:"
	var base_mps: String = Big.new(Stats.mps).sufix()
	var extra_mps: String = ManaCalculator.get_permanent_modifiers_mps()
	
	mps_string += base_mps
	if extra_mps != "":
		mps_string += " (%s)"% extra_mps
	
	return mps_string
