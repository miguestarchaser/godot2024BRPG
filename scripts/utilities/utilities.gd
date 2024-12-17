extends Node

class_name utilities

func dir_contents(path,extension)->Array[String]:
	#explorador de archivos
	var item_list:Array[String] = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			#validamos si es un directorio
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print(file_name);
				#obtenemos la extension
				var ext = file_name.get_extension();
				if(ext!="import" && extension==ext):
					#agregamos los archivos al arreglo
					item_list.push_back(file_name)
					pass
				#print("Found file: " + file_name)
			#asignamos el siguiente archivo	
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return item_list;
