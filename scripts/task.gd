extends Node
class_name task
	
const types:Array = ["Water","Music","Sun"]
const requests:Dictionary = {
	"Water":"My roots are thirsty",
	"Music":"I want to dance, can you play me some music",
	"Sun":"I want sun"
	}
var request:String
var curr_task:String = "None"
var last_task:String = "None"

func assign(label):
	while curr_task == last_task:
		curr_task = types[randi_range(0,2)]
	label.text = requests[curr_task]
func finish(label):
	last_task = curr_task
	assign(label)
	
	
