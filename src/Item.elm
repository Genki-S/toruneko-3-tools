module Item exposing (Item, Kind(..), exposeInternals, kindToString, new)


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
new kind name buyPrice sellPrice =
    Item
        { kind = kind
        , name = name
        , buyPrice = buyPrice
        , sellPrice = sellPrice
        }


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


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
