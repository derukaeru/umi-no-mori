extends Node2D

@onready var player_spawn := $player_spawn
@onready var urchin_spawns := $urchin_spawns
@onready var urchin_object := preload("uid://biq3mkdp0qysx")
@onready var moving_urchin_object := preload("uid://dvbjlwv0etp1k")

func _ready() -> void:
	for entry in urchin_spawns.get_children():
		if entry is UrchinSpawn:
			var urchin := urchin_object.instantiate()
			urchin.position = entry.position
			
			entry.queue_free()
			urchin_spawns.add_child(urchin)
			
		if entry is MovingUrchinSpawn:
			var urchin := moving_urchin_object.instantiate()
			urchin.position = entry.position
			
			entry.queue_free()
			urchin_spawns.add_child(urchin)
	
	var player = Util.get_player()
	if not player: return
	
	player.reset()
	player.position = $player_spawn.position
