class Book < ActiveRecord::Base
	has_many :words, dependent: :destroy
end
