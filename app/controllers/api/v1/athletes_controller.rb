class Api::V1::AthletesController < ActionController::API

  def index
    athletes = Athlete.all
    render json: athletes
  end
end
