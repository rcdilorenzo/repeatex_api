module View exposing (view)

import Model exposing (..)
import Actions exposing (..)
import Encoder exposing (format)

import String
import Time exposing (Time)
import List.Extra exposing (groupsOf)
import Date.Extra.Core exposing (firstOfNextMonthDate, lastOfMonthDate, ticksADay)
import Date exposing (Date, Day(..), Month(..), day, month, year)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

view : Model -> Html Action
view model =
  let
      monthTuples = monthTuplesFrom model.current
  in
    div []
      [ h2 [] [ text "Try it!" ]
      , input
          [ class "large"
          , type' "text"
          , placeholder "on wednesday every week"
          , onInput Update ] []
      , br [] []
      , i []
          [ text "Is the text above not parsing correctly? Please "
          , a [ href "https://github.com/rcdilorenzo/repeatex/issues/new" ] [ text "click here" ]
          , text " to report this as an issue." ]
      , br [] []
      , h3 [] [ text "Data Structure" ]
      , parsed model
      , h3 [] [ text "Formatted" ]
      , pre [] [ text (if String.length(model.formatted) == 0 then "None" else model.formatted) ]
      , h3 [] [ text "Generated Dates" ]
      , table [ class "table--calendar" ]
          [ thead [] [ th [] [], th [] [] ]
          , calendarRows model monthTuples
          ]
      ]


monthTuplesFrom : Time -> List MonthTuple
monthTuplesFrom current =
    let
        times = nextMonthTime [current]
          |> nextMonthTime
          |> nextMonthTime
          |> nextMonthTime
        tupleFromTime = (\time -> (Date.fromTime time |> Date.month, Date.fromTime time |> Date.year))
    in
        List.map tupleFromTime times


nextMonthTime : List Time -> List Time
nextMonthTime existing =
    let
        last = case List.Extra.last existing of
                   Just time ->
                       time |> Date.fromTime |> lastOfMonthDate
                   Nothing ->
                       Date.fromTime 0
        nextDayTime = (Date.toTime last) + toFloat ticksADay
    in
        existing ++ [nextDayTime]



calendarRows : Model -> List MonthTuple -> Html Action
calendarRows model monthTuples =
    let
        calendarFrom = (\monthTuple -> dateCalendar monthTuple model)
        rowFromTuples = (\twoTuples -> tr [] (List.map calendarFrom twoTuples))
        grouped = groupsOf 2 monthTuples
        rows = List.map rowFromTuples grouped
    in
        tbody [] rows


parsed : Model -> Html Action
parsed model =
  let
      parsedString = if (String.length model.formatted) == 0 then "None" else (format model.repeats)
  in
      pre [] [ text parsedString ]


dateCalendar : MonthTuple -> Model -> Html Action
dateCalendar (month, year) model =
    let
        datesForCalendar = datesList month year
    in
      td [ class "calendar" ]
          [ dateHeader (month, year) model
          , div [ class "calendar__content" ]
              (List.map (\dates -> dateRow model dates (month, year)) datesForCalendar)
          ]

dateHeader : MonthTuple -> Model -> Html Action
dateHeader (month, year) model =
    div [ class "calendar__header" ]
        [ h1 [] [ text (dateHeaderTitle month year)]
        , div [ class "calendar__days" ]
            [ span [ class "calendar__day" ] [ text "Su" ]
            , span [ class "calendar__day" ] [ text "Mo" ]
            , span [ class "calendar__day" ] [ text "Tu" ]
            , span [ class "calendar__day" ] [ text "We" ]
            , span [ class "calendar__day" ] [ text "Th" ]
            , span [ class "calendar__day" ] [ text "Fr" ]
            , span [ class "calendar__day" ] [ text "Sa" ]
            ]
        ]


dateRow : Model -> List Date -> MonthTuple -> Html Action
dateRow model dates monthTuple =
    div [ class "calendar__row" ]
        (List.map (\date -> dateCell model date monthTuple) dates)


dateCell : Model -> Date -> MonthTuple -> Html Action
dateCell model date monthTuple =
    span [ class ("calendar__cell" ++ (dateCellClass model date monthTuple)) ]
        [ text (Date.day date |> toString) ]


dateCellClass : Model -> Date -> MonthTuple -> String
dateCellClass model date (month, year) =
    let
        outside = if (Date.month date) == month then "" else " calendar__cell--outside"
        selected = if (selectedDate model date) then " calendar__cell--selected" else ""
    in
        outside ++ selected


selectedDate : Model -> Date -> Bool
selectedDate model date =
    let
        evaluator = (\existing -> (dateToTuple existing) == (dateToTuple date))
    in
        List.any evaluator model.dates


dateToTuple : Date -> DateTuple
dateToTuple date =
    (Date.month date, Date.day date, Date.year date)


formatMonth : Month -> String
formatMonth month =
    case month of
        Jan ->
            "January"
        Feb ->
            "February"
        Mar ->
            "March"
        Apr ->
            "April"
        May ->
            "May"
        Jun ->
            "June"
        Jul ->
            "July"
        Aug ->
            "August"
        Sep ->
            "September"
        Oct ->
            "October"
        Nov ->
            "November"
        Dec ->
            "December"


dateHeaderTitle : Month -> Year -> String
dateHeaderTitle month year =
    (formatMonth month) ++ " " ++ (toString year)

