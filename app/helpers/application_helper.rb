module ApplicationHelper

	def fix_url(url)
		url.starts_with?("http://") ? url : "http://#{url}"
	end

	def fix_date_time(time)
		time.strftime("%B %d, '%y at %I:%M%p")
	end


		#2015-01-05 16:24:27.342880
		#%B %d, '%y at %I:%M%p
end

