require 'carrierwave/orm/activerecord'

class RankingsController < ApplicationController
  before_action :set_ranking, only: %i[ show edit update destroy ]
  before_action :set_power_ranking, except: :drag

  # GET /rankings or /rankings.json
  def index
    @rankings = Ranking.all
  end

  # GET /rankings/1 or /rankings/1.json
  def show
  end

  # GET /rankings/new
  def new
    @ranking = Ranking.new
    @teams = Team.all.order(team_name: :desc)
  end

  # GET /rankings/1/edit
  def edit
  end

  # POST /rankings or /rankings.json
  def create
    @ranking = Ranking.new(ranking_params)
    @ranking.user = current_user
    @ranking.rankable = @power_ranking
    @ranking.position = @power_ranking.rankings.length + 1
    @ranking.avatar = params[:ranking][:avatar].original_filename

    respond_to do |format|
      if @ranking.save
        format.html { redirect_to power_ranking_url(@power_ranking), notice: "Ranking was successfully created." }
        format.json { render :show, status: :created, location: @ranking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rankings/1 or /rankings/1.json
  def update
    respond_to do |format|
      if @ranking.update(ranking_params)
        format.html { redirect_to ranking_url(@ranking), notice: "Ranking was successfully updated." }
        format.json { render :show, status: :ok, location: @ranking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rankings/1 or /rankings/1.json
  def destroy
    @ranking.destroy

    respond_to do |format|
      format.html { redirect_to rankings_url, notice: "Ranking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def drag
    ranking = Ranking.find_by(id: params[:ranking][:id])

    ranking.insert_at(params[:ranking][:position].to_i)
    head :ok
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking
      @ranking = Ranking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ranking_params
      params.require(:ranking).permit(:id, :rank_number, :description, :team_id, :position, :power_ranking_id, :avatar)
    end

    def set_power_ranking
      @power_ranking = PowerRanking.find(params['power_ranking_id'])
    end
end
