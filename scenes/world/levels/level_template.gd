extends Node2D

@onready var player_spawn := $player_spawn
@onready var urchin_spawns := $urchin_spawns

@onready var urchin_object

func _ready():
	for entry in urchin_spawns:
		if entry is UrchinSpawn:
			pass
