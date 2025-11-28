extends Node

class_name TextUtils

static func bold(text: String) -> String:
	return "[b]"+text+"[/b]"

static func italic(text: String) -> String:
	return "[i]"+text+"[/i]"

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
	return "[color=%s]%s[/color]" %[c.to_html(),t]
	
	
