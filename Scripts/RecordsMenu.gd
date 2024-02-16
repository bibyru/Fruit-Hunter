extends CanvasLayer

@onready var scrollBar = $Control/ScrollContainer/Container

func _ready():
	if FileAccess.file_exists(PauseMenu.recordPath):
		var records = FileAccess.open(PauseMenu.recordPath, FileAccess.READ)
		while(!records.eof_reached()):
			var arrCount : PackedStringArray = records.get_csv_line()
			var arrDate : PackedStringArray = records.get_csv_line()
			var arrTime : PackedStringArray = records.get_csv_line()
			
			var content = " / ".join(arrCount)
			var date = "-".join(arrDate)
			var time = ":".join(arrTime)
			
			if (arrCount.size() == 3):
				AddLabel("%s", arrCount[0])
				AddLabel("%s", arrCount[1])
				AddLabel("%s", str(arrCount[2]))
				AddLabel("%s", date)
				AddLabel("%s", time)
			
		records.close()

func AddLabel(string, stringFile):
	var label = Label.new()
	label.text = string % stringFile
	scrollBar.add_child(label)

func _on_button_pressed():
	hide()
