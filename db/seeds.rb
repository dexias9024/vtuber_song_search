# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#members
Member.create_or_find_by(name: '個人勢')
Member.create_or_find_by(name: 'ホロライブ')
Member.create_or_find_by(name: 'ホロライブEN')
Member.create_or_find_by(name: 'ホロライブID')
Member.create_or_find_by(name: 'にじさんじ')
Member.create_or_find_by(name: 'にじさんじEN')
Member.create_or_find_by(name: 'ななしいんく')
Member.create_or_find_by(name: '.Live')
Member.create_or_find_by(name: 'のりプロ')
Member.create_or_find_by(name: 'ネオポルテ')
Member.create_or_find_by(name: 'ぶいすぽ')
Member.create_or_find_by(name: 'VEE')
Member.create_or_find_by(name: 'ぶいありうむ')
Member.create_or_find_by(name: 'UniVIRTUAL')
Member.create_or_find_by(name: '神椿')
Member.create_or_find_by(name: 'ライブユニオン')
Member.create_or_find_by(name: 'ReAcT')
Member.create_or_find_by(name: 'RIOT MUSIC')
Member.create_or_find_by(name: 'ReGLOSS')

#instruments
Instrument.create_or_find_by(name: 'ギター')
Instrument.create_or_find_by(name: 'ピアノ')
Instrument.create_or_find_by(name: 'ヴァイオリン')
Instrument.create_or_find_by(name: 'フルート')
Instrument.create_or_find_by(name: 'エレクトーン')

#requests
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '星街すいせい', 
  url: 'https://www.youtube.com/watch?v=mRgslQ5Z-kU',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'AZKi', 
  url: 'https://www.youtube.com/watch?v=ydcT5Dvs888',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '白上フブキ', 
  url: 'https://www.youtube.com/watch?v=I7CY960FEPo',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '湊あくあ', 
  url: 'https://www.youtube.com/watch?v=qfw9z5rLmm4',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '宝鐘マリン', 
  url: 'https://www.youtube.com/watch?v=yilQ3KUhEpo',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '天音かなた', 
  url: 'https://www.youtube.com/watch?v=1NL-sIP9p_U',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '桃鈴ねね', 
  url: 'https://www.youtube.com/watch?v=TgOAdwmfkhA',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '沙花叉クロヱ', 
  url: 'https://www.youtube.com/watch?v=rFbJlErkcGw',
  member_name: 'ホロライブ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Mori Calliope', 
  url: 'https://www.youtube.com/watch?v=42awuPx06e8',
  member_name: 'ホロライブEN',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Nanashi Mumei', 
  url: 'https://www.youtube.com/watch?v=oA0CpI0vCK4',
  member_name: 'ホロライブEN',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Nerissa Ravencroft', 
  url: 'https://www.youtube.com/watch?v=SPWsptIhKkM',
  member_name: 'ホロライブEN',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Moona Hoshinova', 
  url: 'https://www.youtube.com/watch?v=qTr2x78_u4k',
  member_name: 'ホロライブID',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Pavolia Reine', 
  url: 'https://www.youtube.com/watch?v=D1OOM67IsV4',
  member_name: 'ホロライブID',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Kobo Kanaeru', 
  url: 'https://www.youtube.com/watch?v=DR43SQx8Ybc',
  member_name: 'ホロライブID',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '音乃瀬奏', 
  url: 'https://www.youtube.com/watch?v=oxZeLM9rx7s',
  member_name: 'ReGLOSS',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '町田ちま', 
  url: 'https://www.youtube.com/watch?v=ioNYjLeGAoE',
  member_name: 'にじさんじ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '戌亥とこ', 
  url: 'https://www.youtube.com/watch?v=aTkPHMixt4k',
  member_name: 'にじさんじ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'セフィナ', 
  url: 'https://www.youtube.com/watch?v=SYRYvRJovZo',
  member_name: 'にじさんじ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '葛葉', 
  url: 'https://www.youtube.com/watch?v=tpSlJnFHv38',
  member_name: 'にじさんじ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '渡会雲雀', 
  url: 'https://www.youtube.com/watch?v=Hk_oI2kP0Lk',
  member_name: 'にじさんじ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '三枝明那', 
  url: 'https://www.youtube.com/watch?v=Q8Sslyf6Vdw',
  member_name: 'にじさんじ',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Elira Pendora', 
  url: 'https://www.youtube.com/watch?v=ceTCxe1m7Ks',
  member_name: 'にじさんじEN',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Enna Alouette', 
  url: 'https://www.youtube.com/watch?v=lv4vIggzKOs',
  member_name: 'にじさんじEN',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'Uki Violeta', 
  url: 'https://www.youtube.com/watch?v=ztWXSDKX6Bc',
  member_name: 'にじさんじEN',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '龍ヶ崎リン', 
  url: 'https://www.youtube.com/watch?v=Zt-xLQ8Tht0',
  member_name: 'ななしいんく',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '涼海ネモ', 
  url: 'https://www.youtube.com/watch?v=GPKaY-py33A',
  member_name: 'ななしいんく',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '電脳少女シロ', 
  url: 'https://www.youtube.com/watch?v=3mZI_ZiTsrs',
  member_name: '.Live',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '犬山たまき', 
  url: 'https://www.youtube.com/watch?v=9Onb8GgxXR0',
  member_name: 'のりプロ',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '緋月ゆい', 
  url: 'https://www.youtube.com/watch?v=3tj1VokPiNo',
  member_name: 'ネオポルテ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '絲依とい', 
  url: 'https://www.youtube.com/watch?v=ERqqU72lYmI',
  member_name: 'ネオポルテ',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '神成きゅぴ', 
  url: 'https://www.youtube.com/watch?v=OQynKo-gFfM',
  member_name: 'ぶいすぽ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '橘ひなの', 
  url: 'https://www.youtube.com/watch?v=YpwDvUgDpYw',
  member_name: 'ぶいすぽ',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '天籠りのん', 
  url: 'https://www.youtube.com/watch?v=RaJ1GSoKjNI',
  member_name: 'VEE',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '七瀬える', 
  url: 'https://www.youtube.com/watch?v=dcJfR2vHv0E',
  member_name: 'ぶいありうむ',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'セレナーデ・オックスブラッド', 
  url: 'https://www.youtube.com/watch?v=2QgO55oIGtA',
  member_name: 'ぶいありうむ',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '白玖ウタノ', 
  url: 'https://www.youtube.com/watch?v=hBQSNzTkWzo',
  member_name: 'UniVIRTUAL',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '花譜', 
  url: 'https://www.youtube.com/watch?v=KobwavT8ZsM',
  member_name: '神椿',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'ヰ世界情緒', 
  url: 'https://www.youtube.com/watch?v=lhd67CnArlI',
  member_name: '神椿',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'HACHI', 
  url: 'https://www.youtube.com/watch?v=YgViWkyLi_0',
  member_name: 'ライブユニオン',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '焔魔るり', 
  url: 'https://www.youtube.com/watch?v=NU8ZRe690ck',
  member_name: 'ライブユニオン',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '獅子神レオナ', 
  url: 'https://www.youtube.com/watch?v=avkeRn9dbpw',
  member_name: 'ReAcT',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '稀羽すう', 
  url: 'https://www.youtube.com/watch?v=GfoPoMGQxKw',
  member_name: 'ReAcT',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '道明寺ここあ', 
  url: 'https://www.youtube.com/watch?v=BVxSCDEpH3M',
  member_name: 'RIOT MUSIC',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '凪原涼菜', 
  url: 'https://www.youtube.com/watch?v=Gon8cdizLY0',
  member_name: 'RIOT MUSIC',
)

Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '凛々咲', 
  url: 'https://www.youtube.com/watch?v=xAliCVelchw',
  member_name: '個人勢',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: 'よしか⁂', 
  url: 'https://www.youtube.com/watch?v=RWTvuBqCW7c',
  member_name: '個人勢',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '天羽音みらん', 
  url: 'https://www.youtube.com/watch?v=RkMiqV1TmvQ',
  member_name: '個人勢',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '音鍵めろ', 
  url: 'https://www.youtube.com/watch?v=umvLV79-McM',
  member_name: '個人勢',
)
Request.create_or_find_by(
  user_id: 1, 
  category: 0, 
  name: '花丸はれる', 
  url: 'https://www.youtube.com/watch?v=LZFIVeEx1Bs',
  member_name: '個人勢',
)
