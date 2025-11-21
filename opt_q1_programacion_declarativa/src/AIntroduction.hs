module AIntroduction where

main :: IO ()
main = putStrLn "¡Hola desde Haskell Introduction!"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

