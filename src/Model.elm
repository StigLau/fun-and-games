module Model exposing (..)

-- MODEL
type alias Model =
  { players: List Player
  , table: Player -- The cards on the table is represented in the same way as a single player
  , currentDeck : List Card
  }

type alias Card =
    { name: String
    , cardId : Int
    }

type alias Player =
    { name: String
    , hand : List Card
    , score: Int
    }
