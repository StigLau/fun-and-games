module Main exposing (..)

import Browser
import CardStuff exposing (cardsToNames, dealCardWithModel, initialCardList, shuffleList)
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
init _ = ( Model
  [ (Model.Player "Dealer" [])
  , (Model.Player "Bjartram" [])
  , (Model.Player "Gunnar" [])
  , (Model.Player "Nisseleif" [])
  , (Model.Player "Knugen av Danmark" [])
  ] initialCardList
  , Cmd.none
  )


-- UPDATE
type Msg
  = ShuffleCards
  | ShuffleDeck Int
  | DealOneCard


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShuffleCards ->
        ( model
--        , Random.generate ShuffleDeck (Random.int 1 99) -- Less pseudorandomness alternative
        , Random.generate ShuffleDeck (Random.int Random.minInt Random.maxInt)
        )

    ShuffleDeck seed  ->
        ( Model model.players ( shuffleList (initialSeed seed) model.currentDeck)
        , Cmd.none
        )

    DealOneCard ->
        ( dealCardWithModel model, Cmd.none)

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
    , button [ onClick DealOneCard ] [ text "Deal one card" ]
    , h2 [] [ text "List Players"]
    , text  (playersToVisuals model.players)
    ]

playersToVisuals:  List Player -> String
playersToVisuals players =
        case players of
            [] -> ""
            head :: tail -> (playerToVisuals head ) ++  " - " ++ (playersToVisuals tail)


playerToVisuals: Player -> String
playerToVisuals player = player.name ++  ": " ++  (List.foldl (++) "" (cardsToNames player.hand) )


stringToText: List String ->  List (Html Msg)
stringToText listOfStuff =
    case listOfStuff of
        head :: tail -> text head :: stringToText tail
        [] -> []

