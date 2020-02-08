module Item exposing (Item, Kind(..), calculateSellingPrice, exposeInternals, kindToString, new)


type Item
    = Item Internals


type Kind
    = Scroll
    | Herb
    | Bracelet
    | Bill


type alias Internals =
    { kind : Kind
    , name : String
    , price : Int
    }


new : Kind -> String -> Int -> Item
new kind name price =
    Item
        { kind = kind
        , name = name
        , price = price
        }


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


calculateSellingPrice : Item -> Int
calculateSellingPrice (Item i) =
    toFloat i.price * 0.35 |> floor


kindToString : Kind -> String
kindToString kind =
    case kind of
        Scroll ->
            "巻物"

        Herb ->
            "草"

        Bracelet ->
            "腕輪"

        Bill ->
            "札"
