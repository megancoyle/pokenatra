class Team < ActiveRecord::Base
  has_many :trainers, dependent: :destroy
end
