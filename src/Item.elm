module Item exposing (Item, Kind(..), buyPrice, exposeInternals, kindToString, name, new, sellPrice)


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
    , buyPrice : Int
    , sellPrice : Int
    }


new : Kind -> String -> Int -> Int -> Item
new kind name_ buyPrice_ sellPrice_ =
    Item
        { kind = kind
        , name = name_
        , buyPrice = buyPrice_
        , sellPrice = sellPrice_
        }


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


name : Item -> String
name (Item i) =
    i.name


buyPrice : Item -> Int
buyPrice (Item i) =
    i.buyPrice


sellPrice : Item -> Int
sellPrice (Item i) =
    i.sellPrice


kindToString : Kind -> String
kindToString kind =
    case kind of
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
