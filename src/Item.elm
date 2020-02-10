module Item exposing (BlessState(..), Item, Kind(..), asBlessed, asCursed, calculateBuyingPrice, calculateSellingPrice, exposeInternals, kindToString, new, newConsumables)


type Item
    = Item Internals


type Kind
    = Scroll
    | Herb
    | Bracelet
    | Bill
    | Wand
    | Vase


type BlessState
    = Blessed
    | Cursed


type alias Internals =
    { kind : Kind
    , name : String
    , basePrice : Int
    , priceIncrement : Maybe Int
    , remaining : Maybe Int
    , blessState : Maybe BlessState
    }


new : Kind -> String -> Int -> Item
new kind name basePrice =
    Item
        { kind = kind
        , name = name
        , basePrice = basePrice
        , priceIncrement = Nothing
        , remaining = Nothing
        , blessState = Nothing
        }


newConsumables : Kind -> String -> Int -> Int -> Int -> List Item
newConsumables kind name basePrice priceIncrement maxAvailability =
    List.range 0 maxAvailability
        |> List.map
            (\remaining ->
                Item
                    { kind = kind
                    , name = name
                    , basePrice = basePrice
                    , remaining = Just remaining
                    , priceIncrement = Just priceIncrement
                    , blessState = Nothing
                    }
            )


asBlessed : Item -> Item
asBlessed (Item i) =
    Item { i | blessState = Just Blessed }


asCursed : Item -> Item
asCursed (Item i) =
    Item { i | blessState = Just Cursed }


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


calculateBuyingPrice : Item -> Int
calculateBuyingPrice (Item i) =
    let
        price =
            case ( i.remaining, i.priceIncrement ) of
                ( Just r, Just inc ) ->
                    i.basePrice + (r * inc)

                ( _, _ ) ->
                    i.basePrice
    in
    case i.blessState of
        Nothing ->
            price

        Just Blessed ->
            price * 11 // 10

        Just Cursed ->
            price * 8 // 10


calculateSellingPrice : Item -> Int
calculateSellingPrice (Item i) =
    let
        notBlessedItem =
            Item { i | blessState = Nothing }

        price =
            calculateBuyingPrice notBlessedItem * 35 // 100
    in
    case i.blessState of
        Nothing ->
            price

        Just Blessed ->
            price * 11 // 10

        Just Cursed ->
            price * 8 // 10


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
