class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	has_many :votes, through :voteable

	validates :body, presence: true
end