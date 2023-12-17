module Admin::BaseHelper
  def youtube_id_from_url(video_url)
    match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
    match_data[5] if match_data
  end
end
