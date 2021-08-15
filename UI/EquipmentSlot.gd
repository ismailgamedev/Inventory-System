extends TextureRect

func get_drag_data(_pos):
	var equipment_slot = get_parent().get_name()
	if PlayerData.equipment_data[equipment_slot] != null:
		var data = {}
		data["origin_texture"] = texture
		data["origin_panel"] = "CharacterSheet"
		data["origin_item_id"] = PlayerData.equipment_data[equipment_slot]
		data["origin_equipment_slot"] = equipment_slot
		data["origin_stackable"] = false
		data["origin_stack"] = 1
		data["origin_node"] = self
		
		var drag_texture : TextureRect = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = texture
		drag_texture.rect_size = Vector2(36,36)
		drag_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		var control : Control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		set_drag_preview(control)
		return data

func can_drop_data(_pos, data):
	var target_equipment_slot = get_parent().get_name()
	if target_equipment_slot == data["origin_equipment_slot"]:
		if PlayerData.equipment_data[target_equipment_slot] == null:
			data["target_item_id"] = null
			data["target_texture"] = null
		else:
			data["target_item_id"] = PlayerData.equipment_data[target_equipment_slot]
			data["target_texture"] = texture
		return true
	else:
		return false
	
func drop_data(_pos, data):
	var target_equipment_slot = get_parent().get_name()
	var origin_slot = data["origin_node"].get_parent().get_name()
	
	if data["origin_panel"] == "Inventory":
		PlayerData.inv_data[origin_slot]["Item"] = data["target_item_id"]
	else:
		PlayerData.equipment_data[origin_slot] = data["target_item_id"]
		
	if data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		var default_texture = load("res://Sprites/" + origin_slot + "Sprite.png")
		data["origin_node"].texture = default_texture
	else:
		data["origin_node"].texture = data["target_texture"]
		
	PlayerData.equipment_data[target_equipment_slot] = data["origin_item_id"]
	texture = data["origin_texture"]
		
		
	
