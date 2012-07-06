module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "#{gravatar_id}"
		if(File.exists?(gravatar_url))
			image_tag(gravatar_url, :alt => user.name, :class => "gravatar")
		else
			image_tag("no_profile_pic.jpg", :alt => user.name, :class => "gravatar")
		end
	end
end
