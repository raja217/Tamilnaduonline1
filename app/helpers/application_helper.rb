
module ApplicationHelper
	def get_stylesheets
    @direction =  'stylesheets/'
    stylesheets = [] unless stylesheets
    ["#{@direction}#{controller.controller_path}/#{controller.action_name}"].each do |ss|
      stylesheets << ss
    end
    #plugin_css_overrides = FedenaPlugin::CSS_OVERRIDES["#{controller.controller_path}_#{controller.action_name}"]
    #stylesheets << plugin_css_overrides.collect{|p| "#{@direction}plugin_css/#{p}"}
  end
  def youtube_embed(youtube_url)
  	if youtube_url[/youtu\.be\/([^\?]*)/]
    	youtube_id = $1
  	else
    	# Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
    	youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
    	youtube_id = $5
  	end

  	%Q{<iframe title="YouTube video player" width="360" height="260" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end

  

end
