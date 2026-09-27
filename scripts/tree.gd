extends Sprite2D
@onready var area := $Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)



func _on_body_entered(body: Node2D) -> void:
	z_index = 3


func _on_body_exited(body: Node2D) -> void:
	z_index = 1
