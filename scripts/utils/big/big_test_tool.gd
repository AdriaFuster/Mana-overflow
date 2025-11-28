@tool extends  EditorScript


var number: Array = [
	0,
	5,
	10,
	999,
	1000,
	1234,
	999999,
	0.1,
	0.01,
	10.50,
	10.005,
	1000.50,
	# --- 2. Nombres grans (amb sufix) ---
	1_000_000,
	1_234_000,
	12_345_678,
	999_999_999,
	1_000_000_000,
	1_234_567_890,
	1e15,
	1.5e6,
	1500, # per comprovar el llindar K o milions

	# --- 3. Negatius ---
	-5,
	-1234,
	-1000000,
	-1234567,
	-0.5,
	-1500.55,

	# --- 4. Decimals grans ---
	1_000_000.123,
	1_234_567.89,
	(1_000_000 * 1.2345),
	1.234567e9,
	999_500,

	# --- 5. Límits de canvi de sufix ---
	999_999,
	1_000_000,
	999_999_999,
	1_000_000_000,
	999_999_999_999,
	1_000_000_000_000,

	# --- 6. Separadors configurables ---
	# (els mateixos números, però serveixen per probar separadors canviants)
	1234.56,
	1234567.89,

	# --- 7. Màxims sufixos ---
	1e300,
	1e303,
	1e306,
	1e309,

	# --- 8. Nombres especials ---
	INF,
	-INF,
	NAN,
	0.0000001,
	-0.0001,

	# --- 9. Casos reals de jocs ---
	2350,
	253_000,
	5_230_000,
	1_523_999,
	1_000_000_000_000]
	
func _run() -> void:
	#var a: float = 1000000.5
	#var b: float = 51000
	#var c:Big = Big.new(a+b)
	#print(c.with_sufix())
	test_numbers()
	
	
func test_numbers() -> void:
	for n in number:
		var a: Big = Big.new(n)
		print("-----------")
		print("valor ",n, " resultat ", a.sufix(true, 0))
	
	
