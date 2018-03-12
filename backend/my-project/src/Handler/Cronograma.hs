{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Cronograma where

import Import
import Data.Text (Text)

import Reader.GogolReader

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

makeItem :: [Text] -> [ItemCronograma]
makeItem [] = []
makeItem [itemid, nome, descricao, liberacao, envio, envioatraso, monitores, corretor, correcao, resultado, links] =
    [ItemCronograma itemid nome descricao liberacao envio envioatraso monitores corretor correcao resultado links]
makeItem _ = []

makeItems :: [[Value]] -> [ItemCronograma]
makeItems [] = []
makeItems (x:xs) = (makeItem (extractTexts x)) Prelude.++ makeItems xs

optionsCronogramaR :: Handler RepPlain
optionsCronogramaR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    return $ RepPlain $ toContent ("" :: Text)

getCronogramaR :: Handler Value
getCronogramaR = do
    addHeader "Access-Control-Allow-Origin" "*"
    sheet <- liftIO $ (coletarDados "" "Sheet1!A:K")
    returnJson $ makeItems sheet
