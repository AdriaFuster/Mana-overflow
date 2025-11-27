extends Node
class_name Comp

const EPSILON := 1e-9

static func equal(a: float, b: float) -> bool:
	return abs(a - b) <= EPSILON

static func less(a: float, b: float) -> bool:
	return (a + EPSILON) < b

static func greater(a: float, b: float) -> bool:
	return (a - EPSILON) > b

static func less_equal(a: float, b: float) -> bool:
	return less(a, b) or equal(a, b)

static func greater_equal(a: float, b: float) -> bool:
	return greater(a, b) or equal(a, b)
