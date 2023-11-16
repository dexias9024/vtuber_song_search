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

#instruments
Instrument.create_or_find_by(name: 'ギター')
Instrument.create_or_find_by(name: 'ピアノ')
Instrument.create_or_find_by(name: 'ヴァイオリン')
Instrument.create_or_find_by(name: 'フルート')
