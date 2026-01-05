extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

func insert(item:InventoryItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func clear():
	for slot in slots:
		slot.item = null
		slot.amount = 0
	update.emit()


func get_item_count(item_name: String) -> int:
	var total := 0
	for slot in slots:
		if slot.item != null and slot.item.name == item_name:
			total += slot.amount
	return total

func remove_one_by_name(item_name: String) -> bool:
	for slot in slots:
		if slot.item != null and slot.item.name == item_name:
			slot.amount -= 1
			if slot.amount <= 0:
				slot.item = null
				slot.amount = 0
			update.emit()
			return true
	return false
