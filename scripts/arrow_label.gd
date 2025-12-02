extends Label

func  _ready() -> void:
	EventBus.arrow_number_change.connect(arrow_number_change)
	arrow_number_change(EventBus.get_arrow_number())
	
func arrow_number_change(number:int):
	text = "arrow:"+str(number)
