
class Player
  attr_accessor :is_white, :is_checked
  def initialize(is_white)
    @is_white = is_white
    @is_checked = false
  end
end