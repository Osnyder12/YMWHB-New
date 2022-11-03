class HomesController < ApplicationController
  # skip_before_action :authorize
  before_action :set_power_ranking, only: %i[index home]
  before_action :set_last_year_power_ranking, only: %i[index home]

  def index; end
  def home; end

  def history
  end

  private

  def set_power_ranking
    @power_ranking = PowerRanking.where(year: Date.today.year).last
  end
  
  def set_last_year_power_ranking
    @last_year = Date.today.year - 1
    @last_year_power_ranking = PowerRanking.find_by(year: @last_year)
  end
end