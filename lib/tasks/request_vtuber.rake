require 'google/apis/youtube_v3'
require_relative '../../lib/tasks/request_helper'
using RequestHelper

namespace :request_vtuber do
  desc 'Request vtuber'
  task run: :environment do
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    
    requests = Request.where(category: Request.categories['Vtuber']).limit(20)

    requests.each do |request|
      song_id = youtube_id_from_url(request.url)
      video_info = youtube.list_videos('snippet', id: song_id).items.first.snippet
      vtuber_id = video_info.channel_id
      vtuber_info = youtube.list_channels('snippet', id: vtuber_id).items.first
      match_name = video_info.channel_title
      song_names = Song.where.not(name: nil).pluck(:name)

      if request.member_name.present?
        member = Member.find_by(name: request.member_name)
        if member
          member_id = member.id
        else
          new_member = Member.new(name: request.member_name)
          new_member.save
          member_id = new_member.id
        end
      else
        member_id = Member.order(:id).first&.id
      end

      vtuber = Vtuber.find_or_initialize_by(channel_name: vtuber_info.snippet.title)
      if vtuber.persisted?
        request.destroy
        next
      end

      if request.name.present?
        vtuber_name = request.name
      else
        vtuber_name = title_vtuber_name(vtuber_info.snippet.title)
      end

      music_videos = youtube.list_searches('snippet', type: 'video', channel_id: vtuber_id, video_category_id: 10, max_results: 50).items

      existing_song_urls = Song.where(vtuber_id: vtuber.id).pluck(:video_url) if vtuber
      existing_song_ids = existing_song_urls.map { |video_url| youtube_id_from_url(video_url)} 

      vtuber = Vtuber.new(
        channel_name: vtuber_info.snippet.title,
        channel_url: "https://www.youtube.com/#{vtuber_info.snippet.custom_url}",
        name: vtuber_name,
        icon: vtuber_info.snippet.thumbnails.default.url,
        instrument_id: request.instrument_ids,
        overview: vtuber_info.snippet.description,
        member_id: member_id
      )
      if vtuber.save
        songs_to_create = music_videos.reject do |video|
          existing_song_ids.include?(video.id.video_id) || video.snippet.title.downcase.include?('歌枠') || 
                                                          video.snippet.title.downcase.include?('弾き語り') || 
                                                          video.snippet.title.downcase.include?('歌配信')
        end.map do |video|
          artist = original_song_artist(get_artist_name(video.snippet.title))
          {
            title: video.snippet.title,
            cover: cover_or_original(video.snippet.title),
            name: shorts_name?(video.snippet.title, song_names),
            artist_name: title_shorts?(artist, vtuber),
            vtuber_id: match_vtuber(match_name),
            video_url: "https://www.youtube.com/watch?v=#{video.id.video_id}"
          }
        end

        Song.create!(songs_to_create)
        request.destroy
      end
    end
  end
end
