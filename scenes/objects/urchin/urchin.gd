class_name Urchin extends Area2D

func _ready() -> void:
	var sprites := [preload("res://assets/sprites/urchin/urchin_1.png")]
	var i = randi_range(0, len(sprites))
	
	$Sprite2D.texture = sprites[i]
	
