module Main exposing (..)

import Html.App as Html
import Maybe exposing ( Maybe(..) )
import Task
import Dict
import Http

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Model exposing (..)
import Encoder exposing (format)
import Decoder

type Action
  = Update String
  | ApiSuccess Model
  | ApiFailure Http.Error

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


init : (Model, Cmd Action)
init =
  ( Model "" (Repeatex "daily" 1 (RepeatexList [])), Cmd.none )


update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    Update input ->
      ( model, getRepeatex input )

    ApiSuccess newModel ->
      ( newModel, Cmd.none )

    _ ->
      ( model, Cmd.none )


view : Model -> Html Action
view model =
  div []
    [ h2 [] [ text "Try it!" ]
    , input
        [ class "large"
        , type' "text"
        , placeholder "on wednesday every week"
        , onInput Update ] []
    , br [] []
    , h3 [] [ text "Data Structure" ]
    , pre [] [ text (format model.repeats) ]
    , h3 [] [ text "Formatted" ]
    , pre [] [ text model.formatted ]
    , i []
        [ text "Is the text above not parsing correctly? Please "
        , a [ href "#" ] [ text "click here" ]
        , text " to report this as an issue." ]
    ]


subscriptions : Model -> Sub Action
subscriptions = (\_ -> Sub.none)


getRepeatex : String -> Cmd Action
getRepeatex input =
  let
    url = "/api?value=" ++ input
  in
    (Http.get Decoder.decodeResponse url) |> Task.perform ApiFailure ApiSuccess
