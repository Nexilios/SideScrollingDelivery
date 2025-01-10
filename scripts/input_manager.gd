extends Node

var interaction_areas: Array[PriorityArea2D] = []

func register_area(area: PriorityArea2D):
	interaction_areas.append(area)
	
func unregister_area(area: PriorityArea2D):
	interaction_areas.erase(area)
	
func handle_interaction(player: Player):
	if interaction_areas.is_empty():
		return
		
	# Sort areas by priority
	var sorted_areas = interaction_areas.duplicate()
	sorted_areas.sort_custom(func(a, b): 
		return a.input_priority < b.input_priority
	)
	
	# Handle only the highest priority interaction
	if sorted_areas.size() > 0:
		sorted_areas[0].handle_interaction.emit(player)
