extends RefCounted
class_name Big

const MAX_DECIMALS := 3
const MAX_DECIMALS_SMALL := 2

const THOUSAND_SEPARATOR: String = "."
const DECIMAL_SEPARATOR: String = ","


const SUFFIXES := [
	"million","billion","trillion","quadrillion","quintillion",
	"sextillion","septillion","octillion","nonillion","decillion",
	"undecillion","duodecillion","tredecillion","quattuordecillion",
	"quindecillion","sexdecillion","septendecillion","octodecillion",
	"novemdecillion","vigintillion","unvigintillion","duovigintillion",
	"tresvigintillion","quattuorvigintillion","quinvigintillion",
	"sexvigintillion","septenvigintillion","octovigintillion",
	"novemvigintillion","trigintillion","untrigintillion",
	"duotrigintillion","trestrigintillion","quattuortrigintillion",
	"quintrigintillion","sextrigintillion","septentrigintillion",
	"octotrigintillion","novemtrigintillion","quadragintillion",
	"unquadragintillion","duoquadragintillion","tresquadragintillion",
	"quattuorquadragintillion","quinquadragintillion","sexquadragintillion",
	"septenquadragintillion","octoquadragintillion","novemquadragintillion",
	"quinquagintillion","unquinquagintillion","duoquinquagintillion",
	"tresquinquagintillion","quattuorquinquagintillion","quinquinquagintillion",
	"sexquinquagintillion","septenquinquagintillion","octoquinquagintillion",
	"novemquinquagintillion","sexagintillion","unsexagintillion",
	"duosexagintillion","tressexagintillion","quattuorsexagintillion",
	"quinsexagintillion","sexsexagintillion","septensexagintillion",
	"octosexagintillion","novemsexagintillion","septuagintillion",
	"unseptuagintillion","duoseptuagintillion","tresseptuagintillion",
	"quattuorseptuagintillion","quinseptuagintillion","sexseptuagintillion",
	"septenseptuagintillion","octoseptuagintillion","novemseptuagintillion",
	"octogintillion","unoctogintillion","duooctogintillion",
	"tresoctogintillion","quattuoroctogintillion","quinoctogintillion",
	"sexoctogintillion","septenoctogintillion","octooctogintillion",
	"novemoctogintillion","nonagintillion","unnonagintillion",
	"duononagintillion","tresnonagintillion","quattuornonagintillion",
	"quinnonagintillion","sexnonagintillion","septennonagintillion",
	"octononagintillion","novemnonagintillion","centillion","uncentillion"
]

static var _thresholds: PackedFloat64Array = PackedFloat64Array()
static var _initialized := false


var value: float


func _init(v: float = 0.0):
	value = v
	if not _initialized:
		_init_thresholds()
		_initialized = true


func sufix(enable_millions: bool = true, max_dec_small: int = MAX_DECIMALS_SMALL, max_dec_big:int = MAX_DECIMALS) -> String:
	return _format_value(value, enable_millions, max_dec_small, max_dec_big)

static func _init_thresholds():
	var count := SUFFIXES.size()
	_thresholds.resize(count)

	var x := 1.0
	x *= 1000.0
	x *= 1000.0  # 1000^2 = million

	for i in range(count):
		_thresholds[i] = x
		x *= 1000.0


static func _format_value(n: float, enable_millions: bool,max_dec_small, max_dec_big) -> String:
	
	var inf:String = _check_if_inf(n)
	
	if inf != "": return inf
	
	var absn: float = abs(n)
	var start_i := 0 if enable_millions else 1
	var s: String
	if absn < _thresholds[start_i]:
		# valors petits: mostrar decimals només si són significatius
		var decimals :int = max_dec_small
		s = "%.*f" % [decimals, n]
		if "." in s:
			s = s.rstrip("0").rstrip(".")
		s = _add_thousand_separator(s)
		#s = s.replace(".", DECIMAL_SEPARATOR)
		return s

	var lo := start_i
	var hi := _thresholds.size() - 1

	while lo < hi:
		var mid := (lo + hi + 1) >> 1
		if absn >= _thresholds[mid]:
			lo = mid
		else:
			hi = mid - 1

	var mag := lo
	var scaled := n / _thresholds[mag]

	s = "%.*f" % [max_dec_big, scaled]
	s = s.rstrip("0").rstrip(".")
	s = s.replace(".", DECIMAL_SEPARATOR)
	return "%s %s" % [s, SUFFIXES[mag]]


static func _add_thousand_separator(s: String) -> String:
	var parts = s.split(".")
	var int_part = parts[0]
	var dec_part = ""
	if parts.size() > 1:
		dec_part = DECIMAL_SEPARATOR + parts[1]
	var result := ""
	var count := 0
	for i in range(int_part.length() - 1, -1, -1):
		result = int_part[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = THOUSAND_SEPARATOR + result

	return result + dec_part
	
static func _check_if_inf(n: float) -> String:
	if is_nan(n):
		return "NaN"
	if n == INF:
		return "INF"
	if n == -INF:
		return "-INF"
	return ""

	
