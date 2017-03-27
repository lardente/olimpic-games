class Stat < ApplicationRecord
  extend Enumerize

  enumerize :unit, in: [:s, :m]

  belongs_to :competition
  belongs_to :athlete

  validates_presence_of :athlete, :competition, :value, :metric
  validate :number_of_results_dash, if: proc { |r| r.competition_id? && r.athlete_id? }
  validate :number_of_results_dart, if: proc { |r| r.competition_id? && r.athlete_id? }
  validate :can_add_result?, if: proc { |r| r.competition_id? }

  def number_of_results_dart
    errors.add(:athlete, :too_many_darts) if competition.results.where(athlete: athlete).size >= 3 && competition.dart?
  end

  def can_add_result?
    errors.add(:competition, :finished) if competition.finished?
  end

end
