module CardStuff exposing (shuffleList, cardsToNames, dealOneCardToPlayers, dealCardToPlayer, calculateScores)

import Model exposing (Model, Card, Player)
import Random exposing (Seed, int, step)
import List.Extra exposing (getAt, removeAt)

cardsToNames: List Card ->  List String
cardsToNames cards =
    case cards of
            [] -> []
            [x] -> [x.name]
            head :: tail -> head.name :: " - " :: cardsToNames tail

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

dealOneCardToPlayers: Model -> Model
dealOneCardToPlayers model =
    case model.players of
        [] -> Model [] model.table model.currentDeck
        head :: tail ->
                let
                    (headPlayer, firstStack) = dealCardToPlayer head model.currentDeck
                    modifiedModel = dealOneCardToPlayers (Model tail model.table firstStack)
                in
                    Model (headPlayer :: modifiedModel.players) model.table modifiedModel.currentDeck

dealCardToPlayer: Player -> List Card -> (Player, List Card)
dealCardToPlayer   singlePlayer stack =
        case stack of
                [] -> (singlePlayer, []) --No cards left to deal
                head :: tail -> (addCardToPlayer singlePlayer head, tail)

addCardToPlayer: Player -> Card -> Player
addCardToPlayer player card =
    {player | hand = (card :: player.hand) }

calculateScores: Model -> Model
calculateScores model =
     { model | players = (calculatePerPlayer model.players model.table.hand) }

calculatePerPlayer: List Player -> List Card -> List Player
calculatePerPlayer players table =
    case players of
        [] -> []
        head :: tail ->
                Player head.name head.hand (calculatePlayerHand head.score (List.append table head.hand)) :: (calculatePerPlayer tail table)


{-- Could not be used since Ace has many optional paths
--      Player playah.name playah.hand (List.foldl cardFoldFunction 0 playah.hand)

cardFoldFunction: (Card -> Int -> Int)
cardFoldFunction card accumulated =
    card.cardId + accumulated
-}

calculatePlayerHand: Int -> List Card  -> Int
calculatePlayerHand accScore cards  =
    case cards of
        [] -> accScore
        head :: tail  ->
            case head.cardId of
                1 -> dealWithAce accScore tail
                x -> calculatePlayerHand (accScore + x) tail

dealWithAce: Int -> List Card -> Int
dealWithAce accScore tail =
    let
        oneAlt = calculatePlayerHand (accScore + 1) tail
        elevenAlt = calculatePlayerHand (accScore + 11) tail
    in
        if (elevenAlt <= 21)
            then elevenAlt
        else oneAlt