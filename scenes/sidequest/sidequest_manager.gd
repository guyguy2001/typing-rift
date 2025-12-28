extends Node

signal focus_changed(items: Array[String])

func focus(items: Array[String]):
	focus_changed.emit(items)
