extends Control


func _ready() -> void:
	$cover.show()
	$cover/AnimationPlayer.play("open")
	await $cover/AnimationPlayer.animation_finished
	$cover.hide()

func _on_start_pressed() -> void:
	$cover.show()
	$cover/AnimationPlayer.play("close")
	await $cover/AnimationPlayer.animation_finished
	SceneChanger.change_scene("res://scenes/main/main.tscn")

func _on_start_mouse_entered() -> void:
	$start/icon.show()

func _on_start_mouse_exited() -> void:
	$start/icon.hide()



func _on_options_pressed() -> void:
	$settings_screen.show()

func _on_options_mouse_entered() -> void:
	$options/icon.show()

func _on_options_mouse_exited() -> void:
	$options/icon.hide()



func _on_exit_pressed() -> void:
	pass # Replace with function body.

func _on_exit_mouse_entered() -> void:
	$exit/icon.show()

func _on_exit_mouse_exited() -> void:
	$exit/icon.hide()
