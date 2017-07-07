
-- Comment
-- Assignment 1, CSCE 314 Section 100
-- Student Name: Robert Quan

module Main where

import Test.HUnit
import System.Exit

-- Problem 2 --Get the nth fibonacci number
fibonacci :: Int -> Int
fibonacci n | n<=2      = 1
            | otherwise = fibonacci(n-1) + fibonacci(n-2)

-- Problem 3 -- Multiply all the values in a list
myProduct :: [Integer] -> Integer
myProduct []     = 0
myProduct (x:[]) = x
myProduct (x:xs) = x*myProduct xs

-- Problem 4 --flatten that flattens a list of lists to a single list formed by concatenation
flatten :: [[a]] -> [a]
flatten []       = []
flatten (x:xs) = x ++ flatten xs

-- Problem 5 --myLength counts the numer of elements in a list
myLength :: [a] -> Int
myLength []     = 0
myLength (_:xs) = 1 + myLength xs

-- Problem 6 --quicksort in ascending order
quicksort :: Ord t => [t] -> [t]
quicksort []       = []
quicksort (x:xs)   = quicksort smaller ++ [x] ++ quicksort larger
     where
           smaller = [a | a <- xs, a <= x]
           larger  = [b | b <- xs, b > x]

-- Problem 7 -- Return true if a value is in a given list
isElement :: Eq a => a -> [a] -> Bool
isElement a []                   = False
isElement a (x:xs)   | a == x    = True
                     | a /= x    = isElement a xs
                     | otherwise = False


--Problem 8 -- Remove even numbers from a list of lists
removeEven :: [[Int]] -> [[Int]]
removeEven [] = []
removeEven (xs:xss) = [[x | x <- xs, odd x]] ++ removeEven xss


--Problem 10 -- takes two lists of same length and interleave their elements
riffle :: [a] -> [a] -> [a]
riffle [] [] = []
riffle (x:xs) (n:ns) = [x] ++ [n] ++ riffle xs ns

--Problem 11 -- Define shuffle
shuffle :: Int -> [a] -> [a]
shuffle 0 xs = xs
shuffle n xs = shuffle (n-1) (riffle (take l xs) (drop l xs)) 
     where l = (length xs) `div` 2 

--Problem 12 -- define the function perfects.
perfects :: Int -> [Int]
perfects x = [y| y <-[1..x], (sum (factors y)) == y]

factors :: Int -> [Int]
factors n = [x| x<-[1..n-1], (n `mod` x) == 0]

--Problem 13 -- show the library function replicate
replicate' :: Int -> a -> [a]
replicate' n x = [x | _ <-[1..n]] 

--------------------------------------------------------------------------------------
myTestList = 
  TestList [ 
    "fibonacci" ~: fibonacci 4 ~=? 3

    , "myProduct" ~: myProduct [1..10] ~=? 3628800
    
    , "flatten 1" ~: flatten [[]::[Int]] ~=? []
    , "flatten 2" ~: flatten [[]::[Int], [], []] ~=? []
    , "flatten 3" ~: flatten [[1], [2, 3, 4], [], [5, 6]] ~=? [1, 2, 3, 4, 5, 6]
      
    , "myLength" ~: myLength [1, 2, 3] ~=? 3

    , "quicksort 1" ~: quicksort [3, 2, 5, 1, 6] ~=? [1,2,3,5,6]
    , "quicksort 2" ~: quicksort "howdy" ~=? "dhowy"
    
    , "isElement 1" ~: (isElement 'c' "abcd") ~=? True
    , "isElement 2" ~: (isElement 'e' "abcd") ~=? False
      
   
    ]

main = do c <- runTestTT myTestList
          putStrLn $ show c
          let errs = errors c
              fails = failures c
          exitWith (codeGet errs fails)
          
codeGet errs fails
 | fails > 0       = ExitFailure 2
 | errs > 0        = ExitFailure 1
 | otherwise       = ExitSuccess
