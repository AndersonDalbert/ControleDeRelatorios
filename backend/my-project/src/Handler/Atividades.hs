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
import Data.FileEmbed (embedFile)
import Data.Aeson

data Atividade = Atividade
	{ index :: Text
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
        [ "index" .= index
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

getAtividadesR :: Text -> Handler TypedContent
getAtividadesR text = do return $ TypedContent "application/json"
																$ toContent $(embedFile "data/E01-01.json")
