extends Node

var equipment_data = {"HandSlot": 10001}

var inv_data : Dictionary = {}

func _ready():
	var inv_data_file = File.new()
	inv_data_file.open("user://inv_data.json",File.READ)
	var inv_data_json = JSON.parse(inv_data_file.get_as_text())
	inv_data_file.close()
	inv_data = inv_data_json.result
