import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Array exposing (..)
import Dict exposing (..)
import Random

main =
  Browser.sandbox
    { init = init
    , view = view
    , update = update
    }


-- MODEL

type alias Model =
  { dice : Array Die
  , roll : Int
  , options : Dict String (List Int -> Int)
  , scorecard : Dict String Int
  }

type alias Die =
  { value : Int
  , hold : Bool
  }

init : Model
init = 
  { dice = Array.fromList [ newDie, newDie, newDie, newDie, newDie ]
  , roll = 1
  , options = Dict.empty
  , scorecard = Dict.empty
  }
  
seed = 12345744

newDie =
  { value = 1, hold = False }

highDie =
  { value = 5, hold = True }

dieRoll =
  Random.int 1 6

scoreOptions = Dict.fromList
  [ ("Ones", \a -> 10)
  , ("Twos", \a -> 10)
  ]


-- UPDATE

type Msg = Hold Int | Roll

update: Msg -> Model -> Model
update msg model =
  case msg of
    Hold index ->
      { model | dice = (set index highDie model.dice)}

    Roll ->
      { model | roll = model.roll + 1}

-- VIEW
intToText a =
  text (String.fromInt a.value)

view : Model -> Html Msg
view model = 
  div []
    [ div [] (Array.toList(Array.map intToText model.dice))
    , div[]
      [ button [onClick (Hold 0)] [ text "Hold"]
      , button [onClick (Hold 1)] [ text "Hold"]
      , button [onClick (Hold 2)] [ text "Hold"]
      , button [onClick (Hold 3)] [ text "Hold"]
      , button [onClick (Hold 4)] [ text "Hold"]
      ]
    , button [onClick Roll] [ text "Roll"]
    , text (String.fromInt model.roll)
    ]