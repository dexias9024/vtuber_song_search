require 'google/apis/youtube_v3'
require_relative '../../lib/tasks/request_helper'
using RequestHelper

namespace :request_song do
  desc 'Request song'
  task run: :environment do
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    
    requests = Request.where(category: Request.categories['歌']).limit(100)

    requests.each do |request|
      song_id = youtube_id_from_url(request.url)
      video_info = youtube.list_videos('snippet', id: song_id).items.first&.snippet
      match_name = video_info.channel_title
      song_names = Song.pluck(:name)

      vtuber = Vtuber.find_by(channel_name: video_info.channel_title)

      unless vtuber
        request.destroy
        next
      end

      existing_song_urls = Song.where(vtuber_id: vtuber.id).pluck(:video_url) if vtuber
      existing_song_ids = existing_song_urls.map { |url| youtube_id_from_url(url) }

      if existing_song_ids.include?(song_id)
        request.destroy
        next
      end
      artist = original_song_artist(get_artist_name(video_info.title))

      Song.create!(
            title: video_info.title,
            cover: cover_or_original(video_info.title),
            name: shorts_name?(video.snippet.title, song_names),
            artist_name: title_shorts?(artist, vtuber),
            vtuber_id: match_vtuber(match_name),
            video_url: "https://www.youtube.com/watch?v=#{song_id}"
          )
      request.destroy
    end
  end
end
