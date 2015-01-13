module ApplicationHelper

	def fix_url(url)
		url.starts_with?("http://") || url.starts_with?("https://") ? url : "http://#{url}"
	end

	def fix_date_time(time)
		time.strftime("%B %d, '%y at %I:%M%p")
	end

	def already_voted_on?(this_object)
		this_object.votes.where(user_id: current_user.id).any?
	end

		#2015-01-05 16:24:27.342880
		#%B %d, '%y at %I:%M%p
end

