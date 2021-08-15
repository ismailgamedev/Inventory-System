extends Control

var tempalte_inv_slot = preload("res://Templates/InventorySlot.tscn")

onready var gridcontainer = get_node("InventoryBackground/SlotsContainer")

func _ready():
	for i in PlayerData.inv_data.keys():
		var inv_slot_new = tempalte_inv_slot.instance()

		if PlayerData.inv_data[i]["Item"] != null:
			var item_name = GameData.item_data[str(PlayerData.inv_data[i]["Item"])]["Name"]
			var item_texture = load("res://Sprites/" + item_name + "Sprite.png")
			inv_slot_new.get_node("Icon").set_texture(item_texture)
			var item_stack = PlayerData.inv_data[i]["Stack"]
			if item_stack != null and item_stack > 1:
				inv_slot_new.get_node("Icon/StackSizeLabel").set_text(str(item_stack))
		gridcontainer.add_child(inv_slot_new,true)
