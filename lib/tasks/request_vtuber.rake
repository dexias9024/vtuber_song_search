require 'google/apis/youtube_v3'

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
            name: get_song_name(video.snippet.title),
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

def title_vtuber_name(title)
  split_result = title.split(/#{Regexp.escape("ch.")}/i, 2)[1]&.strip
  split_result = split_result ? split_result&.split(/[-\[\{「【『]/)[0]&.strip : title
  name = split_result&.split(/[-\/／]/).first.strip
  name
end

def youtube_id_from_url(video_url)
  match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
  match_data[5] if match_data
end

def get_song_name(name)
  pattern = /([^\-\/\／【『』]+)(?:\s*[\-\/\／【『』]\s*Covered\s+by)?/i 
  match = name.match(pattern)

  match ? match[1]&.strip || '' : ''
end

def get_artist_name(name)
  match = name.match(/(?:Covered\s+by|&#8203;``【oaicite:4】``&#8203;)\s*(.*?)(?:【|$)/i)
  if match.nil?
    result = name
  else
    matched_part = match[1].strip
    result = matched_part.gsub(/[|【|】|]/, '')
  end
  result
end

def original_song_artist(name)
  if name.length >= 10
    right_part = name.split(/\/|／/).last
    right_part.sub!(/[\(,{,【].*/, '')
    right_part.sub!(/[|【|】|]/, '')

    right_part.strip
  else
    name
  end
end

def match_vtuber(vtuber_name)
  vtuber = Vtuber.find_by(channel_name: vtuber_name)
  vtuber_id = vtuber&.id
  vtuber_id
end

def cover_or_original(title)
  if title.downcase.include?('official髭男dism')
    'cover'
  elsif title.downcase.include?('オリジナル曲') || title.downcase.include?('original song') || title.downcase.include?('official')
    'original'
  else
    'cover'
  end
end

def title_shorts?(title, vtuber)
  if title.downcase.include?('shorts') || title.downcase.include?('踊ってみた')
    vtuber.name
  else
    get_song_name(title)
  end
end