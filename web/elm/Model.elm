module Model exposing (..)

import Time exposing (Time)
import List
import List.Extra exposing (groupsOf)
import Dict exposing (Dict)
import Date exposing (Date, Month(..), Day(..), dayOfWeek)
import Date.Extra.Create exposing (dateFromFields)
import Date.Extra.Core exposing (daysInMonth, daysBackToStartOfWeek, prevMonth, nextMonth)

type alias DaysList = List String
type alias DaysDict = Dict String Int
type alias DaysInts = List Int

type alias Year = Int
type alias DateTuple = (Month, Int, Year)
type alias MonthTuple = (Month, Year)

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
  , dates: List Date
  , current: Time
  }


datesList : Month -> Year -> List (List Date)
datesList month year =
    let
        daysCount = (daysInMonth year month)
        firstDayOfMonth = dateFromTuple (month, 1, year) |> dayOfWeek
        lastDayOfMonth = dateFromTuple (month, daysCount, year) |> dayOfWeek
        previousDates = lastDates (daysBackToStartOfWeek firstDayOfMonth Sun) (previousMonthAndYear month year)
        currentDates = firstDates daysCount (month, year)
        nextDates = firstDates (daysUntilEndOfWeek lastDayOfMonth) (nextMonthAndYear month year)
    in
        previousDates ++ currentDates ++ nextDates
            |> groupsOf 7


previousMonthAndYear : Month -> Year -> MonthTuple
previousMonthAndYear month year =
    case month of
        Jan ->
            (Dec, year - 1)
        _ ->
            (prevMonth month, year)


nextMonthAndYear : Month -> Year -> MonthTuple
nextMonthAndYear month year =
    case month of
        Dec ->
            (Jan, year + 1)
        _ ->
            (nextMonth month, year)


lastDates : Int -> MonthTuple -> List Date
lastDates last (month, year) =
    let
        end = daysInMonth year month
        start = end - last + 1
        range = [start..end]
    in
        List.map (\day -> dateFromTuple (month, day, year)) range


firstDates : Int -> MonthTuple -> List Date
firstDates first (month, year) =
    let
        range = [1..first]
    in
        List.map (\day -> dateFromTuple (month, day, year)) range


dateFromTuple : DateTuple -> Date
dateFromTuple (month, day, year) =
    dateFromFields year month day 0 0 0 0


daysUntilEndOfWeek : Date.Day -> Int
daysUntilEndOfWeek day =
    case day of
        Sun ->
            6
        Mon ->
            5
        Tue ->
            4
        Wed ->
            3
        Thu ->
            2
        Fri ->
            1
        Sat ->
            0
