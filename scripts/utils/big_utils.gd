extends Node

static func clamp (val: Big, limit: Big ) -> float:
	var max_val: Big = limit.multiply(2)
	var min_val: Big = limit.divide(4)
	
	if val.isGreaterThan(max_val):
		return 1
	elif val.isLessThanOrEqualTo(min_val):
		return 0
	#else:
		#return val.divide(max_val)
		
	
	return 1
