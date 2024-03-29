require 'rails_helper'

RSpec.describe 'Song', type: :model do
  context "Songを作ることができる" do
    it "1-1.title, video_url, cover, vtuber_idがある場合、有効である" do
      song = build(:song)
      expect(song).to be_valid
    end
    
    it '1-2.titleがない場合、無効である' do
      song = build(:song, title: nil)
      song.valid?
      expect(song.errors[:title]).to include("を入力してください")
    end

    it '1-3.video_urlがない場合、無効である' do
      song = build(:song, video_url: nil)
      song.valid?
      expect(song.errors[:video_url]).to include("を入力してください")
    end

    it '1-4.coverがない場合、無効である' do
      song = build(:song, cover: nil)
      song.valid?
      expect(song.errors[:cover]).to include("を入力してください")
    end

    it '1-5.vtuber_idがない場合、無効である' do
      song = build(:song, vtuber: nil)
      song.valid?
      expect(song.errors[:vtuber]).to include("を入力してください")
    end

    it '1-6.重複した動画URLの場合、無効である' do
      vtuber = create(:vtuber, name: 'test')
      song1 = create(:song, video_url: 'https://www.youtube.com/test', vtuber: vtuber)
      song2 = Song.build(title: 'test', 
                         video_url: 'https://www.youtube.com/test', 
                         cover: 'cover', 
                         vtuber: vtuber
                        )
      song2.valid?
      expect(song2.errors[:video_url]).to include("はすでに存在します")
    end
  end

  describe 'songの検索' do
    it '2-1.検索結果に一致するものだけ取得する' do
      song1 = create(:song, title: 'test1')
      song2 = create(:song, title: 'test2')

      search_params = ['test1']
      results = Song.search_by_title_name_artist(search_params)

      expect(results).to include(song1)
      expect(results).not_to include(song2)
    end
  end
end