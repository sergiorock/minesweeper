class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_game, only: [:show, :edit, :update, :destroy, :reveal, :flag]

  # GET /games
  # GET /games.json
  def index
    if params[:email].present?
      @games = Game.where('email ILIKE ?', "%#{params[:email]}%")
    else
      @games = Game.all.order(id: :desc)
    end
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
      @game.update(time_spent: TimeDifference.between(@game.created_at, @game.finalized_at).in_minutes)
      @game.cells.update_all(is_revealed: :true)
      respond_to do |format|
        format.html { redirect_to @game, notice: 'Perdiste' }
        format.json { render json: @game.as_json(include: :cells), status: :ok}
      end
    else
      cell.reveal
      cells_amount = @game.cells.size
      bombs_amount = @game.cells.where(valor: :'bomb').size
      cells_revealed_amount = @game.cells.where(is_revealed: :true).size

      if cells_amount - bombs_amount == cells_revealed_amount
        @game.update(status: :'won', finalized_at: DateTime.now)
        @game.update(time_spent: TimeDifference.between(@game.created_at, @game.finalized_at).in_minutes)
  
        respond_to do |format|
          format.html { redirect_to @game, notice: 'Ganaste' }
          format.json { render json: @game.as_json(include: :cells), status: :ok}
        end
      else
        respond_to do |format|
          format.html { redirect_to @game, notice: 'Zafaste' }
          format.json { render json: @game.as_json(include: :cells), status: :ok}
        end
      end
    end
  end

  def flag
    x = params[:x]
    y = params[:y]
    status = params[:status]

    cell = @game.cells.find_by(x: x, y: y)

    if cell.status == status
      cell.update(status: :'')

      respond_to do |format|
        format.html { redirect_to @game, notice: 'Limpiaste una celda' }
        format.json { render json: @game.as_json(include: :cells), status: :ok}
      end

    else
      cell.update(status: status)

      if cell.status == 'flag'
        respond_to do |format|
          format.html { redirect_to @game, notice: 'Flagueaste una celda' }
          format.json { render json: @game.as_json(include: :cells), status: :ok}
        end
      else
        respond_to do |format|
          format.html { redirect_to @game, notice: 'Marcaste una celda' }
          format.json { render json: @game.as_json(include: :cells), status: :ok}
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
      params.require(:game).permit(:email, :rows, :columns, :mines, :time_spent)
    end
end
