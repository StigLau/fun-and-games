module CardStuff exposing (initialCardList, shuffleList, printCardNames)
import Html exposing (Html, text)
import Model exposing (Card)
import Random exposing (Seed, initialSeed, int, step)
import List.Extra exposing (getAt, removeAt)

genCard name value =
    Card name value


initialCardList : List Card
initialCardList =
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

