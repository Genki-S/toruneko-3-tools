module Dungeon exposing (Dungeon(..), toString)


type Dungeon
    = AnotherWorld


toString : Dungeon -> String
toString d =
    case d of
        AnotherWorld ->
            "異世界"
