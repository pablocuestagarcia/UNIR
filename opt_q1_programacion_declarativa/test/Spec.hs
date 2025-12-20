import Test.Hspec
import MathUtils
import Calculator

main :: IO ()
main = hspec $ do
  describe "MathUtils" $ do
    describe "sumar" $ do
      it "adds two positive numbers" $ do
        sumar 5 3 `shouldBe` 8
      it "adds negative numbers" $ do
        sumar (-5) (-3) `shouldBe` (-8)
      it "adds zero" $ do
        sumar 10 0 `shouldBe` 10
    
    describe "restar" $ do
      it "subtracts two positive numbers" $ do
        restar 10 4 `shouldBe` 6
      it "subtracts negative numbers" $ do
        restar 5 (-3) `shouldBe` 8
    
    describe "multiplicar" $ do
      it "multiplies two positive numbers" $ do
        multiplicar 6 7 `shouldBe` 42
      it "multiplies by zero" $ do
        multiplicar 10 0 `shouldBe` 0
      it "multiplies negative numbers" $ do
        multiplicar (-5) 3 `shouldBe` (-15)
    
    describe "dividir" $ do
      it "divides two positive numbers" $ do
        dividir 15 3 `shouldBe` Just 5.0
      it "returns Nothing when dividing by zero" $ do
        dividir 10 0 `shouldBe` Nothing
      it "divides decimal numbers" $ do
        dividir 7 2 `shouldBe` Just 3.5
    
    describe "potencia" $ do
      it "calculates power of 2^4" $ do
        potencia 2 4 `shouldBe` 16
      it "calculates power of 3^3" $ do
        potencia 3 3 `shouldBe` 27
      it "any number raised to 0 is 1" $ do
        potencia 5 0 `shouldBe` 1
      it "any number raised to 1 is the same number" $ do
        potencia 7 1 `shouldBe` 7

  describe "Calculator" $ do
    describe "areaRectangulo" $ do
      it "calculates area of a 5x8 rectangle" $ do
        areaRectangulo 5 8 `shouldBe` 40
      it "calculates area of a 3x3 rectangle" $ do
        areaRectangulo 3 3 `shouldBe` 9
      it "calculates area when one side is zero" $ do
        areaRectangulo 10 0 `shouldBe` 0
    
    describe "sumaLista" $ do
      it "sums a list of positive numbers" $ do
        sumaLista [1,2,3,4,5] `shouldBe` 15
      it "sums an empty list" $ do
        sumaLista ([] :: [Int]) `shouldBe` 0
      it "sums a list with a single element" $ do
        sumaLista [42] `shouldBe` 42
      it "sums a list with negative numbers" $ do
        sumaLista [10, -5, 3] `shouldBe` 8
    
    describe "productoLista" $ do
      it "multiplies a list of numbers" $ do
        productoLista [2,3,4] `shouldBe` 24
      it "multiplies an empty list (should be 1)" $ do
        productoLista ([] :: [Int]) `shouldBe` 1
      it "multiplies a list with a single element" $ do
        productoLista [7] `shouldBe` 7
      it "multiplies a list with zeros" $ do
        productoLista [1,2,0,4] `shouldBe` 0
    
    describe "promedio" $ do
      it "calculates average of a list" $ do
        promedio [10,20,30] `shouldBe` Just 20.0
      it "returns Nothing for empty list" $ do
        promedio ([] :: [Double]) `shouldBe` Nothing
      it "calculates average of a single element" $ do
        promedio [42] `shouldBe` Just 42.0
      it "calculates average of decimal numbers" $ do
        promedio [1.5, 2.5, 3.5] `shouldBe` Just 2.5

