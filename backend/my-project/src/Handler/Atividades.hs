{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Handler.Atividades where

import Import
import Data.Text (Text)

import Reader.GogolReader

data Atividade = Atividade
    { aindex :: Text
    , nome :: Text
    , matricula :: Text
    , dataEnvio :: Text
    , passou :: Text
    , erros :: Text
    , falhas :: Text
    , pulados :: Text
    , notaTestes :: Text
    , notaDesign :: Text
    , nota :: Text
    }

instance ToJSON Atividade where
    toJSON Atividade {..} = object
        [ "index" .= aindex
        , "nome" .= nome
        , "matricula" .= matricula
        , "dataEnvio" .= dataEnvio
        , "passou" .= passou
        , "erros" .= erros
        , "falhas" .=falhas
        , "pulados" .= pulados
        , "notaTestes" .= notaTestes
        , "notaDesign" .= notaDesign
        , "nota" .= nota
        ]

makeItem :: [Text] -> Text -> [Atividade]
makeItem [] _ = []
makeItem [aindex, nome, matricula, dataEnvio, passou, erros, falhas, pulados, notaTestes, notaDesign, nota] nomeAtv
    | nome == nomeAtv = [Atividade aindex nome matricula dataEnvio passou erros falhas pulados notaTestes notaDesign nota]
    | otherwise = []
makeItem _ _ = []
        
makeItems :: [[Value]] -> Text -> [Atividade]
makeItems [] _ = []
makeItems (x:xs) nomeAtv = (makeItem (extractTexts x) nomeAtv) ++ makeItems xs nomeAtv
        
optionsAtividadesR :: Text -> Handler RepPlain
optionsAtividadesR nomeAtv = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    return $ RepPlain $ toContent ("" :: Text)

getAtividadesR :: Text -> Handler Value
getAtividadesR nomeAtv = do
    addHeader "Access-Control-Allow-Origin" "*"
    sheet <- liftIO $ (coletarDados "" "Sheet1!A:K")
    returnJson $ makeItems sheet nomeAtv
