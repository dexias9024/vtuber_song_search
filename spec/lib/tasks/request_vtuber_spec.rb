require 'rake_helper'

describe 'request_vtuberのテスト' do
  subject(:vtuber_task) { Rake.application['request_vtuber:run'] }

  before do
    #request機能実装時に設定するかも
    member = create(:member)
  end

  it 'request_vtuberでvtuberデータが作れることを確認' do
    expect { vtuber_task.invoke }.not_to raise_error
    expect(Vtuber.count).to eq(1)
  end
end