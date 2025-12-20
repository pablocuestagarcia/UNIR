module Main (main) where

import MathUtils
import Calculator

main :: IO ()
main = do
  putStrLn "=== Example of related modules usage ==="
  putStrLn ""
  
  -- Examples using MathUtils directly
  putStrLn "Basic operations (MathUtils):"
  putStrLn $ "5 + 3 = " ++ show (sumar 5 3)
  putStrLn $ "10 - 4 = " ++ show (restar 10 4)
  putStrLn $ "6 * 7 = " ++ show (multiplicar 6 7)
  putStrLn $ "15 / 3 = " ++ show (dividir 15 3)
  putStrLn $ "2^4 = " ++ show (potencia 2 4)
  putStrLn ""
  
  -- Examples using Calculator which uses MathUtils
  putStrLn "Advanced operations (Calculator using MathUtils):"
  putStrLn $ "Rectangle area 5x8 = " ++ show (areaRectangulo 5 8)
  putStrLn $ "Sum of [1,2,3,4,5] = " ++ show (sumaLista [1,2,3,4,5])
  putStrLn $ "Product of [2,3,4] = " ++ show (productoLista [2,3,4])
  putStrLn $ "Average of [10,20,30] = " ++ show (promedio [10,20,30])

