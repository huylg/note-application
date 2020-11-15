class Note{
	int id;
	String content;

	Note({
		this.id,
		this.content,
	});

	factory Note.fromJson(Map<String, dynamic> json) {
		return Note(id: json['id'], content: json['content']);
	}


	Map<String, dynamic> toJson() => {
		"id": this.id,
		"content": this.content,
	};



}
