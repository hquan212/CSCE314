
-- Assignment 3, CSCE-314
-- Section: 500
-- Student Name: Robert Quan

import Data.Char

----------------------------------------------------------
--Data Types

type Grid = Matrix Int

type Matrix a = [Row a]

type Row a = [a]

-----------------------------------------------------------
--Fucntions

sort :: [Int] -> [Int]
--Sorts a list of ints in numeric order
sort [] = []
sort xs = msort xs

isValid :: Grid -> Bool
isValid g = if (sort [x| xs <- g, x <- xs] == [1..9]) 
            then True else False

isMagic :: Grid -> Bool
isMagic ys = (magCol xs) && (magRow xs) && (magDia xs)
       where xs = concat ys
--
magCol ys = (ys!!0+ys!!3+ys!!6)==15 && (ys!!1+ys!!4+ys!!7)==15 && (ys!!2+ys!!5+ys!!8)==15
magRow ys = (ys!!0+ys!!1+ys!!2)==15 && (ys!!3+ys!!4+ys!!5)==15 && (ys!!6+ys!!7+ys!!8)==15
magDia ys = (ys!!0+ys!!4+ys!!8)==15 && (ys!!2+ys!!4+ys!!6)==15


choices :: Matrix [Int] 
choices = replicate 3 (replicate 3 [1..9])

cp :: [[a]] -> [[a]]
cp [] = [[]]
cp (xs:xss) = [x:ys | x<-xs,ys<-(cp xss)]
--
--example
example :: Matrix [Int]
example = [[[1],[2],[3]],[[4],[5],[6]],[[7],[8,9],[8,9]]]

collapse :: Matrix [a] -> [Matrix a]
collapse xss = cp (map cp xss)

magics :: [Grid]
magics  = filter (\x -> isMagic x && isValid x) (collapse choices)

----------------------------------------------------------
--helper functions

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys) | x < y = x:(merge xs (y:ys))
                    | True  = y:(merge (x:xs) ys)

halve :: [a] -> ([a],[a])
halve xs = ((take (length xs `div` 2) xs),(drop (length xs `div` 2) xs))

msort :: Ord a => [a] -> [a]
msort [] = []
msort (x:[]) = [x]
msort xs = merge (msort (fst half)) (msort (snd half))
       where half = halve xs


--------------------------------------------------------
--testing

mymatrix :: Grid
mymatrix = [[2,7,6],[9,5,1],[4,3,8]]


