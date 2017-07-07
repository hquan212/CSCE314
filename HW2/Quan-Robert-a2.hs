
-- Assignment 2, CSCE-314
-- Section: 500
-- Student Name: Robert Quan

import Data.List
import Data.Char


---- Part 1.
-- Problem 1 -- Remove leading white space from a string

noSpace :: String -> String
noSpace (' ':s) = noSpace s
noSpace s = s

cutWhitespace :: [String] -> [String]
cutWhitespace [] = []
cutWhitespace xs = map noSpace xs

-- Problem 2
helpMulti :: [Int] -> [Int] -> [Int]
helpMulti [] [] = []
helpMulti (x:xs) (y:ys) = [x*y] ++ helpMulti xs ys

multListt :: [[Int]] -> [[Int]] -> [[Int]]
multListt [] [] = []
multListt (xs:xss) (ys:yss) = helpMulti xs ys : multListt xss yss

---- Part 2.
-- Problem 3
--3.1

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys) | x < y = x:(merge xs (y:ys))
                    | True  = y:(merge (x:xs) ys)

--3.2
halve :: [a] -> ([a],[a])
halve xs = ((take (length xs `div` 2) xs),(drop (length xs `div` 2) xs))

msort :: Ord a => [a] -> [a]
msort [] = []
msort (x:[]) = [x]
msort xs = merge (msort (fst half)) (msort (snd half))
       where half = halve xs

-- Problem 4
multiply :: [Int] -> Int
multiply = foldr (*) 1

-- Problem 5
concatenate :: [String] -> String     
concatenate = foldl (++) ""  

-- Problem 6
concatenateAndUpcaseOddLengthStrings :: [String] -> String
concatenateAndUpcaseOddLengthStrings []  = []
concatenateAndUpcaseOddLengthStrings xs = helper xs

helper :: [[Char]] -> [Char]
helper xs = concatenate (map (map toUpper) (filter (odd.length) xs))


---- Part 3.
data Tree a b = Branch b (Tree a b) (Tree a b)
              | Leaf a
                deriving (Show)


-- Problem 7
preorder  :: (a -> c) -> (b -> c) -> Tree a b -> [c]
preorder f g (Leaf a)        = [f a]
preorder f g (Branch b l r)  = [g b] ++ (preorder f g l) ++ (preorder f g r)

inorder   :: (a -> c) -> (b -> c) -> Tree a b -> [c]
inorder f g (Leaf a)         = [f a]
inorder f g (Branch b l r)   = (inorder f g l) ++ [g b] ++ (inorder f g r)

---- Part 4. 
data E = IntLit Int
       | BoolLit Bool
       | Plus E E    -- for addition
       | Mult E E    -- for multiplication
       | Equals E E
         deriving (Eq, Show)

-- Problem 8
eval :: E -> E
eval (IntLit a)    = IntLit a
eval (BoolLit a)   = BoolLit a
eval (Plus l r)    = IntLit( (evalhelper (eval l)) + (evalhelper (eval r)))
eval (Mult l r)    = IntLit( (evalhelper (eval l)) * (evalhelper (eval r)))
eval (Equals l r)  = BoolLit ((eval l) == (eval r)) 


evalhelper :: E -> Int
evalhelper (IntLit a) = a


mytree = Branch "A" 
           (Branch "B" 
              (Leaf 1) 
              (Leaf 2)) 
           (Leaf 3)

prog1 = Equals 
           (Plus (IntLit 1) (IntLit 9))
           (Mult
              (IntLit 5)
              (Plus (IntLit 1) (IntLit 1)))

prog2 = Equals
           (Equals
              (Mult (IntLit 4) (IntLit 2))
              (Plus (IntLit 5) (Mult (IntLit 2) (IntLit 1))))
           (Equals (BoolLit True) (BoolLit True))

{-  
myTestList =

  let te s e a = test $ assertEqual s e a
      tb s b = test $ assertBool s b
  in
    TestList [ 

      , te "multiply" 10 (multiply [-2, -1, 5])
      
      , te "concatenate" "ABCD" (concatenate ["AB", "", "", "C", "D", ""])

      , te "concatenateAndUpcaseOddLengthStrings"
          "HERE'S AN EXAMPLE" (concatenateAndUpcaseOddLengthStrings ["here's ", "an ", "a ", "example"])

      , te "preorder" "AB123" (concatenate (preorder show id mytree))
      , te "inorder" "1B2A3" (concatenate (inorder show id mytree))

      , te "eval1" (BoolLit True) (eval prog1)
      , te "eval2" (BoolLit False) (eval prog2)
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
 -}
