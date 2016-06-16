module Main exposing (..)

import Html.App as Html
import Maybe exposing ( Maybe(..) )
import Task
import Dict
import Http
import Time

import Html exposing (..)

import Model exposing (..)
import View exposing (..)
import Actions exposing (..)
import Decoder


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


init : (Model, Cmd Action)
init =
  let
      repeatex = Repeatex "daily" 1 (RepeatexList [])
      task = Time.now
  in
      ( Model "" repeatex [] 0, Task.perform (\_ -> NoAction) TimeLoaded task )


update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    Update input ->
      ( model, getRepeatex input )

    ApiSuccess newModel ->
      ( newModel, Cmd.none )

    ApiFailure _ ->
      init

    TimeLoaded time ->
      ( {model | current = time}, Cmd.none )

    _ ->
      ( model, Cmd.none )


subscriptions : Model -> Sub Action
subscriptions = (\_ -> Sub.none)


getRepeatex : String -> Cmd Action
getRepeatex input =
  let
    url = "/api?value=" ++ input
  in
    (Http.get Decoder.decodeResponse url) |> Task.perform ApiFailure ApiSuccess
