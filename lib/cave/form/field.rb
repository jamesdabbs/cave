class Cave::Form::Field
  attr_accessor :type

  def initialize name, type, label=nil, help=nil
    @name = name
    @type = type
    @help = help
    @label ||= name.to_s.gsub('_', ' ').capitalize
  end
end