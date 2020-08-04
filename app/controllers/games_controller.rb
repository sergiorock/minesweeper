class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :reveal]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reveal
    x = params[:x]
    y = params[:y]
    cell = @game.cells.find_by(x: x, y: y)

    if cell.valor == "bomb"
      @game.update(status: :'lost', finalized_at: DateTime.now)
      @game.cells.update_all(is_revealed: :true)
      respond_to do |format|
        format.html { redirect_to @game, notice: 'Perdiste' }
        format.json { render json: @game, status: :ok}
      end
    else
      cell.reveal
      cells_amount = @game.cells.size
      bombs_amount = @game.cells.where(valor: :'bomb').size
      cells_revealed_amount = @game.cells.where(is_revealed: :true).size

      if cells_amount - bombs_amount == cells_revealed_amount
        @game.update(status: :'won', finalized_at: DateTime.now)

        respond_to do |format|
          format.html { redirect_to @game, notice: 'Ganaste' }
          format.json { render json: @game, status: :ok}
        end
      else
        respond_to do |format|
          format.html { redirect_to @game, notice: 'Zafaste' }
          format.json { render json: @game, status: :ok}
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:rows, :columns, :mines)
    end
end