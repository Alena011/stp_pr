require_relative 'TaskManager'

task_manager = TaskManager.new
task_manager.load_from_file if task_manager.respond_to?(:load_from_file)
task_manager.start_menu