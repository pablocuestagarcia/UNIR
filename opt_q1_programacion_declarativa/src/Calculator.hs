module Calculator
  ( areaRectangulo
  , promedio
  , sumaLista
  , productoLista
  ) where

import MathUtils

-- Calculates the area of a rectangle using multiplicar from MathUtils
areaRectangulo :: Num a => a -> a -> a
areaRectangulo ancho alto = multiplicar ancho alto

-- Calculates the average of a list of numbers
promedio :: Fractional a => [a] -> Maybe a
promedio [] = Nothing
promedio xs = Just (sumaLista xs / fromIntegral (length xs))

-- Sums all elements of a list using sumar from MathUtils
sumaLista :: Num a => [a] -> a
sumaLista = foldr sumar 0

-- Multiplies all elements of a list using multiplicar from MathUtils
productoLista :: Num a => [a] -> a
productoLista = foldr multiplicar 1

