extends Node

signal arrow_number_change

var arrow_number:int = 3

func add_arrow():
	arrow_number= arrow_number+1
	arrow_number_change.emit(arrow_number)
	
func get_arrow_number():
	return arrow_number
	
func remove_arrow():
	if arrow_number>0:
		arrow_number= arrow_number-1
	arrow_number_change.emit(arrow_number)
