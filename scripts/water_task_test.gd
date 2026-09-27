extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var player = get_tree().current_scene.get_node("Player")
	if body == player:
		if player.grabbing:
			player.held_thing.emit_signal("task_finished",["Water",-1])
	
	
