@tool
class_name LevelStar extends Sprite2D
@onready var sprite := preload("res://assets/sprites/icons/level_star.png")

func _ready():
	texture = sprite
	var r = randi_range(15, 15)
	var t = randf_range(0.6, 1.0)
	
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "rotation_degrees", 40.0 + r, t)
	tween.tween_property(self, "rotation_degrees", -40.0 - r, t)
