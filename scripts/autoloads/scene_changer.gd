extends Node

var loading_screen: PackedScene = preload("uid://cmhodrlo30mmq")
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
var use_sub_thread: bool = true
var version := 1 # 1 - change root scene, 2 - for levels

signal progress_changed(progress)
signal loading_finished

func _ready() -> void:
	set_process(false)

func change_scene(path: String, ver = 1) -> void:
	version = ver
	scene_path = path
	var new_load_screen = loading_screen.instantiate()
	add_child(new_load_screen)
	
	progress_changed.connect(new_load_screen._on_progress_changed)
	loading_finished.connect(new_load_screen._on_loading_finished)
	
	await new_load_screen.loading_screen_ready
	
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_thread)
	if state == OK:
		set_process(true)
	
func _process(_delta) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			
			if version == 1:
				get_tree().change_scene_to_packed(loaded_resource)
			elif version == 2:
				pass
			loading_finished.emit()
