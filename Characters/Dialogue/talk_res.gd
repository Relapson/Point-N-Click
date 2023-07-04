extends Resource
class_name DialogueOption

var id: String
var welcome: String
var npc_name: String
var options = []

func _init(id = "", welcome = "", npc_name = "", options = []):
	self.id = id
	self.welcome = welcome
	self.npc_name = npc_name
	self.options = options
