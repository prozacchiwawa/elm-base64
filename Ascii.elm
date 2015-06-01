module Ascii (fromInt, toInt, isValid, isAsciiChar) where

import Array exposing (Array)
import String
import Dict exposing (Dict)
import List
import Maybe
import Result
import Result exposing (fromMaybe)


fromInt : Int -> Result String Char
fromInt int =
  fromMaybe "integer has no corresponding ascii char" (Array.get (int-32) asciiCharsArray)

toInt : Char -> Result String Int
toInt char =
  fromMaybe "char is not a supported ascii character" (Dict.get char asciiCharsMap)

isValid : String -> Bool
isValid string =
  List.all isAsciiChar (String.toList string)

isAsciiChar : Char -> Bool
isAsciiChar char =
  Dict.member char asciiCharsMap

asciiCharsArray : Array Char
asciiCharsArray =
  Array.fromList asciiCharsList

asciiCharsList : List Char
asciiCharsList =
  String.toList " !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"

asciiCharsMap : Dict Char Int
asciiCharsMap =
  List.foldl insertPairIntoDict Dict.empty asciiCharPairList

insertPairIntoDict : (comparable , v) -> Dict comparable v -> Dict comparable v
insertPairIntoDict (key , value) dict =
  Dict.insert key value dict

asciiCharPairList : List (Char,Int)
asciiCharPairList =
  List.map2 (,) asciiCharsList [32..126]
