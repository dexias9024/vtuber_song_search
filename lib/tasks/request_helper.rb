module RequestHelper
  refine Object do

    def title_vtuber_name(title)
      split_result = title.split(/#{Regexp.escape("ch.")}/i, 2)[1]&.strip
      split_result = split_result ? split_result&.split(/[-\[\{「【『]/)[0]&.strip : title
      name = split_result&.split(/[-\/／]/).first.strip
    end
    
    def youtube_id_from_url(video_url)
      match_data = video_url.match(%r{(http(s|):|)//(www\.|)youtube\.com/(embed/|watch.*?v=|)([a-zA-Z0-9\-_]{11})}i)
      match_data[5] if match_data
    end
    
    def get_song_name(name)
      pattern = /([^\/\／『』]+)(?:\s*[\/\／『』]\s*Covered\s+by)?/i
      second_pattern = /】([^】]+)/
      match = name.match(pattern)
    
      first_result = match[1]&.strip || ''
    
      second_match = first_result.match(second_pattern)
      second_result = second_match ? second_match[1]&.strip : first_result
      result = second_result.gsub(/(cover|歌ってみた|#shorts|\[|\]|\(|\)|（|）‍|\.)/i, '').strip
      
      result
    end
    
    def get_artist_name(name)
      match = name.match(/(?:Covered\s+by|&#8203;``【oaicite:4】``&#8203;)\s*(.*?)(?:【|$)/i)
      result = (match ? match[1] : name).gsub(/(cover|歌ってみた|\[|\]|\(|\)|（|）‍|【|】|\.)/i, '').strip
      result
    end
    
    def original_song_artist(name)
      if name.length >= 10
        right_part = name.split(/\/|／/).last
        right_part.sub!(/[\(,{,【].*|[|【】\(\)（）‍|]/, '')
    
        result = right_part.strip
      else
        result = name
      end
      result
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
      if title.downcase.include?('#shorts') || title.downcase.include?('踊ってみた') || title.downcase.include?('#')
        result = vtuber.name
      else
        result = title
      end
      result
    end

    def shorts_name?(title, song_names)
      matching_name = song_names.find { |name| title.include?("#short") && title.include?(name) }

      result = matching_name || get_song_name(title)
      result
    end

  end
end