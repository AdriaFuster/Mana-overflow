extends Node
class_name Modifier

var id: String
var function: Callable
var ticks_remaining: int
var permanent: bool

func _init(i: String, f:Callable, ticks: int, p: bool = false):
	id = i
	function = f
	ticks_remaining = ticks
	permanent = p
	
