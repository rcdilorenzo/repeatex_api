module Decoder exposing (..)

import Model exposing (..)
import Json.Decode as Json
import Json.Decode exposing (..)

decodeResponse : Json.Decoder Model
decodeResponse =
  object2 Model
    ("formatted" := string)
    ("parsed" := decodeParsed)


decodeParsed : Json.Decoder Repeatex
decodeParsed =
  object3 Repeatex
    ("type" := string)
    ("frequency" := int)
    ("days" := decodeDays)


decodeDays : Json.Decoder RepeatexDays
decodeDays =
  oneOf
    [ (list string) `andThen` decodeAsListOfStrings
    , (list int) `andThen` decodeAsListOfInts
    , (dict int) `andThen` decodeAsDict
    ]


decodeAsDict : DaysDict -> Json.Decoder RepeatexDays
decodeAsDict days =
  Json.succeed (RepeatexDict days)


decodeAsListOfStrings : DaysList -> Json.Decoder RepeatexDays
decodeAsListOfStrings days =
  Json.succeed (RepeatexList days)


decodeAsListOfInts : DaysInts -> Json.Decoder RepeatexDays
decodeAsListOfInts days =
  Json.succeed (RepeatexNumbers days)
