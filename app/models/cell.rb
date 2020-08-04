class Cell < ApplicationRecord
  belongs_to :game

  def around_cells()
    pos_x = x - 1
    pos_y = y - 1
    pos1 = game.cells.find_by(x: pos_x, y: pos_y)
    pos2 = game.cells.find_by(x: pos_x + 1, y: pos_y)
    pos3 = game.cells.find_by(x: pos_x + 2, y: pos_y)
    pos4 = game.cells.find_by(x: pos_x, y: pos_y + 1)
    #pos5 = game.cells.find_by(x: pos_x + 1, y: pos_y + 1)
    pos6 = game.cells.find_by(x: pos_x + 2, y: pos_y + 1)
    pos7 = game.cells.find_by(x: pos_x, y: pos_y + 2)
    pos8 = game.cells.find_by(x: pos_x + 1, y: pos_y + 2)
    pos9 = game.cells.find_by(x: pos_x + 2, y: pos_y + 2)

    return [pos1, pos2, pos3, pos4, pos6, pos7, pos8, pos9]
  end

  def reveal
    if valor == "bomb"
      return false
    elsif valor.match /[1|2|3|4|5|6|7|8]/
       self.update(is_revealed: true)
      return true
    else
      self.update(is_revealed: true) unless self.is_revealed
      around_cells.each do |c|
        c&.reveal if c.present? && !c.is_revealed
      end
      return true
    end
  end

  
end
