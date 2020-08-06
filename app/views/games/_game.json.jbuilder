json.extract! game, :id, :rows, :columns, :mines, :created_at, :updated_at, :status, :email, :time_spent
json.url game_url(game, format: :json)

json.cells game.cells do |c|
  json.x c.x
  json.y c.y
  json.valor c.valor
  json.is_revealed c.is_revealed
  json.status c.status
end
