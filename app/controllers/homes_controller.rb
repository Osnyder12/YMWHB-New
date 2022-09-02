class HomesController < ApplicationController
  # skip_before_action :authorize
  before_action :set_power_ranking, only: %i[index]

  def index; end

  private

  def set_power_ranking
    @power_ranking = PowerRanking.where(year: Date.today.year).last
  end
end