class Api::V1::StatsController < ActionController::API

  def index
    stats = Stat.all
    render json: stats
  end

  def create
    respond_with :api, :v1, competition.results.create({ athlete: athlete }.merge(result_params.except('competition', 'athlete')))
  end

  def find_competition
    competition = Competition.find_by_name!(result_params['competition'])
  end

  def find_athlete
    athlete = Athlete.find_or_create_by!(name: result_params['athlete'])
  end

  def result_params
    params.require(:result).permit(:competition, :athlete, :value, :metric)
  end
end
