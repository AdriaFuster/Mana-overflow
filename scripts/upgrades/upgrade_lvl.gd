extends Node
class_name UpgradeLvl


const lvl_colors :Array = [
	Color(0.00, 0.85, 1.00),
	Color(0.284, 0.567, 1.0, 1.0),
	Color(0.40, 0.00, 0.80),
	Color(0.00, 0.75, 0.25),
	Color(0.60, 0.00, 0.60),
	Color(1.00, 0.00, 0.35),
	Color(1.00, 0.40, 0.00),
	Color(0.85, 0.55, 0.00),
	Color(0.95, 0.70, 0.00),
	Color(1.00, 0.85, 0.00)
	]
	
static func get_lvl_color(lvl: int) -> Color:
	if lvl <= lvl_colors.size() -1:
		return lvl_colors[lvl-1]
	
	return lvl_colors[lvl_colors.size()-1]
