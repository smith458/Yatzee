import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Array exposing (..)

main =
  Browser.sandbox
    { init = init
    , view = view
    , update = update
    }


-- MODEL

type alias Model = Array Die

type alias Die =
  { value : Int
  , hold : Bool
  }

init : Model
init = 
  fromList [ newDie, newDie, newDie, newDie, newDie ]

newDie =
  { value = 1, hold = False }

highDie =
  { value = 5, hold = True }

-- UPDATE

type Msg = Hold Int

update: Msg -> Model -> Model
update msg model =
  case msg of
    Hold index ->
      set index highDie model

-- VIEW
intToText a =
  text (String.fromInt a.value)

view : Model -> Html Msg
view model = 
  div []
    [ div [] (toList(map intToText model))
    , div[]
      [ button [onClick (Hold 0)] [ text "hold"]
      , button [onClick (Hold 1)] [ text "hold"]
      , button [onClick (Hold 2)] [ text "hold"]
      , button [onClick (Hold 3)] [ text "hold"]
      , button [onClick (Hold 4)] [ text "hold"]
      ]
    ]