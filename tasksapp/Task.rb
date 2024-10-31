class Task
  attr_accessor :id, :title, :desc, :deadline, :status

  @@id_counter = 1

  def initialize(title, desc, deadline, status = false)
    @id = @@id_counter
    @@id_counter += 1
    @title = title
    @desc = desc
    @deadline = deadline
    @status = status
  end

  # Метод для преобразования объекта Task в хэш
  def to_h
    {
      id: @id,
      title: @title,
      desc: @desc,
      deadline: @deadline,
      status: @status
    }
  end
end
