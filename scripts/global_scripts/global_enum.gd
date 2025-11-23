extends Node


enum AugmentType {
	IDLE,
	CLICK
}


enum LOCATION{
	MANAGER,
	SHOP,
	INVENTORY
}

enum GAME_SCENE{
	BASE,
	BOSS
}

func enum_to_string(enum_dict: Dictionary, value: int) -> String:
	for k in enum_dict.keys():
		if enum_dict[k] == value:
			return k
	return "UNKNOWN"
