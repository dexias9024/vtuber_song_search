require 'google/apis/youtube_v3'

namespace :request_song do
  desc 'Request song'
  task run: :environment do
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['YOUTUBE_API_KEY']
    
    requests = Request.where(category: Request.categories['歌']).limit(20)

    requests.each do |request|
      song_id = youtube_id_from_url(request.url)
      video_info = youtube.list_videos('snippet', id: song_id).items.first&.snippet
      match_name = video_info.channel_title

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
            name: get_song_name(video_info.title),
            artist_name: title_shorts?(artist, vtuber),
            vtuber_id: match_vtuber(match_name),
            video_url: "https://www.youtube.com/watch?v=#{song_id}"
      )
      request.destroy
    end
  end
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
    result = matched_part.gsub(/[|【|】|]/, '').strip
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
  if title.downcase.include?('オリジナル曲') || title.downcase.include?('original song') || title.downcase.include?('official')
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

def youtube_id_from_url(video_url)
  match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
  match_data[5] if match_data
end