module Model exposing (..)

-- MODEL
type alias Model =
  {  allCards : List Card
  }

type alias Card =
    { name: String
    , cardId : Int
    }
