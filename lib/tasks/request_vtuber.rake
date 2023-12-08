require 'google/apis/youtube_v3'

namespace :request_vtuber do
  desc 'Request vtuber'
  task run: :environment do
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    
    song_id = 'JRYdJA-QsVI'
    video_info = youtube.list_videos('snippet', id: song_id).items.first.snippet
    vtuber_id = video_info.channel_id
    vtuber_info = youtube.list_channels('snippet', id: vtuber_id).items.first

    default_member = Member.order(:id).first&.id
    Rails.logger.debug "vtuber_info#{vtuber_info}"

    #のちにrequestsテーブルのvtuberを選択されたデータから取得して処理します

    vtuber = Vtuber.find_or_initialize_by(channel_name: vtuber_info.snippet.title)
    if vtuber.persisted?
      exit
    end

    vtuber = Vtuber.new(
      channel_name: vtuber_info.snippet.title,
      channel_url: "https://www.youtube.com/#{vtuber_info.snippet.custom_url}",
      name: vtuber_name(vtuber_info.snippet.title),
      icon: vtuber_info.snippet.thumbnails.default.url,
      instrument_id: nil,
      overview: vtuber_info.snippet.description,
      member_id: default_member
    )
    if vtuber.save
      Rails.logger.debug "vtuber saved successfully"
    else
      Rails.logger.debug "vtuber save failed: #{vtuber.errors.full_messages}"
    end
  end
end

def vtuber_name(title)
  split_result = title.split(/#{Regexp.escape("ch.")}/i, 2)[1]&.strip
  split_result = split_result ? split_result&.split(/[-\[\{「【『]/)[0]&.strip : title
  name = split_result&.split(/[-\/／]/).first
  name
end

def youtube_id_from_url(video_url)
  match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
  match_data[5] if match_data
end
