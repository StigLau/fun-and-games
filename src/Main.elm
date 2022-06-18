module Main exposing (..)

import Browser
import CardStuff exposing (initialCardList, printCardNames, shuffleList)
import Html exposing (..)
import Html.Events exposing (..)
import Model exposing (Card, Model)
import Random exposing (Seed, initialSeed)

import Debug

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
  ( Model initialCardList
  , Cmd.none
  )


-- UPDATE
type Msg
  = ShuffleCards
  | Randoom Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShuffleCards ->
      ( model
      , Random.generate Randoom (Random.int 1 99)
      )

    Randoom seed  ->
         ( Model ( shuffleList (initialSeed seed) model.allCards)
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
    let
        ost = printCardNames model.allCards
       -- textable =  textalize ost
    in div []
    [ h1 [] [ text ("Title") ]
    , h1 [] (ost)
    , button [ onClick ShuffleCards ] [ text "Shuffle Cards" ]
    , div [] [text "WHITESPACE", text "BLACKSPACE"]
    , text "Mordi er en geit"
    ]

--textalize listOfStuff =