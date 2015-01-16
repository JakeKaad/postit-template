module ApplicationHelper

	def fix_url(url)
		url.starts_with?("http://") || url.starts_with?("https://") ? url : "http://#{url}"
	end

	def fix_date_time(time)
		if logged_in? && !current_user.time_zone.blank?
			time = time.in_time_zone(current_user.time_zone)
		end
		time.strftime("%B %d, '%y at %I:%M%p %Z")
	end

	def already_voted_on?(this_object)
		this_object.votes.where(user_id: current_user.id).any?
	end

end

