class Athlete < ApplicationRecord

  has_many :competitions, -> { uniq }, through: :stats
  has_many :stats

  validates_presence_of :name
  validates_uniqueness_of :name

end
