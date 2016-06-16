module Actions exposing (..)

import Time exposing (Time)
import Http
import Model exposing (..)

type Action
  = Update String
  | ApiSuccess Model
  | ApiFailure Http.Error
  | TimeLoaded Time
  | NoAction
