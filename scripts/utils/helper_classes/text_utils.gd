extends Node

class_name TextUtils

const ENHANCING_SYMBOL: String = " -> "

static func bold(text: String) -> String:
	return "[b]"+text+"[/b]"

static func italic(text: String) -> String:
	return "[i]"+text+"[/i]"


static func replace_augment_string(replace_string: String, var_name: String, 
							text: String, a: Augment,color:Color = Color.WHITE ) -> String:
	
	var dollar_replaced_string = "$"+replace_string+"$"
	var new_text := text
	
	if dollar_replaced_string not in text or a.get(var_name) == null:
		return new_text
	
	var number_value = a.get(var_name)

	if replace_string.ends_with("P"):
		number_value *= 100

	var string_value = Big.new(number_value).sufix(false,2)
	if replace_string.ends_with("P"):
		string_value += "%"
	
	#add color
	if color != Color.WHITE:
		var sign_pos: int = has_plus_or_minus_sign (new_text, dollar_replaced_string)
		
		if sign_pos != -1:
			#Delete the sign from the text and add it to the number string
			var text_sign: String = new_text[sign_pos]
			new_text = new_text.substr(0, sign_pos) + new_text.substr(sign_pos + 1)
			
			string_value = text_sign + string_value
		
		string_value = set_color(string_value, color)
		string_value = bold(string_value)
	
	new_text = new_text.replace(dollar_replaced_string, string_value)
	return new_text
		
static func replace_augment_string_enhancing(replace_string: String, var_name: String, 
enhanced_var_name:String,text: String, a: Augment, color:Color) -> String:
	
	var dollar_replaced_string = "$"+replace_string+"$"
	var new_text := text
	
	if dollar_replaced_string not in text or a.get(var_name) == null:
		return new_text
	

	var number_value = a.get(var_name)
	var enhanced_number_value = a.get(enhanced_var_name)
	
	if replace_string.ends_with("P"):
		number_value *= 100
		enhanced_number_value *= 100

	var string_value = Big.new(number_value).sufix(false,2)
	var enhanced_string_value = Big.new(enhanced_number_value).sufix(false,2)
	
	if replace_string.ends_with("P"):
		string_value += "%"
		enhanced_string_value += "%"
	
	
	var sign_pos: int = has_plus_or_minus_sign (new_text, dollar_replaced_string)
	if sign_pos != -1:
		#Delete the sign from the text and add it to the number string
		var text_sign: String = new_text[sign_pos]
		new_text = new_text.substr(0, sign_pos) + new_text.substr(sign_pos + 1)
		
		string_value = text_sign + string_value
		enhanced_string_value = text_sign + enhanced_string_value	
	
	#add color
	enhanced_string_value = set_color(enhanced_string_value, color)
	enhanced_string_value = bold(enhanced_string_value)
	
	var final_string_value:String = string_value + ENHANCING_SYMBOL + enhanced_string_value
	new_text = new_text.replace(dollar_replaced_string, final_string_value)
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
