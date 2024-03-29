module CardSetup exposing (initialCardList)
import Model exposing (Card)

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