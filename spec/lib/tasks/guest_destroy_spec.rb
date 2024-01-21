require 'rake_helper'

describe 'guest_destroyのテスト' do
  subject(:guest_task) { Rake.application['guest_destroy:run'] }

  it 'guest_destroyで3日以上前に作成されたroleがguestのデータを削除できることを確認' do
    guest = create(:user, :guest)
    user = create(:user, :general)
    old_guest = create(:user, :old_guest)
    expect(User.count).to eq(3)
    expect { guest_task.invoke }.not_to raise_error
    expect(User.count).to eq(2)
  end
end