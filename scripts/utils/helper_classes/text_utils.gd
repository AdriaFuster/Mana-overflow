extends Node

class_name TextUtils

static func bold(text: String) -> String:
	return "[b]"+text+"[/b]"

static func italic(text: String) -> String:
	return "[i]"+text+"[/i]"


static func replace_augment_string(replace_string: String, var_name: String, 
							text: String, a: Augment, color:Color = Color.WHITE ) -> String:
	
	var dollar_replaced_string = "$"+replace_string+"$"
	var new_text := text
	
	if dollar_replaced_string not in text or a.get(var_name) == null:
		return new_text
	
	
	var number_value = a.get(var_name)
	
	if replace_string.ends_with("P"):
		number_value *= 100
	
	#No decimals
	#if var_value == floor(var_value):
		#var_value = int(var_value)
	#Decimal
	
	var string_value = Big.new(number_value).sufix(false,2)
	if replace_string.ends_with("P"):
		string_value += "%"
	
	#add color
	if color != Color.WHITE:
		string_value = set_color(string_value, color)
		string_value = bold(string_value)
	
		
		var sign_pos: int = has_plus_or_minus_sign (new_text, dollar_replaced_string) 
		if sign_pos != -1:
			var sign_with_color: String = set_color(new_text[sign_pos], color)
			sign_with_color = bold(sign_with_color)
			new_text = new_text.substr(0, sign_pos) + sign_with_color + new_text.substr(sign_pos + 1)
	
	
	new_text = new_text.replace(dollar_replaced_string, string_value)
	return new_text
		

static func replace_upgrade_string(replace_string: String, var_name: String, 
									text: String, u: Upgrade, color:Color = Color.WHITE ) -> String:
	
	var dollar_replaced_string = "$"+replace_string+"$"
	var new_text := text
	
	if dollar_replaced_string not in text or u.get(var_name) == null:
		return new_text
	
	var var_value = u.get(var_name)
	
	if var_name == "mps":
		#2 decimals
		var_value = Big.new(var_value).sufix(true,2)
		#Set lvl color
		if color != Color.WHITE:
			var_value = set_color(var_value, color)
		#Bold
		var_value = bold(var_value)
		
		
	new_text = text.replace(dollar_replaced_string, str(var_value))
	return new_text

static func set_color(t:String, c:Color) -> String:
	return "[color=%s]" %[c.to_html()]+t+"[/color]"

static func has_plus_or_minus_sign (text: String, token: String) -> int:
	var i :int = text.find(token)
	if i > 0:
		var prev_char: String = text[i -1]
	
		if prev_char == "+" or prev_char == "-":
			return i - 1
		else: 
			return -1
	else:
		return -1
