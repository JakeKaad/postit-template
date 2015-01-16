class User < ActiveRecord::Base
	include Sluggable

	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, length: {minimum: 6}, on: :create
	validates_confirmation_of :password

	sluggable_column :username

	def admin?
		self.role == 'admin'
	end
end