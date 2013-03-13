class Cave::Form::Field
  attr_accessor :name, :type, :label, :help

  def initialize name, type, label=nil, help=nil
    @name, @type, @label, @help = name, type, label, help
    @label ||= name.to_s.gsub('_', ' ').capitalize
  end
end