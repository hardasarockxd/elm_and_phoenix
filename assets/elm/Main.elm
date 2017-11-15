module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (..)
import UrlParser exposing (..)


--Main


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = initModel
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



--Model


type alias Model =
    { page : Page
    , users : List User
    , username : String
    , userage : String
    }


type alias User =
    { name : String
    , age : String
    }


initialModel : Page -> Model
initialModel page =
    { page = page
    , username = ""
    , userage = "0"
    , users =
        [ { name = "Yegor", age = "18" }
        , { name = "Kirill", age = "18" }
        ]
    }


type Page
    = FirstPage
    | SecondPage
    | NoPage


initModel : Navigation.Location -> ( Model, Cmd Msg )
initModel location =
    let
        newModel =
            initialModel (parser location)
    in
    urlUpdate newModel


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.page of
        _ ->
            model ! []



--Update


type Msg
    = ChangePage Page
    | UrlChange Navigation.Location
    | InputUsername String
    | InputUserage String
    | AddUser


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            ( model, Navigation.newUrl (toPath page) )

        UrlChange location ->
            let
                newRoute =
                    parser location
            in
            urlUpdate { model | page = newRoute }

        InputUsername name ->
            ( { model | username = name }, Cmd.none )

        InputUserage age ->
            ( { model | userage = age }, Cmd.none )

        AddUser ->
            ( { model | users = { name = model.username, age = model.userage } :: model.users }, Cmd.none )


toPath : Page -> String
toPath page =
    case page of
        FirstPage ->
            "/first_page"

        SecondPage ->
            "/second_page"

        NoPage ->
            "/"



--Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



--View


allUsersLi : User -> Html Msg
allUsersLi usr =
    li [] [ text <| "NAME: " ++ usr.name ++ " | " ++ "AGE: " ++ usr.age ]


view : Model -> Html Msg
view model =
    let
        currentPage =
            case model.page of
                FirstPage ->
                    div []
                        [ h2 []
                            [ text "USERS" ]
                        , ul
                            []
                            (List.map allUsersLi model.users)
                        ]

                SecondPage ->
                    div []
                        [ h2 [] [ Html.text "Add users" ]
                        , Html.form [ onSubmit AddUser ]
                            [ input [ onInput InputUsername, type_ "text", placeholder "username * " ] []
                            , input [ onInput InputUserage, type_ "text", placeholder "age * " ] []
                            , input [ type_ "submit", value "SUBMIT" ] []
                            ]
                        ]

                NoPage ->
                    div [ style [ ( "display", "none" ) ] ] []
    in
    section []
        [ currentPage
        , button [ onClick (ChangePage SecondPage) ] [ text "Change Page to Page N 2" ]
        , button [ onClick (ChangePage FirstPage) ] [ text "Change Page to Page N 1" ]
        ]



--ROUTING


matcher : Parser (Page -> a) a
matcher =
    oneOf
        [ UrlParser.map FirstPage (UrlParser.s "first_page")
        , UrlParser.map SecondPage (UrlParser.s "second_page")
        ]


parser : Navigation.Location -> Page
parser location =
    case UrlParser.parsePath matcher location of
        Just sth ->
            sth

        Nothing ->
            NoPage
