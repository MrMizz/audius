module Msg.Msg exposing (Msg(..), resetViewport)

import Browser
import Browser.Dom as Dom
import Http
import Http.Audius.Response as Get
import Task
import Url


type Msg
    = NoOp
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | AudiusGet
    | AudiusGetResponse (Result Http.Error Get.Response)


resetViewport : Cmd Msg
resetViewport =
    Task.perform (\_ -> NoOp) (Dom.setViewport 0 0)
