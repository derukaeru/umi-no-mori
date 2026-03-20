extends Control

func _ready() -> void:
	$AnimationPlayer.play("show")
	await $AnimationPlayer.animation_finished
	SceneChanger.change_scene("res://scenes/gui/title_screen.tscn")
