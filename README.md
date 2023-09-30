# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# [Vtuber歌サーチ]

## サービス概要

youtubeのAPIを使いyoutubeよりもちゃんと検索し、歌動画のリンクを表示できるサービス

##　想定されるユーザー層

Vtuber音楽を聴くが色んな人の歌を聴いてみたいが探す方法がない人
新規のVsingerを探すスコッパーの人
オリジナル曲を聴きたい人またはそのカバーを聴きたい人

これらの人やアニソンDJイベントのファンの中では歌の上手い人や新人を探すのは課題になっています。音楽系のファンは若い人が比較的多いとされていますがよく歌われる歌は１５年くらい前のアニソンなどが多いため、３０代前後くらいの人も対象をメインに程度広くユーザーになる可能性があると考えます。

## サービスコンセプト

Vtuberはさまざまな人がおり、歌は言語を超えて共有できるものだがyoutubeの検索では見つけるのが難しいのでそれよりも見つけやすい検索ができたらいいなと思い考案しました。
Vtuberが好きでその中でもVtuberの歌に注目してみていますが歌メインで活動している人の中には武道館ライブをした人やタイアップ曲を獲得した人も出てきています。
しかし、その中で見つけてもらえる人はほんの一握りであり検索しても出て来ないことがほとんどです。また、海外Vtuberも歌の上手い人が多いのですが多くのVtuberファンは英語を喋るのでわからないから見ないでおこうとなっているのが現状です。
歌ならば言語は関係なく洋楽を聞いたりするので言語は関係ないし、JASRACの許可の関係で海外Vtuberも日本の歌を歌っていることが非常に多いのでそれらを聴く機会があれば歌だけでもファンになってもらえたり作業で聞いたりする人を探すことができると考えています。なのでyoutubeよりもちゃんとした検索があれば曲名で検索した場合に様々な人を見る可能性が上がるのではないかと考えました。

vtuberの配信を探すサービスはあるが知る限りでは歌のみを検索できるサービスは存在しないため作りたいと考えました。

## 実装を予定している機能

### MVP

- 会員登録
- ログイン
- Vtuberの登録の要望を出せる
- Vtuberの曲の登録の要望を出せる
- コメント機能
- 検索機能（vtuberの名前、所属、どの楽器を使うか、曲名、オリジナルかカバーか）
- 検索した動画へのリンク
- お気に入りリスト

### その後の機能

- おすすめ歌動画設定
- ランダムおすすめ表示（新しく人を探す機能）
- タグ登録