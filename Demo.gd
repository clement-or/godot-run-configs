extends Node

func _ready():
  self.print("MYVAR = " + OS.get_environment("MY_VAR"))

func print(message: String):
  var label = get_node("/root/Scene/Output")
  label.text += "\n" + message
