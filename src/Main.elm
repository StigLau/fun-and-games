module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random

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
  ( Model 1 [(genCard "Heart 2" 2) ]
  , Cmd.none
  )

genCard name value =
    Card name value

-- UPDATE
type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( Model newFace []
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
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    , div [] [text "WHITESPACE"]
    , text "Mordi er en geit"
    ]
