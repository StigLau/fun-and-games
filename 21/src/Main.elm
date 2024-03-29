module Main exposing (..)

import Browser
import CardStuff exposing (calculateScores, cardsToNames, dealCardToPlayer, dealOneCardToPlayers, shuffleList)
import CardSetup exposing (initialCardList)
import Html exposing (..)
import Html.Events exposing (..)
import Model exposing (Model, Card, Player)
import Random exposing (Seed, initialSeed)
import List

-- MAIN
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


init : () -> (Model, Cmd Msg)
init _ = ( Model
  [ (Model.Player "Dealer" [] 0)
  , (Model.Player "Bjartram" [] 0)
  , (Model.Player "Gunnar" [] 0)
  , (Model.Player "Nisseleif" [] 0)
  , (Model.Player "Knugen av Danmark" [] 0)
  ] (Player "Table" [] 0) initialCardList
  , Cmd.none
  )


-- UPDATE
type Msg
  = ShuffleCards
  | ShuffleDeck Int
  | DealOneCard
  | DealOneCardToTable


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShuffleCards ->
        ( model
--        , Random.generate ShuffleDeck (Random.int 1 99) -- Less pseudorandomness alternative
        , Random.generate ShuffleDeck (Random.int Random.minInt Random.maxInt)
        )

    ShuffleDeck seed  ->
        ( Model model.players model.table ( shuffleList (initialSeed seed) model.currentDeck)
        , Cmd.none
        )

    DealOneCard ->
             (  calculateScores <| dealOneCardToPlayers model, Cmd.none )

    DealOneCardToTable ->
        let
            (table, nuDeck) = dealCardToPlayer model.table model.currentDeck
        in
            (calculateScores <| Model model.players table nuDeck, Cmd.none)

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
    , h4 [] (stringToText (cardsToNames model.currentDeck))
    , button [ onClick ShuffleCards ] [ text "Shuffle Deck" ]
    , button [ onClick DealOneCard ] [ text "Deal one card to players" ]
    , button [ onClick DealOneCardToTable ] [ text "Deal one card to Table" ]
    , h2 [] [ text "List Players"]

    , text  (playersToVisuals model.players)
    , h2 [] [ text "Current table"]
    , text  (playersToVisuals [model.table])
    ]

playersToVisuals:  List Player -> String
playersToVisuals players =
        case players of
            [] -> ""
            [head] -> playerToVisuals head
            head :: tail -> (playerToVisuals head ) ++  " - " ++ (playersToVisuals tail)


playerToVisuals: Player -> String
playerToVisuals player = player.name ++  ":  Score " ++ (String.fromInt player.score ) ++ " : " ++  (List.foldl (++) "" (cardsToNames player.hand) )


stringToText: List String ->  List (Html Msg)
stringToText listOfStuff =
    case listOfStuff of
        head :: tail -> text head :: stringToText tail
        [] -> []

