{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Cronograma where

import Import
import Data.Text (Text)

-- 	Monitores	Corretor	Data Inicio Correcao	Data Entrega Correcao	Links Video Aulas
data ItemCronograma = ItemCronograma
    { itemid :: Text
    , nome :: Text
    , descricao :: Text
    , liberacao :: Text
    , envio :: Text
    , envioatraso :: Text
    , monitores :: Text
    , corretor :: Text
    , correcao :: Text
    , resultado :: Text
    , links :: Text
    }

instance ToJSON ItemCronograma where
    toJSON ItemCronograma {..} = object
        [ "itemid" .= itemid
        , "nome"  .= nome
        , "descricao" .= descricao
        , "liberacao" .= liberacao
        , "envio" .= envio
        , "envioatraso" .= envioatraso
        , "monitores" .= monitores
        , "corretor" .= corretor
        , "correcao" .= correcao
        , "resultado" .= resultado
        , "links" .= links
        ]

getCronogramaR :: Handler Value
getCronogramaR = returnJson $ ItemCronograma "A" "B" "C" "2018-01-31 00:00:00" "2018-01-31 00:00:00" "2018-01-31 00:00:00" "D" "E" "2018-01-31 00:00:00" "2018-01-31 00:00:00" "F"


    