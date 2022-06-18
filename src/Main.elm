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
  ( Model initialCardList [(Model.Player "Gunnar" [Card "Ost 2" 2, Card "Ost 4" 4]), (Model.Player "Bjartram" [Card "Ost 3" 3])]
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
--        , Random.generate ShuffleDeck (Random.int 1 99) -- Less pseudorandomness alternative
        , Random.generate ShuffleDeck (Random.int Random.minInt Random.maxInt)
        )

    ShuffleDeck seed  ->
        ( Model ( shuffleList (initialSeed seed) model.allCards) model.players
        , Cmd.none
        )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW
view : Model -> Html Msg
view model =
    div []
    [ h1 [] [ text ("AppTitle") ]
    , h3 [] [text "Deck of available cards:"]
    , h4 [] (stringToText (cardsToNames model.allCards))
    , button [ onClick ShuffleCards ] [ text "Shuffle Deck" ]
    , div [] [text "WHITESPACE", text "BLACKSPACE"]
    , h2 [] [ text "List Players"]
--    , text ( "Mordi er en "  ++ mordi)
    , text  (playersToVisuals model.players)
    ]

playersToVisuals:  List Player -> String
playersToVisuals players =
        case players of
            [] -> ""
            [x] -> playerToVisuals x
            head :: tail -> (playerToVisuals head ) ++  " - " ++ (playersToVisuals tail)


playerToVisuals: Player -> String
playerToVisuals player = player.name ++  ": " ++  (List.foldl (++) "" (cardsToNames player.hand) )
--playerToVisuals player = cardsToNames player.hand


--playerToText: Player -> String
--playerToText player = player.name ++ " " ++ cardsToNames player.hand

stringToText: List String ->  List (Html Msg)
stringToText listOfStuff =
    case listOfStuff of
        head :: tail -> text head :: stringToText tail
        [] -> []
