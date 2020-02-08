module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Inventory
import Item exposing (Item, Kind(..))



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = \m -> view m |> toUnstyled
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }



---- MODEL ----


type alias Model =
    { inventory : Result String (List Item) }


init : ( Model, Cmd Msg )
init =
    ( { inventory = Inventory.generate }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "風来のシレン５ フォーチュンタワーと運命のダイス 値段識別" ]
        , viewInventory model
        ]


viewInventory : Model -> Html Msg
viewInventory model =
    case model.inventory of
        Err msg ->
            div [ class "alert alert-danger" ] [ text msg ]

        Ok items ->
            table []
                [ thead []
                    [ th [] [ text "種別" ]
                    , th [] [ text "名前" ]
                    , th [] [ text "買値" ]
                    , th [] [ text "売値" ]
                    ]
                , tbody []
                    (List.map viewItemRow items)
                ]


viewItemRow : Item -> Html Msg
viewItemRow item =
    let
        i =
            Item.exposeInternals item
    in
    tr []
        [ td [] [ text (i.kind |> Item.kindToString) ]
        , td [] [ text i.name ]
        , td [] [ text (String.fromInt i.price) ]
        , td [] [ text (String.fromInt (Item.calculateSellingPrice item)) ]
        ]
