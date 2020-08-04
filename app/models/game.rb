class Game < ApplicationRecord
  has_many :cells, dependent: :destroy
  after_create :start

  def start
    bombs = get_bombs(rows, columns, mines)
    for i in 1..rows
      for j in 1..columns
        puts "Checking if #{bombs} has x#{i}y#{j}"
        val = nil
        val = "bomb" if bombs.include? "x#{i}y#{j}"
        self.cells.create!(x: i, y: j, valor: val)
      end
    end

    self.cells.each do |cell|
      if !(cell.valor == "bomb" )
        num = nil
        num = cell.around_cells.map { |cel| true if cel&.valor == "bomb" }.compact.size
        cell.update(valor: num)
      end
    end
  end


  private
  def get_bombs(x, y, amount)
    bombs = []

    while bombs.size < amount
      new_bomb = get_bomb(x, y)
      unless bombs.include? new_bomb
        bombs << new_bomb
      end
    end
    return bombs
  end

  def get_bomb(x, y)
    pos_x = rand(1..x)
    pos_y = rand(1..y)
    return "x#{pos_x}y#{pos_y}"
  end

  def string_cell(pos_x, pos_y)
    return "x#{pos_x}y#{pos_y}"
  end
  
end
