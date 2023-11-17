require 'carrierwave/orm/activerecord'

class RankingsController < ApplicationController
  before_action :set_ranking, only: %i[ show edit update destroy ]
  before_action :set_team_name, only: %i[ create ]
  before_action :set_power_ranking, except: :drag
  before_action :set_teams, only: %i[new create]

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
    @ranking.rank_number = @ranking.position
    avatar_file = params[:ranking][:avatar]&.original_filename

    if avatar_file.present?
      if avatar_file.match(/\s/).present?
        avatar_file = avatar_file.gsub(" ", "_")
      end
    end

    @ranking.avatar = avatar_file 

    respond_to do |format|
      if @ranking.save
        format.html { redirect_to edit_power_ranking_url(@power_ranking), notice: "Ranking was successfully created." }
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
        format.html { redirect_to edit_power_ranking_url(@power_ranking), notice: "Ranking was successfully updated." }
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
      format.html { redirect_to edit_power_ranking_path(@power_ranking), notice: "Ranking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def drag
    ranking = Ranking.find_by(id: params[:ranking][:id])

    new_position = params[:ranking][:position].to_i + 1

    ranking.insert_at(new_position)

    head :ok
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking
      @ranking = Ranking.find_by(id: params[:id])
    end

    def set_team_name
      @team_name = Team.find_by(id: ranking_params[:team_id]).team_name
    end

    def set_teams
      @teams = Team.all.order(team_name: :desc)
    end

    # Only allow a list of trusted parameters through.
    def ranking_params
      params.require(:ranking).permit(:id, :rank_number, :description, :team_id, :position, :power_ranking_id, :avatar)
    end

    def set_power_ranking
      @power_ranking = PowerRanking.find_by(id: params['power_ranking_id'])
    end
end
