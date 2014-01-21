class TodoList
  def self.parse(text)
    tasks = text.split("\n").map { |row| row.split(/\s+\|\s*/) }
                            .map { |task| Task.new(task) }
    TodoList.new(tasks)
  end

  include Enumerable
  attr_reader :tasks

  def initialize(tasks)
    @tasks = tasks
  end

  def each(&block)
    @tasks.each { |task| block.call task }
  end

  def filter(filter)
    TodoList.new tasks.select { |task| filter.met_by? task }
  end

  def adjoin(todo_list)
    TodoList.new((tasks + todo_list.tasks).uniq)
    
  end

  def tasks_todo
    map { |task|  task.status == :todo }.count(true)
  end

  def tasks_in_progress
     map { |task|  task.status == :current }.count(true)
  end

  def tasks_completed
    map { |task|  task.status == :done }.count(true)
  end

  def completed?
    count == tasks_completed
  end
end

class Criteria

  attr_reader :matcher
  def initialize(&block)
    @matcher = block
  end

  def met_by?(task)
    @matcher.call task
  end

  def &(other)
    Criteria.new { |task| met_by?(task) and other.met_by?(task) }
  end

  def |(other)
    Criteria.new { |task| met_by?(task) or other.met_by?(task) }
  end

  def !
    Criteria.new { |task| not met_by?(task) }
  end

  def self.status(status)
    Criteria.new{ |task| task.status == status }
  end

  def self.priority(priority)
    Criteria.new{ |task| task.priority == priority }
  end

  def self.tags(tags)
    Criteria.new{ |task| (tags & task.tags.to_a).eql?(tags)  }
  end
end

class Task
  attr_reader :status, :description, :priority, :tags

  def initialize(task_fields)
    @status = task_fields[0].strip.downcase.to_sym
    @description = task_fields[1].strip.to_s
    @priority = task_fields[2].strip.downcase.to_sym
    @tags = task_fields[3].split(", ") if task_fields[3]
  end
end