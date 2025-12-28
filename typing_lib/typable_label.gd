class_name TypableLabel
extends RichTextLabel

@export var target_text: String = "":
	set(value):
		target_text = value
		update_text_display(last_input)
@export var active := true:
	set(value):
		active = value
		update_text_display(last_input)

@export var active_color: Color = Color.RED
@export var default_color: Color = Color.WHITE
@export var disabled_color: Color = Color.GRAY

var last_input: String = ""

func _ready() -> void:
	# Ensure RichTextLabel is set to process BBCode
	set_use_bbcode(true)
	InputBufferG.input_changed.connect(self.on_input_changed)
	update_text_display(InputBufferG.current_text)

func on_input_changed(current_input: String) -> void:
	last_input = current_input
	update_text_display(current_input)


func _color_with(text_: String, color: Color):
	return "[color=#%s]%s[/color]" % [color.to_html(false), text_]

# static
func _get_colored_text(label_text: String, typed_text: String):
	if typed_text.is_empty() or not label_text.begins_with(typed_text):
		return _color_with(target_text, default_color)
	var matched_part = label_text.substr(0, typed_text.length())
	var remaining_part = label_text.substr(typed_text.length())
	return _color_with(matched_part, active_color) + _color_with(remaining_part, default_color)

func update_text_display(current_input: String) -> void:
	if not self.active:
		self.text = _color_with(self.target_text, self.disabled_color)
		return

	if target_text.is_empty():
		self.text = ""
		return

	self.text = _get_colored_text(target_text, current_input)
