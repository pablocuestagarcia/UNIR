module MathUtils
  ( sumar
  , restar
  , multiplicar
  , dividir
  , potencia
  ) where

-- Adds two numbers
sumar :: Num a => a -> a -> a
sumar x y = x + y

-- Subtracts two numbers
restar :: Num a => a -> a -> a
restar x y = x - y

-- Multiplies two numbers
multiplicar :: Num a => a -> a -> a
multiplicar x y = x * y

-- Divides two numbers (returns Nothing if divisor is 0)
dividir :: (Fractional a, Eq a) => a -> a -> Maybe a
dividir _ 0 = Nothing
dividir x y = Just (x / y)

-- Calculates the power of a number
potencia :: (Num a, Integral b) => a -> b -> a
potencia _ 0 = 1
potencia x n
  | n < 0 = error "Cannot calculate negative power with this type"
  | otherwise = x * potencia x (n - 1)

