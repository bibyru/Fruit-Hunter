extends CanvasLayer

var px720 = Vector2(1280, 720)
var px1080 = Vector2(1920, 1080)
var soundVol = 50

var checkpoint : Vector2

var deathCount : int = 0
var fruitCount : int = 0
var timeCount : int = 0
var recordPath = "user://Records.txt"
#"res://Output/Records.txt"
#"user://Records.txt"

@onready var fullMode = $Control/ContentContainer/UpperContainer/LeftContainer/FullscreenButton
@onready var borderMode = $Control/ContentContainer/UpperContainer/LeftContainer/BorderlessButton
@onready var vsyncMode = $Control/ContentContainer/UpperContainer/LeftContainer/VsyncButton

@onready var fruitLabel= $Control/ContentContainer/UpperContainer/RightContainer/FruitCounter
@onready var deathLabel = $Control/ContentContainer/UpperContainer/RightContainer/DeathCounter
@onready var playtimeLabel = $Control/ContentContainer/UpperContainer/RightContainer/PlaytimeLabel

@onready var slider_master = $Control/ContentContainer/VolumeContainer/VolumeMaster/Slider
@onready var slider_bgm = $Control/ContentContainer/VolumeContainer/VolumeBGM/Slider
@onready var slider_sfx = $Control/ContentContainer/VolumeContainer/VolumeSFX/Slider

@onready var id_master = AudioServer.get_bus_index("Master")
@onready var id_bgm = AudioServer.get_bus_index("BGM")
@onready var id_sfx = AudioServer.get_bus_index("SFX")

func _ready():
	visible = 0
	
	DisplayServer.window_set_size(px720)
	get_window().content_scale_size = px720
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	AudioServer.set_bus_volume_db(id_master, linear_to_db(slider_master.value))
	AudioServer.set_bus_volume_db(id_bgm, linear_to_db(slider_bgm.value * slider_master.value))
	AudioServer.set_bus_volume_db(id_sfx, linear_to_db(slider_sfx.value * slider_master.value))

func ResetCounter():
	fruitCount = 0
	deathCount = 0
	timeCount = 0

func AddRecord():
	if (FileAccess.file_exists(recordPath)):
		var records = FileAccess.open(recordPath, FileAccess.READ_WRITE)
		var dateDict = Time.get_date_dict_from_system()
		var timeDict = Time.get_time_dict_from_system()
		
		records.seek_end(0)
		records.store_csv_line(PackedStringArray([str(fruitCount), str(deathCount), str(timeCount)]))
		records.store_csv_line(PackedStringArray([str(dateDict.year), str(dateDict.month), str(dateDict.day)]))
		records.store_csv_line(PackedStringArray([str(timeDict.hour), str(timeDict.minute)]))
		
		records.close()
	else:
		var records = FileAccess.open(recordPath, FileAccess.WRITE)
		records.store_string("")
		records.close()

func PlayerDied():
	deathCount = deathCount + 1
	deathLabel.text = "Death Counter: " + str(deathCount)

func PlayerWon(i : int = 1):
	fruitCount = fruitCount + i
	fruitLabel.text = "Fruit Counter: " + str(fruitCount)

func PauseGame():
	if (get_tree().paused == false):
		visible = 1
		get_tree().paused = true
	else:
		visible = 0
		get_tree().paused = false

func _on_back_pressed():
	PauseGame()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level-0.tscn")
	PauseGame()

func _on_quit_pressed():
	get_tree().quit()

func _on_button_fullscreen_toggled(button_pressed):
	if button_pressed:
		fullMode.text = "  ON"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		fullMode.text = "OFF "
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_button_borderless_toggled(button_pressed):
	if button_pressed:
		borderMode.text = "  ON"
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		borderMode.text = "OFF "
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)

func _on_button_vsync_toggled(button_pressed):
	if button_pressed:
		vsyncMode.text = "  ON"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		vsyncMode.text = "OFF "
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_slider_master_value_changed(value):
	AudioServer.set_bus_volume_db(id_master, linear_to_db(value))

func _on_slider_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(id_bgm, linear_to_db(value * slider_master.value))

func _on_slider_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(id_sfx, linear_to_db(value * slider_master.value))

func _process(delta):
	if (Input.is_action_just_pressed("Esc")):
		PauseGame()
	
	if (Input.is_action_just_pressed("Interact")):
		pass
	
	if (get_parent().get_child(1).name != "Level-0"):
		if ($"Sfx-Bgm".playing == false):
			$"Sfx-Bgm".play()
	else:
		if ($"Sfx-Bgm".playing == true):
			$"Sfx-Bgm".stop()
	
	playtimeLabel.text = "Play Time: " + str(timeCount) + "s"
	if (get_parent().get_child(1).name == "Level-0"):
		if (!$Playtime.is_stopped()):
			$Playtime.stop()
	else:
		if ($Playtime.is_stopped()):
			$Playtime.start()

func _on_playtime_timeout():
	timeCount = timeCount +1
