extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D/Area2D/CollisionShape2D.shape = $AnimatedSprite2D/Area2D/CollisionShape2D.shape.duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $AnimatedSprite2D.frame == 2:	
		$AnimatedSprite2D/Area2D/CollisionShape2D.shape.radius = 35
	elif $AnimatedSprite2D.frame == 3:	
		$AnimatedSprite2D/Area2D/CollisionShape2D.shape.radius = 25
	elif $AnimatedSprite2D.frame == 4:	
		$AnimatedSprite2D/Area2D/CollisionShape2D.shape.radius = 10
	elif $AnimatedSprite2D.frame == 5:	
		$AnimatedSprite2D/Area2D/CollisionShape2D.shape.radius = 1
