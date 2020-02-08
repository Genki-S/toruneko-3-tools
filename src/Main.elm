module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (..)
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
    div [ class "container" ]
        [ viewInventory model
        , viewPriceInput model
        ]


viewInventory : Model -> Html Msg
viewInventory model =
    case model.inventory of
        Err msg ->
            div [ class "alert alert-danger" ] [ text msg ]

        Ok items ->
            Html.Styled.table [ class "table" ]
                [ thead [ class "thead-dark" ]
                    [ th [] [ text "種別" ]
                    , th [] [ text "名前" ]
                    , th [] [ text "回数" ]
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

        remainingText =
            case i.remaining of
                Nothing ->
                    ""

                Just r ->
                    String.fromInt r
    in
    tr []
        [ td [] [ text (i.kind |> Item.kindToString) ]
        , td [] [ text i.name ]
        , td [] [ text remainingText ]
        , td [] [ text (String.fromInt i.price) ]
        , td [] [ text (String.fromInt (Item.calculateSellingPrice item)) ]
        ]


viewPriceInput : Model -> Html Msg
viewPriceInput model =
    div
        [ css
            [ position fixed
            , Css.height (pct 40)
            , bottom (px 0)
            , right (px 0)
            , left (px 0)
            , backgroundColor (hex "EEEEEE")
            ]
        ]
        [ div [ class "container" ]
            [ text "TODO: input area" ]
        ]
