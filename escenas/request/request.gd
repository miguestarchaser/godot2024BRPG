extends Node2D

var save_path 			= "";
@export var parameter 	= "";   
var current_parameter 	= "";
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass
	
func download(link, _path):
	print("descargando")
	$HTTPRequest.request_completed.connect(download_completed)
	$HTTPRequest.set_download_file(save_path)
	var request = $HTTPRequest.request(link)
	if request != OK:
		push_error("Http request error")

func download_completed(result, response_code, headers, body) -> void:
	if result != OK:
		print("error")
	else:
		print(save_path)
		if FileAccess.file_exists(save_path):
			print("file exists")
			var image 	= Image.load_from_file(save_path)
			var texture = ImageTexture.create_from_image(image)
			#texture 	= texture
			
			$Sprite2D.set_texture(texture)
			$Sprite2D.scale = Vector2(4,4)
			
			
		else:
			print("No encontre el archivo")
	pass

func _http_request_completed(result, _response_code, _headers, _body):
	if result != OK:
		push_error("Download Failed")
	
func request() -> void:
	#conectamos la señal en espera de respuesta
	$HTTPRequest.connect("request_completed",_on_request_completed)
	$HTTPRequest.request("https://pokeapi.co/api/v2/pokemon/"+current_parameter)
	pass	
	
func _on_request_completed(result, response_code, headers, body):
	#print(result)
	#print(headers)
	#print(body)
	print(response_code)
	if(response_code > 200 && response_code<300):
		print("respuesta correcta!")
	else:
		print("error en la peticion")
	#peticiones http
	#var http = HTTPRequest.new();
	#add_child(http);
	#desconectamos la señal
	$HTTPRequest.disconnect("request_completed",_on_request_completed)
	var json = JSON.parse_string(body.get_string_from_utf8()) #" > &quote;
	#print(json)
	var link = json["sprites"]["front_default"];
	if( json.name != null):
		$Label.text = json.name;
		$TextEdit.text = "";
		save_path = "user://"+(str(json["id"]))+".png";
		download(link,save_path)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if(current_parameter!=parameter):
	#	current_parameter = parameter;
	#	request();
	pass


func _on_button_pressed() -> void:
	print("peticion")
	current_parameter = $TextEdit.text
	request();
	pass # Replace with function body.
