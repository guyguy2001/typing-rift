extends Label

func _ready() -> void:
	self.text = "" # Initialize with empty text
	InputBufferG.input_changed.connect(on_input_changed)

func on_input_changed(new_text: String) -> void:
	self.text = new_text
