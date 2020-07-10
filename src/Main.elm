module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
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
    { inventory : Result String (List Item)
    , searchInput : String
    , showCredit : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { inventory = Inventory.generate
      , searchInput = ""
      , showCredit = True
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = UpdateSearchInput String
    | HideCredit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateSearchInput t ->
            ( { model | searchInput = t }, Cmd.none )

        HideCredit ->
            ( { model | showCredit = False }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container", css [ Css.height (pct 100) ] ]
        [ if model.showCredit then
            viewCredit

          else
            span [] []
        , div [] [ viewSearchBox model ]
        , div [] [ viewItems model ]
        ]


viewCredit : Html Msg
viewCredit =
    div [ class "alert alert-dismissible alert-info" ]
        [ text "本アプリは2020/07/10時点での"
        , a [ href "https://www.pegasusknight.com/mb/tr3/index.html" ]
            [ text "www.pegasusknight.com" ]
        , text "様の情報を元に作成されました"
        , button [ class "close", onClick HideCredit ] [ text "×" ]
        ]


viewSearchBox : Model -> Html Msg
viewSearchBox model =
    input
        [ class "form-control"
        , type_ "text"
        , placeholder "アイテム名 / 買値 / 売値"
        , value model.searchInput
        , onInput UpdateSearchInput
        ]
        []


viewItems : Model -> Html Msg
viewItems model =
    case model.inventory of
        Err msg ->
            div [ class "alert alert-danger" ] [ text msg ]

        Ok items ->
            let
                filter item =
                    case String.toInt model.searchInput of
                        Just price ->
                            price == Item.buyPrice item || price == Item.sellPrice item

                        Nothing ->
                            String.contains model.searchInput (Item.name item)

                filteredItems =
                    List.filter filter items
            in
            Html.Styled.table [ class "table" ]
                [ thead [ class "thead-dark" ]
                    [ th [] [ text "種別" ]
                    , th [] [ text "名前" ]
                    , th [] [ text "買値" ]
                    , th [] [ text "売値" ]
                    ]
                , tbody []
                    (List.map viewItemRow filteredItems)
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
        , td [] [ text (String.fromInt i.buyPrice) ]
        , td [] [ text (String.fromInt i.sellPrice) ]
        ]
