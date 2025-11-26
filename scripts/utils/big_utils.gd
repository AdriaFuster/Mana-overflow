extends Node
class_name BigUtils

static func clamp (val: Big, limit: Big ) -> float:
	print("-----------CLAMP-----------")
	var max_val: Big = limit.multiply(2)
	var min_val: Big = limit.divide(4)
	
	print ("val = ", val.toAmericanName())
	print ("max_val = ", max_val.toAmericanName())
	print ("min_val = ", min_val.toAmericanName())
	
	var ratio: Big = val.divide(max_val)
	
	print ("ratio = ", ratio.toAmericanName())
	if val.isGreaterThan(max_val):
		return 1
	elif val.isLessThanOrEqualTo(min_val):
		return 0
	print("tornem el ratio")
	return ratio.toFloat()

static func lerp (a: Big, b: Big, t: Big) -> Big:
	#a + (b - a) * t
	var c: Big = b.minus(a)
	var d: Big = c.multiply(t)
	return a.plus(d)
	
