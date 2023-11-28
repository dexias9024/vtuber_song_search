require 'rails_helper'

RSpec.describe 'Favorite', type: :model do
  describe 'バリデーションのテスト' do
    subject { favorite.valid? }

    let!(:other_favorite) { create(:favorite) }
    let(:favorite) { build(:favorite) }

    context '1User 1song 1いいね' do
      it '1-1.Userが同じsongにいいね出来ないこと' do
        favorite.user = other_favorite.user
        favorite.song = other_favorite.song
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '2-1.N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'songモデルとの関係' do
      it '2-2.N:1となっている' do
        expect(Favorite.reflect_on_association(:song).macro).to eq :belongs_to
      end
    end
  end
end