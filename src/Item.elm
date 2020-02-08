module Item exposing (Item, Kind(..), exposeInternals, kindToString)


type Item
    = Item Internals


type Kind
    = Scroll
    | Bill


type alias Internals =
    { kind : Kind
    , name : String
    }


new : Kind -> String -> Item
new kind name =
    Item
        { kind = kind
        , name = name
        }


exposeInternals : Item -> Internals
exposeInternals (Item i) =
    i


kindToString : Kind -> String
kindToString kind =
    case kind of
        Scroll ->
            "巻物"

        Bill ->
            "札"
