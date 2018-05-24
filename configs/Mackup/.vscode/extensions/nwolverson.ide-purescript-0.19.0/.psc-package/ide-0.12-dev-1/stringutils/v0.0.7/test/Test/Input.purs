module Test.Input
  ( CodePoint(..)
  , NegativeInt(..)
  , NewlineChar(..)
  , NonNegativeInt(..)
  , SurrogateCodePoint(..)
  , WhiteSpaceChar(..)
  , OneCharString(..)
  )
where

import Data.List                  (List, fromFoldable)
import Prelude
import Test.StrongCheck.Arbitrary (class Arbitrary, arbitrary)
import Test.StrongCheck.Gen       (chooseInt, elements)
import Unsafe.Coerce              (unsafeCoerce)


newtype CodePoint          = CodePoint Int
newtype NegativeInt        = NegativeInt Int
newtype NewlineChar        = NewlineChar Char
newtype NonNegativeInt     = NonNegativeInt Int
newtype SurrogateCodePoint = SurrogateCodePoint Int
newtype WhiteSpaceChar     = WhiteSpaceChar Char
newtype OneCharString      = OneCharString String

-- Unicode code points are in the range 0 .. U+10FFFF
instance arbCodePoint :: Arbitrary CodePoint where
  arbitrary = CodePoint <$> chooseInt 0 0x10FFFF

instance arbNegativeInt :: Arbitrary NegativeInt where
  arbitrary = NegativeInt <$> chooseInt (-2147483648) (-1)

instance arbNewlineChar :: Arbitrary NewlineChar where
  arbitrary = NewlineChar <$> elements '\n' newlineChars

instance arbNonNegativeInt :: Arbitrary NonNegativeInt where
  arbitrary = NonNegativeInt <$> chooseInt 0 2147483647

-- Surrogate code points are in the range U+D800 .. U+DFFF
instance arbSurrogateCodePoint :: Arbitrary SurrogateCodePoint where
  arbitrary = SurrogateCodePoint <$> chooseInt 0xD800 0xDFFF

instance arbWhiteSpaceChar :: Arbitrary WhiteSpaceChar where
  arbitrary = WhiteSpaceChar <$> elements ' ' whiteSpaceChars

instance arbOneCharString :: Arbitrary OneCharString where
  arbitrary = OneCharString <<< (unsafeCoerce :: Char -> String) <$> arbitrary

newlineChars :: List Char
newlineChars = fromFoldable
  [ '\n', '\v', '\f', '\r', '\x0085', '\x2028', '\x2029' ]

whiteSpaceChars :: List Char
whiteSpaceChars = fromFoldable
  [ ' ', '\f', '\n', '\r', '\t', '\v', '\x00A0', '\x1680', '\x2000', '\x2001'
  , '\x2002', '\x2003', '\x2004', '\x2005', '\x2006', '\x2007', '\x2008'
  , '\x2009', '\x200A', '\x2028', '\x2029', '\x202F', '\x205F', '\x3000'
  , '\xFEFF'
  ]
