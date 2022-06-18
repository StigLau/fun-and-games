module Model exposing (..)

-- MODEL
type alias Model =
  { players: List Player
  , currentDeck : List Card
  }

type alias Card =
    { name: String
    , cardId : Int
    }

type alias Player =
    { name: String
    , hand : List Card
    }
