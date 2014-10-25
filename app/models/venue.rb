class Venue < ActiveRecord::Base
	belongs_to :college
	has_many :meals
end
