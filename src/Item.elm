module Item exposing (Item, Kind(..), buyPrice, exposeInternals, hiraganaName, kind, kindToString, name, new, sellPrice)


type Item
    = Item Internals


type Kind
    = Scroll
    | Herb
    | Ring
    | Wand
    | Vase


type alias Internals =
    { kind : Kind
    , name : String
    , hiraganaName : String
    , buyPrice : Int
    , sellPrice : Int
    }


new : Kind -> String -> String -> Int -> Int -> Item
new kind_ name_ hiraganaName_ buyPrice_ sellPrice_ =
    Item
        { kind = kind_
        , name = name_
        , hiraganaName = hiraganaName_
        , buyPrice = buyPrice_
        , sellPrice = sellPrice_
        }


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


kind : Item -> Kind
kind (Item i) =
    i.kind


name : Item -> String
name (Item i) =
    i.name


hiraganaName : Item -> String
hiraganaName (Item i) =
    i.hiraganaName


buyPrice : Item -> Int
buyPrice (Item i) =
    i.buyPrice


sellPrice : Item -> Int
sellPrice (Item i) =
    i.sellPrice


kindToString : Kind -> String
kindToString kind_ =
    case kind_ of
        Scroll ->
            "巻物"

        Herb ->
            "草"

        Ring ->
            "指輪"

        Wand ->
            "杖"

        Vase ->
            "壺"
