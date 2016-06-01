module Encoder exposing (..)

import Json.Encode exposing (..)
import List exposing (map)
import Dict exposing (toList)
import Model exposing (..)

format : Repeatex -> String
format repeatex =
  encode 2 (repeatexEncoder repeatex)

repeatexEncoder : Repeatex -> Json.Encode.Value
repeatexEncoder repeatex =
  case repeatex.days of
    RepeatexList days ->
      object
        [ ("type", string repeatex.repeatType)
        , ("frequency", int repeatex.frequency)
        , ("days", list (map (\day -> string day) days))
        ]

    RepeatexDict days ->
      object
        [ ("type", string repeatex.repeatType)
        , ("frequency", int repeatex.frequency)
        , ("days", dictEncoder int days)
        ]

    RepeatexNumbers days ->
      object
        [ ("type", string repeatex.repeatType)
        , ("frequency", int repeatex.frequency)
        , ("days", list (map (\day -> int day) days))
        ]


dictEncoder enc dict =
   toList dict
     |> map (\(k,v) -> (k, enc v))
     |> object
