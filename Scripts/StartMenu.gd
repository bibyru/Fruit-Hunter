extends Node2D

func _ready():
	$RecordsMenu.visible = false

func _on_start_button_down():
	get_tree().change_scene_to_file("res://Scenes/Level-1.tscn")

func _on_options_button_down():
	PauseMenu.PauseGame()
	
func _on_records_button_down():
	if $RecordsMenu.visible == false:
		$RecordsMenu.show()
	else:
		$RecordsMenu.hide()

func _on_quit_button_down():
	get_tree().quit()
