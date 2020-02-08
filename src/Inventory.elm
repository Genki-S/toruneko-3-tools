module Inventory exposing (generate)

import Item exposing (Item, Kind(..))


generate : Result String (List Item)
generate =
    Ok
        (List.concat [ scrolls, herbs, bracelets, bills, wands, vases ])


scrolls : List Item
scrolls =
    let
        gen name price =
            Item.new Scroll name price
    in
    [ gen "ぬれた巻物" 10
    , gen "ただの紙切れ" 10
    , gen "脱出の巻物" 100
    , gen "あかりの巻物" 100
    , gen "オイルの巻物" 100
    , gen "光の巻物" 100
    , gen "紹介状" 100
    , gen "召介状" 100
    , gen "識別の巻物" 200
    , gen "集合の巻物" 300
    , gen "道具寄せの巻物" 300
    , gen "いかすしの巻物" 300
    , gen "おはらいの巻物" 500
    , gen "天の恵みの巻物" 500
    , gen "地の恵みの巻物" 500
    , gen "メッキの巻物" 500
    , gen "タグの巻物" 500
    , gen "換金の巻物" 500
    , gen "おにぎりの巻物" 500
    , gen "壺増大の巻物" 500
    , gen "吸い出しの巻物" 500
    , gen "祝福の巻物" 500
    , gen "たたりの巻物" 500
    , gen "タダの巻物" 500
    , gen "夫の恵みの巻物" 500
    , gen "他の恵みの巻物" 500
    , gen "壺増犬の巻物" 500
    , gen "ゾワゾワの巻物" 800
    , gen "ワナ消しの巻物" 800
    , gen "水がれの巻物" 800
    , gen "ワナの巻物" 800
    , gen "くちなしの巻物" 800
    , gen "拾えずの巻物" 800
    , gen "ひきよせの巻物" 800
    , gen "混乱の巻物" 1000
    , gen "バクスイの巻物" 1000
    , gen "真空斬りの巻物" 1000
    , gen "オーラ消しの巻物" 1000
    , gen "昼夜の巻物" 1000
    , gen "敵加速の巻物" 1000
    , gen "魔物部屋の巻物" 1000
    , gen "予防の巻物" 1000
    , gen "技回復の巻物" 1000
    , gen "困った時の巻物" 1000
    , gen "バクチの巻物" 1000
    , gen "枝回復の巻物" 1000
    , gen "国った時の巻物" 1000
    , gen "迷子の巻物" 3000
    , gen "聖域の巻物" 3000
    , gen "全滅の巻物" 3000
    , gen "金滅の巻物" 3000
    , gen "白紙の巻物" 5000
    , gen "ねだやしの巻物" 10000
    ]


herbs : List Item
herbs =
    let
        gen name price =
            Item.new Herb name price
    in
    [ gen "雑草" 10
    , gen "薬草" 50
    , gen "楽草" 50
    , gen "弟切草" 100
    , gen "毒消し草" 100
    , gen "毒草" 100
    , gen "高飛び草" 100
    , gen "いやし草" 200
    , gen "パワーアップ草" 300
    , gen "成長の種" 300
    , gen "めぐすり草" 300
    , gen "すばやさ草" 300
    , gen "胃拡張の種" 300
    , gen "胃縮小の種" 300
    , gen "混乱草" 300
    , gen "目つぶし草" 300
    , gen "ぬぐすり草" 300
    , gen "命の草" 500
    , gen "ちからの草" 500
    , gen "ドラゴン草" 500
    , gen "睡眠草" 500
    , gen "狂戦士の種" 500
    , gen "ドラコン草" 500
    , gen "復活の草" 1000
    , gen "腹活の草" 1000
    , gen "やりなおし草" 1500
    , gen "やりなおせ草" 1500
    , gen "無敵草" 2000
    , gen "しあわせ草" 2000
    , gen "不幸の種" 2000
    , gen "忌火起草" 2000
    , gen "物忘れの草" 2000
    , gen "天使の種" 5000
    , gen "超不幸の種" 5000
    ]


bracelets : List Item
bracelets =
    let
        gen name price =
            Item.new Bracelet name price
    in
    [ gen "ちからの腕輪" 2000
    , gen "遠投の腕輪" 2000
    , gen "ヘタ投げの腕輪" 2000
    , gen "武器束ねの腕輪" 2000
    , gen "毒消しの腕輪" 3000
    , gen "混乱よけの腕輪" 3000
    , gen "睡眠よけの腕輪" 3000
    , gen "呪いよけの腕輪" 3000
    , gen "保持の腕輪" 3000
    , gen "痛恨の腕輪" 3000
    , gen "呪い師の腕輪" 3000
    , gen "魔物呼びの腕輪" 3000
    , gen "透ネ見の腕輪" 3000
    , gen "ワナの腕輪" 3000
    , gen "気配察知の腕輪" 5000
    , gen "気配察血の腕輪" 5000
    , gen "道具感知の腕輪" 5000
    , gen "道具感血の腕輪" 5000
    , gen "水グモの腕輪" 5000
    , gen "壁抜けの腕輪" 5000
    , gen "回復の腕輪" 5000
    , gen "裏道の腕輪" 5000
    , gen "高飛びの腕輪" 5000
    , gen "爆発の腕輪" 5000
    , gen "ノナリーの腕輪" 5000
    , gen "しあわせの腕輪" 10000
    , gen "弾きよけの腕輪" 10000
    , gen "時たたずの腕輪" 10000
    , gen "浮遊の腕輪" 10000
    , gen "無心の腕輪" 30000
    , gen "透視の腕輪" 30000
    , gen "マタギの腕輪" 30000
    , gen "鑑定師の腕輪" 30000
    , gen "VIPの腕輪" 50000
    ]


bills : List Item
bills =
    let
        gen name price =
            Item.new Bill name price
    in
    [ gen "影縫いの札" 600
    , gen "混乱の札" 600
    , gen "封印の札" 600
    , gen "ゾワゾワの札" 600
    , gen "狂戦士の札" 600
    , gen "空振りの札" 600
    , gen "睡眠の札" 600
    , gen "バクスイの札" 600
    , gen "鈍足の札" 600
    , gen "加速の札" 600
    , gen "イカリの札" 600
    , gen "オオイカリの札" 600
    , gen "しあわせの札" 600
    ]


wands : List Item
wands =
    let
        gen name basePrice priceIncrement =
            Item.newConsumables Wand name basePrice priceIncrement 7
    in
    [ gen "場所がえの杖" 600 30
    , gen "吹き飛ばしの杖" 600 30
    , gen "飛びつきの杖" 600 30
    , gen "鈍足の杖" 600 30
    , gen "加速の杖" 600 30
    , gen "魔道の杖" 600 30
    , gen "一時しのぎの杖" 900 45
    , gen "かなしばりの杖" 900 45
    , gen "痛み分けの杖" 900 45
    , gen "ただの杖" 900 45
    , gen "ワナ消しの杖" 900 45
    , gen "転ばぬ先の杖" 900 45
    , gen "かなしばいの杖" 900 45
    , gen "転ばぬ先生の杖" 900 45
    , gen "感電の杖" 1200 60
    , gen "盛電の杖" 1200 60
    , gen "封印の杖" 1500 75
    , gen "身代わりの杖" 1500 75
    , gen "身伐わりの杖" 1500 75
    , gen "しあわせの杖" 1800 90
    , gen "不幸の杖" 1800 90
    , gen "トンネルの杖" 1800 90
    , gen "土塊の杖" 1800 90
    , gen "しわよせの杖" 1800 90
    ]
        |> List.concat


vases : List Item
vases =
    let
        gen name basePrice priceIncrement =
            Item.newConsumables Vase name basePrice priceIncrement 5
    in
    [ gen "保存の壺" 600 30
    , gen "ただの壺" 600 30
    , gen "識別の壺" 600 30
    , gen "やりすごしの壺" 600 30
    , gen "四二鉢" 600 30
    , gen "換金の壺" 1000 50
    , gen "変化の壺" 1000 50
    , gen "変花の壺" 1000 50
    , gen "底抜けの壺" 1000 50
    , gen "フィーバーの壺" 1000 50
    , gen "手封じの壺" 1000 50
    , gen "割れない壺" 1000 50
    , gen "おはらいの壺" 1600 80
    , gen "祝福の壺" 1600 80
    , gen "たたりの壺" 1600 80
    , gen "水がめ" 2000 100
    , gen "天上の器" 2000 100
    , gen "冷えびえ香の壺" 2500 125
    , gen "身かわし香の壺" 2500 125
    , gen "目配り香の壺" 2500 125
    , gen "山彦香の壺" 2500 125
    , gen "背中の壺" 3500 175
    , gen "トドの壺" 3500 175
    , gen "笑いの壺" 3500 175
    , gen "クラインの壺" 3500 175
    , gen "魔物の壺" 3500 175
    , gen "乙女の祈りの壺" 3500 175
    , gen "合成の壺" 6000 300
    , gen "合城の壺" 6000 300
    , gen "強化の壺" 10000 500
    , gen "弱化の壺" 10000 500
    , gen "福寄せの壺" 10000 500
    , gen "厄寄せの壺" 10000 500
    , gen "強イヒの壺" 10000 500
    ]
        |> List.concat
