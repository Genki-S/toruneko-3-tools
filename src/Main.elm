port module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Css exposing (..)
import Dungeon exposing (Dungeon(..))
import ExperienceTable
import Filter exposing (Filter(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Inventory
import Item exposing (Item, Kind(..))



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = \m -> view m |> toUnstyled
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }


type alias Flags =
    { identifiedItemNames : List String
    }



---- MODEL ----


type alias Model =
    { currentPage : Page
    , inventory : Result String (List Item)
    , searchInput : String
    , showCredit : Bool
    , identifiedItemNames : List String
    , filterGroups : List FilterGroup
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { currentPage = PageItemInventory
      , inventory = Inventory.generate
      , searchInput = ""
      , showCredit = True
      , identifiedItemNames = flags.identifiedItemNames
      , filterGroups =
            [ { id = DungeonFilters
              , filterItems =
                    [ { id = FilterAnotherWorldItems
                      , displayName = "異世界"
                      , toImpl = \ingredients -> DungeonFilter AnotherWorld
                      , enabled = False
                      }
                    ]
              }
            , { id = IdentifiedStateFilters
              , filterItems =
                    [ { id = FilterIdentifiedItems
                      , displayName = "識別済"
                      , toImpl = \ingredients -> IdentifiedFilter ingredients.identifiedItemNames True
                      , enabled = False
                      }
                    , { id = FilterNonIdentifiedItems
                      , displayName = "未識別"
                      , toImpl = \ingredients -> IdentifiedFilter ingredients.identifiedItemNames False
                      , enabled = False
                      }
                    ]
              }
            , { id = ItemKindFilters
              , filterItems =
                    [ { id = FilterScrolls
                      , displayName = "巻物"
                      , toImpl = \_ -> ItemKindFilter Scroll
                      , enabled = False
                      }
                    , { id = FilterHerbs
                      , displayName = "草"
                      , toImpl = \_ -> ItemKindFilter Herb
                      , enabled = False
                      }
                    , { id = FilterRings
                      , displayName = "指輪"
                      , toImpl = \_ -> ItemKindFilter Ring
                      , enabled = False
                      }
                    , { id = FilterWands
                      , displayName = "杖"
                      , toImpl = \_ -> ItemKindFilter Wand
                      , enabled = False
                      }
                    , { id = FilterVases
                      , displayName = "壺"
                      , toImpl = \_ -> ItemKindFilter Vase
                      , enabled = False
                      }
                    ]
              }
            ]
      }
    , Cmd.none
    )


type Page
    = PageItemInventory
    | PageExperienceTable


type alias FilterIngredients =
    { identifiedItemNames : List String
    }


type alias FilterItem =
    { id : FilterItemID
    , displayName : String
    , toImpl : FilterIngredients -> Filter
    , enabled : Bool
    }


type FilterItemID
    = FilterIdentifiedItems
    | FilterNonIdentifiedItems
    | FilterScrolls
    | FilterHerbs
    | FilterRings
    | FilterWands
    | FilterVases
    | FilterAnotherWorldItems


type alias FilterGroup =
    { id : FilterGroupID
    , filterItems : List FilterItem
    }


type FilterGroupID
    = IdentifiedStateFilters
    | ItemKindFilters
    | DungeonFilters



---- UPDATE ----


type Msg
    = ChangePage Page
    | UpdateSearchInput String
    | ClearSearchInput
    | MarkItemAsIdentified Item Bool
    | ClearIdentifiedItems
    | HideCredit
    | EnableFilter FilterGroupID FilterItemID Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            ( { model | currentPage = page }, Cmd.none )

        UpdateSearchInput t ->
            ( { model | searchInput = t }, Cmd.none )

        ClearSearchInput ->
            ( { model | searchInput = "" }, Cmd.none )

        MarkItemAsIdentified item identified ->
            let
                updatedList =
                    if identified then
                        Item.name item :: model.identifiedItemNames

                    else
                        List.filter (\n -> n /= Item.name item) model.identifiedItemNames
            in
            ( { model | identifiedItemNames = updatedList }, storeIdentifiedItemNames updatedList )

        ClearIdentifiedItems ->
            ( model, clearIdentifiedItemNames () )

        HideCredit ->
            ( { model | showCredit = False }, Cmd.none )

        EnableFilter groupID itemID enabled ->
            let
                updatedGroups =
                    model.filterGroups
                        |> List.map
                            (\group ->
                                if group.id /= groupID then
                                    group

                                else
                                    let
                                        updatedItems =
                                            group.filterItems
                                                |> List.map
                                                    (\item ->
                                                        if item.id /= itemID then
                                                            -- filters are mutually exclusive within group
                                                            { item | enabled = False }

                                                        else
                                                            { item | enabled = enabled }
                                                    )
                                    in
                                    { group | filterItems = updatedItems }
                            )
            in
            ( { model | filterGroups = updatedGroups }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container", css [ Css.height (pct 100) ] ]
        [ viewHeader model
        , if model.showCredit then
            viewCredit

          else
            span [] []
        , case model.currentPage of
            PageItemInventory ->
                viewItemInventory model

            PageExperienceTable ->
                viewExperienceTable model
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    let
        inventoryLinkClass =
            if model.currentPage == PageItemInventory then
                "nav-item active"

            else
                "nav-item"

        experienceLinkClass =
            if model.currentPage == PageExperienceTable then
                "nav-item active"

            else
                "nav-item"
    in
    nav [ class "navbar navbar-dark bg-dark" ]
        [ span [ class "navbar-brand" ]
            [ text "トルネコ3ツール" ]
        , button [ attribute "aria-controls" "navbarSupportedContent", attribute "aria-expanded" "false", attribute "aria-label" "Toggle navigation", class "navbar-toggler", attribute "data-target" "#navbarSupportedContent", attribute "data-toggle" "collapse", type_ "button" ]
            [ span [ class "navbar-toggler-icon" ]
                []
            ]
        , div [ class "collapse navbar-collapse", id "navbarSupportedContent" ]
            [ ul [ class "navbar-nav mr-auto" ]
                [ li [ class inventoryLinkClass ]
                    [ a [ class "nav-link", href "#", onClick (ChangePage PageItemInventory) ]
                        [ text "アイテム検索/管理"
                        ]
                    ]
                , li [ class experienceLinkClass ]
                    [ a [ class "nav-link", href "#", onClick (ChangePage PageExperienceTable) ]
                        [ text "経験値表" ]
                    ]
                ]
            ]
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


viewItemInventory : Model -> Html Msg
viewItemInventory model =
    div []
        [ div [] [ viewIdentifiedStateClearButton model ]
        , div [] [ viewSearchBox model ]
        , div [] [ viewFilterGroups model ]
        , div [] [ viewItems model ]
        ]


viewIdentifiedStateClearButton : Model -> Html Msg
viewIdentifiedStateClearButton model =
    div [ css [ marginTop (px 5), marginBottom (px 5) ] ]
        [ button [ class "btn btn-danger", onClick ClearIdentifiedItems ]
            [ text "識別リセット" ]
        ]


viewSearchBox : Model -> Html Msg
viewSearchBox model =
    div [ class "input-group" ]
        [ input
            [ class "form-control"
            , type_ "text"
            , placeholder "アイテム名 / 買値 / 売値"
            , value model.searchInput
            , onInput UpdateSearchInput
            ]
            []
        , button [ class "btn btn-light", onClick ClearSearchInput ] [ text "X" ]
        ]


viewFilterGroups : Model -> Html Msg
viewFilterGroups model =
    div []
        (List.map viewFilterGroup model.filterGroups)


viewFilterGroup : FilterGroup -> Html Msg
viewFilterGroup filterGroup =
    div []
        (List.map (viewFilterItem filterGroup.id) filterGroup.filterItems)


viewFilterItem : FilterGroupID -> FilterItem -> Html Msg
viewFilterItem groupID filterItem =
    let
        badgeClass =
            if filterItem.enabled then
                "badge badge-info"

            else
                "badge badge-light"
    in
    span
        [ class badgeClass
        , css [ margin (px 5), padding (px 15), cursor pointer ]
        , onClick (EnableFilter groupID filterItem.id (not filterItem.enabled))
        ]
        [ text filterItem.displayName ]


viewItems : Model -> Html Msg
viewItems model =
    case model.inventory of
        Err msg ->
            div [ class "alert alert-danger" ] [ text msg ]

        Ok items ->
            let
                filterIngredients =
                    { identifiedItemNames = model.identifiedItemNames
                    }

                filters =
                    List.concatMap (\group -> group.filterItems) model.filterGroups
                        |> List.filter (\item -> item.enabled)
                        |> List.map (\item -> item.toImpl filterIngredients)
                        |> List.append [ FreeTextFilter model.searchInput ]

                filteredItems =
                    Filter.applyFilters filters items
            in
            Html.Styled.table [ class "table item-table" ]
                [ thead [ class "thead-dark" ]
                    [ th [] [ text "種別" ]
                    , th [] [ text "名前" ]
                    , th [] [ text "買値" ]
                    , th [] [ text "売値" ]
                    , th [] [ text "識別済" ]
                    ]
                , tbody []
                    (List.map (viewItemRow model) filteredItems)
                ]


viewItemRow : Model -> Item -> Html Msg
viewItemRow model item =
    let
        i =
            Item.exposeInternals item

        identified =
            List.member i.name model.identifiedItemNames
    in
    tr []
        [ td [] [ text (i.kind |> Item.kindToString) ]
        , td [] [ text i.name ]
        , td [] [ text (String.fromInt i.buyPrice) ]
        , td [] [ text (String.fromInt i.sellPrice) ]
        , td []
            [ input
                [ type_ "checkbox"
                , class "form-check-input position-static"
                , Html.Styled.Attributes.checked identified
                , onClick (MarkItemAsIdentified item (not identified))
                ]
                []
            ]
        ]


viewExperienceTable : Model -> Html Msg
viewExperienceTable model =
    let
        torunekoTable =
            ExperienceTable.toruneko

        poporoTable =
            ExperienceTable.poporo

        zipped =
            List.map2 Tuple.pair torunekoTable poporoTable
                |> List.indexedMap Tuple.pair
                |> List.map (Tuple.mapFirst (\i -> i + 1))
    in
    Html.Styled.table [ class "table item-table", css [ marginTop (px 5) ] ]
        [ thead [ class "thead-dark" ]
            [ th [] [ text "レベル" ]
            , th [] [ text "トルネコ" ]
            , th [] [ text "ポポロ" ]
            ]
        , tbody []
            (List.map viewExperienceRow zipped)
        ]


viewExperienceRow : ( Int, ( Int, Int ) ) -> Html Msg
viewExperienceRow data =
    let
        level =
            Tuple.first data

        exp =
            Tuple.second data

        toruneko =
            Tuple.first exp

        poporo =
            Tuple.second exp
    in
    tr []
        [ td [] [ text (String.fromInt level) ]
        , td [] [ text (String.fromInt toruneko) ]
        , td [] [ text (String.fromInt poporo) ]
        ]



---- PORT ----


port storeIdentifiedItemNames : List String -> Cmd msg


port clearIdentifiedItemNames : () -> Cmd msg
