extends CanvasLayer

signal dialogue_finished

var lines: Array[String] = []
var current_line := 0
var is_typing := false

@onready var label = $Panel/Label

func start(dialogue: Array[String]):
	lines = dialogue
	current_line = 0
	visible = true
	type_line(lines[current_line])

func type_line(line: String):
	label.text = ""
	is_typing = true
	for character in line:
		label.text += character
		await get_tree().create_timer(0.04).timeout
	is_typing = false

func _input(_event):
	if not visible: return
	if Input.is_action_just_pressed("ui_accept"):
		if is_typing:
			# skip to end of current line instantly
			is_typing = false
			label.text = lines[current_line]
			return
		current_line += 1
		if current_line >= lines.size():
			visible = false
			dialogue_finished.emit()
		else:
			type_line(lines[current_line])
