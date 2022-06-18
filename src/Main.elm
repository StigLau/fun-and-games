module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import List.Extra exposing (getAt, removeAt)
import Random exposing (Seed, initialSeed, int, step)
import Debug

-- MAIN
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL
type alias Model =
  { dieFace : Int
  , allCards : List Card
  }

type alias Card =
    { name: String
    , cardId : Int
    }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1 cardList
  , Cmd.none
  )

genCard name value =
    Card name value

-- UPDATE
type Msg
  = Roll
  | ShuffleCards
  | NewFace Int
  | Randoom Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model
      , Random.generate NewFace (Random.int 1 99)
      )

    ShuffleCards ->
      ( model
      , Random.generate Randoom (Random.int 1 99)
      )

    NewFace newFace ->
      ( Model newFace []
      , Cmd.none
      )

    Randoom seed  ->
         ( Model seed ( shuffleList (initialSeed seed) cardList)
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
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , h1 [] (printCardNames model.allCards)
    , button [ onClick Roll ] [ text "Roll" ]
    , button [ onClick ShuffleCards ] [ text "Shuffle Cards" ]
    , div [] [text "WHITESPACE", text "BLACKSPACE"]
    , text "Mordi er en geit"
    ]

printCardNames: List Card ->  List (Html msg)
printCardNames cards =
    case cards of
            [] -> []
            [x] -> [text x.name]
            head :: tail -> text head.name :: text " - " :: printCardNames tail

shuffleList : Seed -> List a -> List a
shuffleList seed list =
    shuffleListHelper seed list []


shuffleListHelper : Seed -> List a -> List a -> List a
shuffleListHelper seed source result =
    if List.isEmpty source then
        result
    else
        let
            indexGenerator =
                int 0 ((List.length source) - 1)

            ( index, nextSeed ) =
                step indexGenerator seed

            valAtIndex =
                getAt index source

            sourceWithoutIndex =
                removeAt index source
        in
            case valAtIndex of
                Just val ->
                    shuffleListHelper nextSeed sourceWithoutIndex (val :: result)

                Nothing ->
                    Debug.log "generated an index outside list"[]

cardList : List Card
cardList =
        [ (genCard "Ace of Hearts" 1)
        , (genCard "2 of Hearts" 2)
        , (genCard "3 of Hearts" 3)
        , (genCard "4 of Hearts" 4)
        , (genCard "5 of Hearts" 5)
        , (genCard "6 of Hearts" 6)
        , (genCard "7 of Hearts" 7)
        , (genCard "8 of Hearts" 8)
        , (genCard "9 of Hearts" 9)
        , (genCard "10 of Hearts" 10)
        , (genCard "Knight of Hearts" 11)
        , (genCard "Dame of Hearts" 12)
        , (genCard "King of Hearts" 13)
        ,(genCard "Ace of Clubs" 1)
        ,(genCard "2 of Clubs" 2)
        ,(genCard "3 of Clubs" 3)
        ,(genCard "4 of Clubs" 4)
        ,(genCard "5 of Clubs" 5)
        ,(genCard "6 of Clubs" 6)
        ,(genCard "7 of Clubs" 7)
        ,(genCard "8 of Clubs" 8)
        ,(genCard "9 of Clubs" 9)
        ,(genCard "10 of Clubs" 10)
        ,(genCard "Knight of Clubs" 11)
        ,(genCard "Dame of Clubs" 12)
        ,(genCard "King of Clubs" 13)
        ]
