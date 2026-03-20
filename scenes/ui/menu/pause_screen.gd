extends Control


func _on_resume_mouse_entered() -> void:
	$resume/icon.show()

func _on_resume_mouse_exited() -> void:
	$resume/icon.hide()

func _on_options_mouse_entered() -> void:
	$options/icon.show()

func _on_options_mouse_exited() -> void:
	$options/icon.hide()

func _on_menu_mouse_entered() -> void:
	$menu/icon.show()

func _on_menu_mouse_exited() -> void:
	$menu/icon.hide()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()
