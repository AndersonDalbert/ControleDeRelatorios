{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Handler.Notas where

import Import
import Data.Text (Text)

import Reader.GogolReader

data Nota = Nota
    { idNota :: Text
    , estudante :: Text
    , roteiro01 :: Text
    , roteiro02 :: Text
    , roteiro03 :: Text
    , roteiro04 :: Text
    , roteiro05 :: Text
    , roteiro06 :: Text
    , mediaRoteiros :: Text
    , provaParcial :: Text
    , projeto :: Text
    , provaFinal :: Text
    , mediaFinal :: Text
    } deriving (Eq,Show)

instance ToJSON Nota where
    toJSON Nota {..} = object
        [ "idNota" .= idNota
        , "estudante" .= estudante
        , "roteiro01" .= roteiro01
        , "roteiro02" .= roteiro02
        , "roteiro03" .= roteiro03
        , "roteiro04" .= roteiro04
        , "roteiro05" .= roteiro05
        , "roteiro06" .= roteiro06
        , "mediaRoteiros" .= mediaRoteiros
        , "provaParcial" .= provaParcial
        , "projeto" .= projeto
        , "provaFinal" .= provaFinal
        , "mediaFinal" .= mediaFinal
        ]

makeItem :: [Text] -> [Nota]
makeItem [] = []
makeItem [idNota, estudante, roteiro01, roteiro02, roteiro03, roteiro04, roteiro05, roteiro06, mediaRoteiros, provaParcial, projeto, provaFinal, mediaFinal] =
     [Nota idNota estudante roteiro01 roteiro02 roteiro03 roteiro04 roteiro05 roteiro06 mediaRoteiros provaParcial projeto provaFinal mediaFinal]
makeItem _ = []
        
makeItems :: [[Value]] -> [Nota]
makeItems [] = []
makeItems (x:xs) = (makeItem (extractTexts x)) ++ makeItems xs

optionsNotasR :: Handler RepPlain
optionsNotasR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    return $ RepPlain $ toContent ("" :: Text)

getNotasR :: Handler Value
getNotasR = do
    addHeader "Access-Control-Allow-Origin" "*"
    sheet <- liftIO $ (coletarDados "" "Sheet1!A:M")
    returnJson $ makeItems sheet
