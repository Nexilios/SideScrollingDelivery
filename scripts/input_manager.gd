extends Node

var interaction_areas: Array[Area2D] = []
var priority_order = {
	"CollectArea": 0,  # Highest priority (lower number = higher priority)
	"Truck": 1   # Lower priority
}

func register_area(area: Area2D):
	interaction_areas.append(area)
	
func unregister_area(area: Area2D):
	interaction_areas.erase(area)
	
func handle_interaction():
	if interaction_areas.is_empty():
		return
		
	# Sort areas by priority
	var sorted_areas = interaction_areas.duplicate()
	sorted_areas.sort_custom(func(a, b): 
		return priority_order.get(a.name, 999) < priority_order.get(b.name, 999)
	)
	
	# Handle only the highest priority interaction
	if sorted_areas.size() > 0:
		sorted_areas[0].handle_interaction()
