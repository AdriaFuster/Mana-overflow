extends Node
class_name FloatUtils

static func clamp (val: float, limit: float ) -> float:
	print("-----------CLAMP-----------")
	var max_val: float = limit*2
	var min_val: float = limit/4
	
	print ("val = ", val)
	print ("max_val = ", max_val)
	print ("min_val = ", min_val)
	
	var ratio: float = val/max_val
	
	print ("ratio = ", ratio)
	if Comp.greater(val,max_val):
		return 1
	elif Comp.less_equal(val,min_val):
		return 0
	print("tornem el ratio")
	return ratio
