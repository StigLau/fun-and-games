module Model exposing (..)

-- MODEL
type alias Model =
  { allCards : List Card
  , players: List Player
  }

type alias Card =
    { name: String
    , cardId : Int
    }

type alias Player =
    { name: String
    , hand : List Card
    }
