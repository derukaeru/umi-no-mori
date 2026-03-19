extends Control


func _on_resume_mouse_entered():
	$resume/icon.show()

func _on_resume_mouse_exited():
	$resume/icon.hide()

func _on_options_mouse_entered():
	$options/icon.show()

func _on_options_mouse_exited():
	$options/icon.hide()

func _on_menu_mouse_entered():
	$menu/icon.show()

func _on_menu_mouse_exited():
	$menu/icon.hide()

func _on_resume_pressed():
	get_tree().paused = false
	hide()
