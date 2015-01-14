class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password

	before_save :generate_slug!

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, length: {minimum: 6}, on: :create
	validates_confirmation_of :password

	def generate_slug!
		the_slug = to_slug(self.username)
		user = User.find_by slug: the_slug
		count = 2
		while user && user != self
			the_slug = append_suffix(the_slug, count)
			user = User.find_by slug: the_slug
			count +=1
		end
		self.slug = the_slug.downcase
	end

	def to_slug(name)
		the_slug = name.strip
		the_slug.gsub!(/\s*[^A-Za-z0-9]\s*/, '-').gsub!(/-+/, '-')
		the_slug.downcase
	end

	def append_suffix(slug, count)
		unless slug.split('-').last.to_i == 0
			return slug.split('-').slice(0...-1).join('-') + '-' + count.to_s
		else
			return slug + '-' + count.to_s
		end
	end

	def to_param
		self.slug
	end
end