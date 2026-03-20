class_name LevelStar extends Sprite2D

@onready var sprite := preload("res://assets/sprites/icons/level_star.png")

func _ready():
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property($Sprite2D, "rotation_degrees", 15.0, 0.6)
	tween.tween_property($Sprite2D, "rotation_degrees", -15.0, 0.6)
