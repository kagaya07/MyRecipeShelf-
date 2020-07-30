class Recipe < ApplicationRecord
	belongs_to :user
	belongs_to :genre
	has_many :comments
	has_many :favorites
	has_many :mterials, dependent: :destroy
	has_many :cooks, dependent: :destroy
	accepts_nested_attributes_for :cooks, allow_destroy: true
	accepts_nested_attributes_for :mterials, allow_destroy: true
	attachment :image
end
