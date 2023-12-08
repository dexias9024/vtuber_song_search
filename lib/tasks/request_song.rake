require 'google/apis/youtube_v3'

namespace :request_song do
  desc 'Request song'
  task run: :environment do
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['API_KEY']
    
    song_id = 'JRYdJA-QsVI'
    @video_info = youtube.list_videos('snippet', id: song_id).items.first.snippet
    vtuber_id = @video_info.channel_id
    match_name = @video_info.channel_title

    @vtuber_info = youtube.list_channels('snippet', id: vtuber_id).items.first
    vtuber = Vtuber.find_by(channel_name: @vtuber_info.snippet.title)

    unless vtuber
      return
    end

    @music_videos = youtube.list_searches('snippet', type: 'video', channel_id: vtuber_id, video_category_id: 10, max_results: 5).items

    existing_song_urls = Song.where(vtuber_id: vtuber.id).pluck(:video_url) if vtuber
    existing_song_ids = existing_song_urls.map { |video_url| youtube_id_from_url(video_url)} 

    @music_videos.each do |video|
      video_id = video.id.video_id
      next if existing_song_ids.include?(video_id)
      artist = original_song_artist(get_artist_name(video.snippet.title))

      Song.create!(
        title: video.snippet.title,
        cover: cover_or_original(video.snippet.title),
        name: get_song_name(video.snippet.title),
        artist_name: artist,
        vtuber_id: match_vtuber(match_name),
        video_url: "https://www.youtube.com/watch?v=#{video_id}"
      )
    end
  end
end

def get_song_name(name)
  pattern = /([^\-\/\／【『』]+)(?:\s*[\-\/\／【『』]\s*Covered\s+by)?/i 
  match = name.match(pattern)

  match ? match[1] || '' : ''
end

def get_artist_name(name)
  match = name.match(/(?:Covered\s+by|&#8203;``【oaicite:4】``&#8203;)\s*(.*?)(?:【|$)/i)

  match ? match[1] : name
end

def original_song_artist(name)
  if name.length >= 10
    right_part = name.split(/\/|／/).last
    right_part.sub!(/[\(,{,【].*/, '')

    return get_artist_name(right_part)
  else
    return name
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

def youtube_id_from_url(video_url)
  match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
  match_data[5] if match_data
end