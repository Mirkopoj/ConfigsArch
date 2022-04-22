import pynvim
from os import listdir
import json


@pynvim.plugin
class cocIncPath(object):

	def __init__(self, nvim):
		self.nvim = nvim

	@pynvim.function('findPath')
	def find_ws_path(self):
		filepath = self.nvim.request('nvim_buf_get_name', 0)
		file_name = filepath.split('/')[-1]
		workspaceFolder = '/'.join(filepath.split('/')[:-1])
		ws_flag = 0
		while (ws_flag == 0):
			for f in listdir(workspaceFolder):
				if (f == "compile_commands.json"):
					ws_flag += 1
					break

			if (ws_flag == 0):
				workspaceFolder = '/'.join(workspaceFolder.split('/')[:-1])

		return file_name, workspaceFolder

	@pynvim.function('addPathtojsonLocally')
	def add_path_to_ccjson_locally(self, path):

		file_name, workspaceFolder = self.find_ws_path()
		with open(workspaceFolder+'/compile_commands.json', 'r') as f:
			compile_commands_dict = json.load(f)

		for info in compile_commands_dict:
			file_name_injson = list(info['file'].split("/"))[-1]
			if (file_name_injson == file_name):
				info['command'] += (' -I' + path)
				break

		with open(workspaceFolder + '/compile_commands.json', 'w') as f:
			json.dump(compile_commands_dict, f)

	@pynvim.function('addPathtojsonGlobally')
	def add_path_to_ccjson_globally(self, path):

		file_name, workspaceFolder = self.find_ws_path()
		with open(workspaceFolder+'/compile_commands.json', 'r') as f:
			compile_commands_dict = json.load(f)
			for info in compile_commands_dict:
				info['command'] += (' -I' + path)
		
		with open(workspaceFolder + '/compile_commands.json', 'w') as f:
			json.dump(compile_commands_dict, f)

	@pynvim.function('getPathFromUser')
	def get_user_incPath(self):
		self.nvim.call('inputsave')
		self.nvim.command('let path = input("Enter The Path: ")')
		self.nvim.call('inputrestore')
		return self.nvim.eval('path')

	@pynvim.command('IncludePathL')
	def includePathL(self):
		path = self.get_user_incPath()
		self.add_path_to_ccjson_locally(path)
		self.nvim.command('CocRestart') # to avoid restarting nvim for auto-completion
		self.nvim.out_write("The Path is included locally in compile_commands.json file. you can include files from that path\n")

	@pynvim.command('IncludePathG')
	def IncludePathG(self):
		path = self.get_user_incPath()	
		self.add_path_to_ccjson_globally(path)
		self.nvim.command('CocRestart') # to avoid restarting nvim for auto-completion
		self.nvim.out_write("The Path is included globally in compile_commands.json file. you can include files from that path!\n")
	
