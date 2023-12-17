require 'rake_helper'

describe 'request_vtuberのテスト' do
  subject(:vtuber_task) { Rake.application['request_vtuber:run'] }

  before do
    request = create(:request, :vtuber)
    member = create(:member)
  end

  it 'request_vtuberでvtuberデータが作れることを確認' do
    expect { vtuber_task.invoke }.not_to raise_error
    expect(Vtuber.count).to eq(1)
  end

  it 'request_vtuberでvtuberデータが重複した場合作れないことを確認' do
    request2 = create(:request, url: "https://www.youtube.com/watch?v=inazxJzcq30")
    expect { vtuber_task.invoke }.not_to raise_error
    expect(Vtuber.count).to eq(1)
  end
end
