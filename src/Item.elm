module Item exposing (Item, Kind(..), calculateSellingPrice, exposeInternals, kindToString, new, newConsumables)


type Item
    = Item Internals


type Kind
    = Scroll
    | Herb
    | Bracelet
    | Bill
    | Wand
    | Vase


type alias Internals =
    { kind : Kind
    , name : String
    , price : Int
    , remaining : Maybe Int
    }


new : Kind -> String -> Int -> Item
new kind name price =
    Item
        { kind = kind
        , name = name
        , price = price
        , remaining = Nothing
        }


newConsumables : Kind -> String -> Int -> Int -> Int -> List Item
newConsumables kind name basePrice priceIncrement maxAvailability =
    List.range 0 maxAvailability
        |> List.map
            (\remaining ->
                Item
                    { kind = kind
                    , name = name
                    , price = basePrice + (remaining * priceIncrement)
                    , remaining = Just remaining
                    }
            )


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


calculateSellingPrice : Item -> Int
calculateSellingPrice (Item i) =
    i.price * 35 // 100


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

        Wand ->
            "杖"

        Vase ->
            "壺"
