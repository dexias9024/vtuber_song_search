require 'rake_helper'

describe 'request_songのテスト' do
  subject(:song_task) { Rake.application['request_song:run'] }

  before do
    #のちのissueで設定する予定です
    member = create(:member)
  end

  it 'request_songで曲データが5つ作れることを確認' do
    expect { Rake.application['request_vtuber:run'].invoke }.not_to raise_error
    expect { song_task.invoke }.not_to raise_error
    expect(Song.count).to eq(5)
  end

  it '歌っているvtuberがいない場合request_songで曲データが作れないことを確認' do
    expect { song_task.invoke }.to raise_error(LocalJumpError, 'unexpected return')
    expect(Song.count).to eq(0)
  end
end