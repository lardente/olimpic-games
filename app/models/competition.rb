class Competition < ApplicationRecord
  extend Enumerize

  has_many :results, dependent: :destroy
  has_many :athletes, -> { uniq }, through: :results

  enumerize :type, in: [:dart, :run], predicates: true

  validates_presence_of :name, :type
  validates_uniqueness_of :name
  validate :can_end_competition, if: :active, unless: :run

  def finish
    self.active = false
  end

  def ordered_stats
    unordered = {}
    athletes.each do |athlete|
      unordered = unordered.merge(athlete.name => athlete.results.where(competition: self).maximum(:value))
    end

    dart? ? unordered.sort_by { |_k, v| v }.reverse.to_h : unordered.sort_by { |_k, v| v }.to_h
  end

  def can_finish
    errors.add(:active, :cannot_end) if results.count < athletes.count * 3
  end

  def rank
    rank = {}
    ordered_stats.each_with_index do |hash, i|
      rank = rank.merge(i + 1 => { name: hash[0], value: hash[1], metric: rank_metric})
    end
    rank
  end

  def build_rank_hash
    {
      competition: name,
      finished: finished,
      rank: rank
    }.to_json
  end

  def rank_metric
    stats.first.metric_text
  end
end
