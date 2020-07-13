module Filter exposing (Filter(..), applyFilter, applyFilters)

import Dungeon exposing (Dungeon(..))
import Item exposing (Item, Kind(..))


type Filter
    = IdentifiedFilter (List String) Bool
    | ItemKindFilter Kind
    | FreeTextFilter String
    | DungeonFilter Dungeon


applyFilters : List Filter -> List Item -> List Item
applyFilters filters items =
    List.foldl applyFilter items filters


applyFilter : Filter -> List Item -> List Item
applyFilter filter items =
    List.filter (toFilterFunc filter) items


toFilterFunc : Filter -> Item -> Bool
toFilterFunc f item =
    case f of
        IdentifiedFilter identifiedItemNames identified ->
            identified == List.member (Item.name item) identifiedItemNames

        ItemKindFilter kind ->
            Item.kind item == kind

        FreeTextFilter s ->
            case String.toInt s of
                Just price ->
                    price == Item.buyPrice item || price == Item.sellPrice item

                Nothing ->
                    String.contains s (Item.name item) || String.contains s (Item.hiraganaName item)

        DungeonFilter dungeon ->
            List.member dungeon (Item.dungeons item)
