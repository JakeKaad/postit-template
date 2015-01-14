class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, through: :post_categories

	before_save :generate_slug!

	validates :name, presence: true

	def to_param
		self.slug
	end

	def generate_slug!
		the_slug = to_slug(self.name)
		category = Category.find_by slug: the_slug
		count = 2
		while category && category != self
			the_slug = append_suffix(the_slug, count)
			category = Category.find_by slug: the_slug
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


end