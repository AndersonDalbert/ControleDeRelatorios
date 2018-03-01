{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Handler.Notas where

import Import
import Text.Printf
import Codec.Xlsx
import qualified Data.ByteString.Lazy as L
import Data.Dates
import Data.Text (Text)
import Data.FileEmbed (embedFile)

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

{-getRows :: Maybe CellMap -> [(Int, [(Int, Cell)])]
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

makeItem :: [Text] -> [Nota]
makeItem [] = []
makeItem [idNota, aluno, roteiro01, roteiro02, roteiro03, roteiro04, roteiro05, roteiro06, media_roteiros, prova_parcial, projeto, prova_final, media_final] =
     [Nota idNota aluno roteiro01 roteiro02 roteiro03 roteiro04 roteiro05 roteiro06 media_roteiros prova_parcial projeto prova_final media_final]
makeItem _ = []

makeItems :: [(Int, [(Int, Cell)])] -> [Nota]
makeItems [] = []
makeItems ((_, row):xs) = (makeItem (collectTexts row)) Prelude.++ (makeItems xs)

preMakeItems :: [(Int, [(Int, Cell)])] -> [Nota]
--preMakeItems [] = []
preMakeItems [] = [Nota ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text), Nota ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text)]
preMakeItems rows = [Nota ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text), Nota ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text) ("a" :: Text)]
--preMakeItems rows = makeItems (Prelude.tail (Prelude.tail rows))

extractRowsFromXlsx :: Xlsx -> [(Int, [(Int, Cell)])]
extractRowsFromXlsx (Xlsx [] _ _ _ _) = []
extractRowsFromXlsx (Xlsx ((_, (Worksheet _ _ cells _ _ _ _ _ _ _ _ _ _ _)):_) _ _ _ _) = toRows cells
-}
optionsNotasR :: Handler RepPlain
optionsNotasR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    return $ RepPlain $ toContent ("" :: Text)

getNotasR :: Handler TypedContent
getNotasR = do return $ TypedContent "application/json"
																$ toContent $(embedFile "data/notas.json")
--getNotasR = do
    --addHeader "Access-Control-Allow-Origin" "*"
    --bs <- liftIO $ L.readFile "./data/notas.xlsx"
    --let xlsx = toXlsx bs
    --returnJson $ preMakeItems (extractRowsFromXlsx xlsx)
