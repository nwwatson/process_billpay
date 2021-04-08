# frozen_string_literal: true

class ListItem
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end
