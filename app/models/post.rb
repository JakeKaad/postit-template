class Post < ActiveRecord::Base
	include Voteable
	
	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :votes, as: :voteable

	before_save :generate_slug!

	validates :title, presence: true, length: {minimum: 5}
	validates :url, presence: true, uniqueness: true
	validates :description, presence: true


	def generate_slug!
		the_slug = to_slug(self.title)
		post = Post.find_by slug: the_slug
		count = 2
		while post && post != self
			the_slug = append_suffix(the_slug, count)
			post = Post.find_by slug: the_slug
			count += 1
		end
		self.slug = the_slug.downcase
	end

	def to_slug(name)
		slug = name.strip
		slug.gsub!(/\s*[^A-Za-z0-9]\s*/, '-').gsub!(/-+/, '-')
		slug.downcase
	end

	def append_suffix(slug, count)
		unless slug.split('-').last.to_i == 0
			return slug.split('-').slice(0...-1).join('-') + ('-') + count.to_s
		else
			return slug + '-' + count.to_s
		end
	end

	def to_param
		self.slug
	end

end