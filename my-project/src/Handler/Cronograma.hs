{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Cronograma where

import Import
import Text.Printf
import Codec.Xlsx
import qualified Data.ByteString.Lazy as L
import Data.Dates

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

getRows :: Maybe CellMap -> [(Int, [(Int, Cell)])]
getRows Nothing = []
getRows (Just a) = toRows a

dateToText :: DateTime -> Text
dateToText (DateTime y m d h mm s) = pack (printf "%d-%02d-%02d %02d:%02d:%02d" y m d h mm s)

getStringDateFromOA :: Double -> Text
getStringDateFromOA oaDate = dateToText (addTime (addInterval oaZero (Days (truncate oaDays))) (Time (truncate oaHours) (truncate oaMinutes) (truncate oaSeconds)))
    where
        oaZero = (DateTime 1899 12 30 0 0 0)
        oaDays = fromIntegral (floor oaDate)
        oaHours = ((oaDate - oaDays) * 24)
        oaMinutes = ((oaHours - fromIntegral (floor oaHours)) * 60)
        oaSeconds = ((oaMinutes - fromIntegral (floor oaMinutes)) * 60)
        
getValue :: Maybe CellValue -> Text
getValue Nothing = ""
getValue (Just (CellText text)) = text
getValue (Just (CellDouble oaDate)) = getStringDateFromOA oaDate
getValue (Just (CellRich (RichTextRun _ text:_))) = text
getValue _ = ""

collectTexts :: [(Int, Cell)] -> [Text]
collectTexts [] = []
collectTexts ((_, (Cell _ Nothing _ _)):xs) = collectTexts xs
collectTexts ((_, (Cell _ val _ _)):xs) = [getValue val] Prelude.++ collectTexts xs

makeItem :: [Text] -> [ItemCronograma]
makeItem [] = []
makeItem [itemid, nome, descricao, liberacao, envio, envioatraso, monitores, corretor, correcao, resultado, links] =
     [ItemCronograma itemid nome descricao liberacao envio envioatraso monitores corretor correcao resultado links]
makeItem _ = []

makeItems :: [(Int, [(Int, Cell)])] -> [ItemCronograma]
makeItems [] = []
makeItems ((_, row):xs) = (makeItem (collectTexts row)) Prelude.++ (makeItems xs)

preMakeItems :: [(Int, [(Int, Cell)])] -> [ItemCronograma]
preMakeItems [] = []
preMakeItems rows = makeItems (Prelude.tail (Prelude.tail rows))

extractRowsFromXlsx :: Xlsx -> [(Int, [(Int, Cell)])]
extractRowsFromXlsx (Xlsx [] _ _ _ _) = []
extractRowsFromXlsx (Xlsx ((_, (Worksheet _ _ cells _ _ _ _ _ _ _ _ _ _ _)):_) _ _ _ _) = toRows cells

getCronogramaR :: Handler Value
getCronogramaR = do
    bs <- liftIO $ L.readFile "./data/cronograma.xlsx"
    let xlsx = toXlsx bs
    returnJson $ preMakeItems (extractRowsFromXlsx xlsx)
        