module Main exposing (..)

import Browser
import CardStuff exposing (initialCardList, cardsToNames, shuffleList)
import Html exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Card, Player)
import Random exposing (Seed, initialSeed)

-- MAIN
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model initialCardList [Model.Player "Gunnar" []]
  , Cmd.none
  )


-- UPDATE
type Msg
  = ShuffleCards
  | ShuffleDeck Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShuffleCards ->
        ( model
--        , Random.generate ShuffleDeck (Random.int 1 99)
        , Random.generate ShuffleDeck (Random.int Random.minInt Random.maxInt)
        )

    ShuffleDeck seed  ->
        ( Model ( shuffleList (initialSeed seed) model.allCards) model.players
        , Cmd.none
        )
-- independentSeed
-- Fixed randomness:  initialSeed 5

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW
view : Model -> Html Msg
view model =
    div []
    [ h1 [] [ text ("AppTitle") ]
    , h1 [] (stringToText (cardsToNames model.allCards))
    , button [ onClick ShuffleCards ] [ text "Shuffle Cards" ]
    , div [] [text "WHITESPACE", text "BLACKSPACE"]
    , text "Mordi er en geit"
    ]

stringToText: List String ->  List (Html Msg)
stringToText listOfStuff =
    case listOfStuff of
        head :: tail -> text head :: stringToText tail
        [] -> []
