extends Node

@export var word_pool: Array[String] = [ "the", "and", "for", "you", "not", "but", "all", "any", "can", "had", "her", "was", "one", "our", "out", "day", "get", "has", "him", "his", "how", "man", "new", "now", "old", "see", "two", "way", "who", "boy", "did", "its", "let", "put", "say", "she", "too", "use", "why", "try", "ask", "work", "make", "time", "take", "good", "know", "look", "want", "give",]

var _used_words: Dictionary[String, bool] = {}
var _free_words: Dictionary[String, bool] = {}

func _ready():
	for word in self.word_pool:
		self._free_words[word] = true

func _consume_word(word: String) -> void:
	assert(word in self._free_words)
	assert(word not in self._used_words)
	self._free_words.erase(word)
	self._used_words[word] = true

func get_word() -> String:
	var index = randi() % self._free_words.size()
	var word = self._free_words.keys()[index]
	self._consume_word(word)
	return word
