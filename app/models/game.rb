class Game < ApplicationRecord
  has_many :cells, dependent: :destroy
end
