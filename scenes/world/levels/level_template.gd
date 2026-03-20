extends Node2D

@onready var player_spawn := $player_spawn
@onready var urchin_spawns := $urchin_spawns

@onready var urchin_object := preload("res://scenes/objects/urchin/urchin.tscn")
@onready var player

func _ready() -> void:
	for entry in urchin_spawns:
		if entry is UrchinSpawn:
			var urchin := urchin_object.instantiate()
			urchin.position = entry.position
			
			entry.queue_free()
			urchin_spawns.add_child(urchin)
