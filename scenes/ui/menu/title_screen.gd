extends Control


func _ready():
	$cover.show()
	$cover/AnimationPlayer.play("open")
	await $cover/AnimationPlayer.animation_finished
	$cover.hide()

func _on_start_pressed():
	$cover.show()
	$cover/AnimationPlayer.play("close")
	await $cover/AnimationPlayer.animation_finished
	SceneChanger.change_scene("res://scenes/main/main.tscn")

func _on_start_mouse_entered():
	$start/icon.show()

func _on_start_mouse_exited():
	$start/icon.hide()



func _on_options_pressed():
	$settings_screen.show()

func _on_options_mouse_entered():
	$options/icon.show()

func _on_options_mouse_exited():
	$options/icon.hide()



func _on_exit_pressed():
	pass # Replace with function body.

func _on_exit_mouse_entered():
	$exit/icon.show()

func _on_exit_mouse_exited():
	$exit/icon.hide()
