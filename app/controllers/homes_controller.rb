class HomesController < ApplicationController
  # skip_before_action :authorize

  def index
    @current_user = current_user
  end
end