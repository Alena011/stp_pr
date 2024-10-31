require 'json'
require_relative 'Task'

class TaskManager
  def initialize
    @tasks = []
  end

  def find_task(task_id)
    @tasks.find { |task| task.id == task_id }
  end

  def add_task(title, desc, deadline)
    task = Task.new(title, desc, deadline)
    @tasks << task
  end

  def edit(task_id, title: nil, desc: nil, deadline: nil, status: nil)
    task = find_task(task_id)
    if task
      task.title = title if title
      task.desc = desc if desc
      task.deadline = deadline if deadline
      task.status = status unless status.nil?
    else
      puts "Задача с таким ID не найдена."
    end
  end

  def delete_task(task_id)
    @tasks.reject! { |task| task.id == task_id }
    puts "Задача удалена"
  end

  def start_menu
    loop do
      puts "\n------Меню управления задачами------"
      puts "1. Добавить задачу"
      puts "2. Удалить задачу"
      puts "3. Редактировать задачу"
      puts "4. Отфильтровать задачи"
      puts "5. Показать все задачи"
      puts "6. Выйти"
      print "Выберите действие: "

      choice = gets.chomp.to_i

      case choice
      when 1
        add_task_menu
      when 2
        delete_task_menu
      when 3
        edit_task_menu
      when 4
        filter_tasks_menu
      when 5
        show_all_tasks
      when 6
        save_to_file
        puts "Выход"
        break
      else
        puts "Некорректный выбор"
      end
    end
  end

  def add_task_menu
    print "Введите название задачи: "
    title = gets.chomp
    print "Введите описание задачи: "
    desc = gets.chomp
    print "Введите срок выполнения (YYYY-MM-DD): "
    deadline = gets.chomp

    task = Task.new(title, desc, deadline)
    @tasks << task
    puts "Задача добавлена!"
  end

  def delete_task_menu
    print "Введите ID задачи для удаления: "
    id = gets.chomp.to_i
    delete_task(id)
  end

  def edit_task_menu
    print "Введите ID задачи для редактирования: "
    task_id = gets.chomp.to_i
    task = find_task(task_id)

    if task
      print "Введите новое название (оставьте пустым, если не нужно менять): "
      title = gets.chomp
      title = nil if title.empty?

      print "Введите новое описание (оставьте пустым, если не нужно менять): "
      desc = gets.chomp
      desc = nil if desc.empty?

      print "Введите новый срок (оставьте пустым, если не нужно менять): "
      deadline = gets.chomp
      deadline = nil if deadline.empty?

      print "Изменить статус? (1 - выполнено, 0 - не выполнено, оставьте пустым для пропуска): "
      status_input = gets.chomp
      status = case status_input
               when "1" then true
               when "0" then false
               else nil
               end

      edit(task_id, title: title, desc: desc, deadline: deadline, status: status)
      puts "Задача обновлена!"
    else
      puts "Задача с таким ID не найдена."
    end
  end

  def filter_tasks_menu
    puts "\n--- Фильтрация задач ---"
    puts "1. По статусу выполнения"
    puts "2. По сроку выполнения"
    print "Выберите действие: "
    filter_choice = gets.chomp.to_i

    case filter_choice
    when 1
      filter_by_status
    when 2
      filter_by_deadline
    else
      puts "Некорректный выбор фильтрации."
    end
  end

  def filter_by_status
    print "Введите статус для фильтрации (1 - выполненные, 0 - невыполненные): "
    status_choice = gets.chomp.to_i
    status = status_choice == 1

    puts "\n--- Список задач по статусу ---"
    filtered_tasks = @tasks.select { |task| task.status == status }
    if filtered_tasks.empty?
      puts "Нет задач с таким статусом."
    else
      filtered_tasks.each_with_index do |task, index|
        puts "#{index + 1}. #{task.title} - #{task.desc} (#{task.deadline}) - Статус: #{task.status ? 'Выполнена' : 'Не выполнена'}"
      end
    end
  end

  def filter_by_deadline
    print "Введите предельную дату для фильтрации (YYYY-MM-DD): "
    deadline_input = gets.chomp
    deadline_date = Date.parse(deadline_input) rescue nil

    if deadline_date.nil?
      puts "Некорректная дата. Попробуйте снова."
      return
    end

    puts "\n--- Список задач по сроку выполнения ---"
    filtered_tasks = @tasks.select { |task| Date.parse(task.deadline) <= deadline_date rescue false }
    if filtered_tasks.empty?
      puts "Нет задач с таким сроком."
    else
      filtered_tasks.each_with_index do |task, index|
        puts "#{index + 1}. #{task.title} - #{task.desc} (#{task.deadline}) - Статус: #{task.status ? 'Выполнена' : 'Не выполнена'}"
      end
    end
  end

  def show_all_tasks
    puts "\n--- Все задачи ---"
    @tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task.title} - #{task.desc} (#{task.deadline}) - Статус: #{task.status ? 'Выполнена' : 'Не выполнена'}"
    end
  end

  def save_to_file(filename = "tasks.json")
    File.open(filename, "w") do |file|
      file.write(JSON.pretty_generate(@tasks.map(&:to_h)))
    end
    puts "Задачи сохранены в файл #{filename}."
  end

  def load_from_file(filename = "tasks.json")
    if File.exist?(filename)
      file_content = File.read(filename)
      if file_content.strip.empty?
        # If the file is empty, initialize @tasks as an empty array
        @tasks = []
        # Write an empty array to the file to ensure valid JSON format
        File.write(filename, '[]')
        puts "Файл #{filename} пуст. Инициализируем пустой список задач."
      else
        begin
          tasks_data = JSON.parse(file_content, symbolize_names: true)
          @tasks = tasks_data.map do |task_data|
            Task.new(task_data[:title], task_data[:desc], task_data[:deadline], task_data[:status]).tap do |task|
              task.id = task_data[:id]
            end
          end
          puts "Задачи загружены из файла #{filename}."
        rescue JSON::ParserError => e
          # If parsing fails, initialize @tasks as an empty array
          @tasks = []
          # Write an empty array to the file to fix the invalid JSON
          File.write(filename, '[]')
          puts "Ошибка при разборе JSON из файла #{filename}: #{e.message}"
          puts "Файл поврежден. Инициализируем пустой список задач."
        end
      end
    else
      puts "Файл #{filename} не найден."
      @tasks = []
    end
  end
end
