module CardStuff exposing (initialCardList, shuffleList, cardsToNames, dealOneCardToPlayers, dealCardToPlayer, calculateScores)

import Model exposing (Model, Card, Player)
import Random exposing (Seed, int, step)
import List.Extra exposing (getAt, removeAt)

genCard name value =
    Card name value

initialCardList : List Card
initialCardList =
        [(genCard "Ace of Hearts" 1)
        ,(genCard "2 of Hearts" 2)
        ,(genCard "3 of Hearts" 3)
        ,(genCard "4 of Hearts" 4)
        ,(genCard "5 of Hearts" 5)
        ,(genCard "6 of Hearts" 6)
        ,(genCard "7 of Hearts" 7)
        ,(genCard "8 of Hearts" 8)
        ,(genCard "9 of Hearts" 9)
        ,(genCard "10 of Hearts" 10)
        ,(genCard "Knight of Hearts" 10)
        ,(genCard "Queen of Hearts" 10)
        ,(genCard "King of Hearts" 10)
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
        ,(genCard "Knight of Clubs" 10)
        ,(genCard "Queen of Clubs" 10)
        ,(genCard "King of Clubs" 10)
        ,(genCard "Ace of Spades" 1)
        ,(genCard "2 of Spades" 2)
        ,(genCard "3 of Spades" 3)
        ,(genCard "4 of Spades" 4)
        ,(genCard "5 of Spades" 5)
        ,(genCard "6 of Spades" 6)
        ,(genCard "7 of Spades" 7)
        ,(genCard "8 of Spades" 8)
        ,(genCard "9 of Spades" 9)
        ,(genCard "10 of Spades" 10)
        ,(genCard "Knight of Spades" 10)
        ,(genCard "Queen of Spades" 10)
        ,(genCard "King of Spades" 10)
        ,(genCard "Ace of Diamonds" 1)
        ,(genCard "2 of Diamonds" 2)
        ,(genCard "3 of Diamonds" 3)
        ,(genCard "4 of Diamonds" 4)
        ,(genCard "5 of Diamonds" 5)
        ,(genCard "6 of Diamonds" 6)
        ,(genCard "7 of Diamonds" 7)
        ,(genCard "8 of Diamonds" 8)
        ,(genCard "9 of Diamonds" 9)
        ,(genCard "10 of Diamonds" 10)
        ,(genCard "Knight of Diamonds" 10)
        ,(genCard "Queen of Diamonds" 10)
        ,(genCard "King of Diamonds" 10)
        ]

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
addCardToPlayer player card = Player player.name (card :: player.hand) 0

calculateScores: Model -> Model
calculateScores model =
    let
        table = model.table.hand
        alteredPlayerList = List.map  mapShit  model.players  --(\x -> x )
    in Model alteredPlayerList model.table model.currentDeck

mapShit: Player -> Player
mapShit playah =
        Player playah.name playah.hand (calculatePlayerHand 0 playah.hand)

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