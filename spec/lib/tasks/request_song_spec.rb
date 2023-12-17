require 'rake_helper'

describe 'request_songのテスト' do
  subject(:song_task) { Rake.application['request_song:run'] }

  before do
    song = create(:request, :song)
    member = create(:member)
  end

  it 'request_songで曲データが1つ作れることを確認' do
    create(:vtuber, :request)
    expect { song_task.invoke }.not_to raise_error
    expect(Song.count).to eq(1)
  end

  it '歌っているvtuberがいない場合request_songで曲データが作れないことを確認' do
    expect { song_task.invoke }.not_to raise_error
    expect(Song.count).to eq(0)
    expect(Request.count).to eq(0)
  end
end