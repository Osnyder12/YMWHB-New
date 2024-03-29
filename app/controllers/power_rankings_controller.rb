require 'carrierwave/orm/activerecord'

class PowerRankingsController < ApplicationController
  before_action :set_power_ranking, only: %i[ show edit update destroy ]
  before_action :set_rankings, only: %i[ edit show ]
  before_action :authorize, only: %i[ new edit ]
  before_action :set_last_week_and_year, only: %i[new create]

  def index
    @power_rankings = PowerRanking.all.order(week: :desc)
  end

  def show
    # dont show it unless you're the owner or its published
    unless @power_ranking.user_id == current_user&.id || @power_ranking.published
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
      end
    end
  end

  def new
    @power_ranking = PowerRanking.new
  end

  def edit; end

  def create
    @power_ranking = PowerRanking.new(power_ranking_params)

    @power_ranking.user_id = current_user&.id
    avatar_file = params[:power_ranking][:avatar]&.original_filename

    if avatar_file&.match(/\s/)&.present?
      avatar_file = avatar_file.gsub(" ", "_")
    end

    @power_ranking.avatar = avatar_file

    respond_to do |format|
      if @power_ranking.save
        format.html { redirect_to power_ranking_url(@power_ranking), notice: "Power ranking was successfully created." }
        format.json { render :show, status: :created, location: @power_ranking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @power_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    puts power_ranking_params
    respond_to do |format|
      if @power_ranking.update(power_ranking_params)
        format.html { redirect_to power_ranking_url(@power_ranking), notice: "Power ranking was successfully updated." }
        format.json { render :show, status: :ok, location: @power_ranking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @power_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @power_ranking.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Power ranking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def years
    power_ranking_years = PowerRanking.where(published: true)
                                      .or(PowerRanking.where(user_id: current_user&.id))
                                      .pluck(:year)
                                      .uniq.sort.reverse

    @power_rankings = power_ranking_years.map do |year|
      PowerRanking.find_by(year: year)
    end
  end

  def weeks
    @year = params[:year]

    @power_rankings = PowerRanking.where(published: true)
                                  .or(PowerRanking.where(user_id: current_user&.id))
                                  .where(year: @year)
                                  .order(:week).reverse

    if @power_rankings.empty?
      respond_to do |format|
        format.html { redirect_to power_rankings_years_url }
        format.json { head :no_content }
      end
    end
  end

  private

    def set_power_ranking
      @power_ranking = PowerRanking.find(params[:id])
    end

    def set_last_week_and_year
      last_weeks_pr = PowerRanking.where(year: Date.today.year).last

      @last_weeks_pr_year = last_weeks_pr.present? ? last_weeks_pr.year : Date.today.year
      @last_weeks_pr_week = last_weeks_pr.present? ? last_weeks_pr&.week + 1 : 1
    end

    def power_ranking_params
      params.require(:power_ranking).permit(:id, :week, :year, :title, :introduction_paragraph, :type, :avatar, :published)
    end

    def set_rankings
      @rankings = @power_ranking.rankings.order(:position)
    end
end
