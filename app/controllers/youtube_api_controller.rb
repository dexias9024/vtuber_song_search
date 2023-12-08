require 'google/apis/youtube_v3'

class YoutubeApiController < ApplicationController
  def main
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['API_KEY']
    
    song_id = 'LXNMkbenrpU'
    @video_info = youtube.list_videos('snippet', id: song_id).items.first.snippet
    vtuber_id = @video_info.channel_id
    @vtuber_info = youtube.list_channels('snippet', id: vtuber_id).items.first

    videos = youtube.list_searches('snippet', type: 'video', channel_id: vtuber_id, video_category_id: 10, max_results: 5)

    @music_videos = videos.items.reject { |video| live_video?(video) }

    @titles = [
      "【歌って踊ってみた】灼熱にて純情/星街すいせい(ホロライブ)【巫てんり #vtuber 】",
      "RE:I AM／Aimer covered by 戌亥とこ",
      "アイドル／YOASOBI 　Covered by 花丸はれる【推しの子】"
    ]

    vtuber = Vtuber.find_by(channel_name: @vtuber_info.snippet.title)
    if vtuber
      vtuber_id = vtuber.id
      @existing_song_urls = Song.where(vtuber_id: vtuber_id).pluck(:video_url)
      puts @existing_song_urls.inspect
    else
      puts 'Vtuber not found for the given channel title.'
    end

    @singer_names = @titles.map { |title| get_singer_name(title) }
    @song_names = @titles.map { |title| get_song_name(title) }
    @existing_song_ids = @existing_song_urls.map { |video_url| youtube_id_from_url(video_url)} 
  end

  def request_song
    vtuber = Vtuber.find_by(name: @video_info.channel_title)

    if vtuber
      song = Song.create(
        title: @video_info.title,
        url: 'https://www.youtube.com/watch?v=#{song_id}',
        description: @video_info.description,
        vtuber: vtuber
      )
    else
      
    end  
  end

  def get_singer_name(title)
    # 正規表現パターンにより歌った人の名前を抽出
    match = title.match(/(?:Covered\s+by|&#8203;``【oaicite:4】``&#8203;)\s*(.*?)(?:【|$)/i)
    
    # マッチした部分があれば取得、なければ nil を返す
    match ? match[1]&.strip : nil
  end
  
  def get_song_name(name)
    pattern = /([^\-\/\／【『』]+)(?:\s*[\-\/\／【『』]\s*Covered\s+by)?/i 
    match = name.match(pattern)
  
    match ? match[1] || '' : ''
  end

  def live_video?(video)
    video.snippet.live_broadcast_content != 'none'
  end

  def youtube_id_from_url(video_url)
    match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
    match_data[5] if match_data
  end
end
