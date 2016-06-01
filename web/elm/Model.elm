module Model exposing (..)

import Dict exposing (Dict)

type alias DaysList = List String
type alias DaysDict = Dict String Int
type alias DaysInts = List Int

type RepeatexDays
  = RepeatexList DaysList
  | RepeatexNumbers DaysInts
  | RepeatexDict DaysDict

type alias Repeatex =
  { repeatType: String
  , frequency: Int
  , days: RepeatexDays
  }

type alias Model =
  { formatted: String
  , repeats: Repeatex
  }
