{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Reader.GogolReader where

import Network.Google.Sheets
import Network.Google

import Control.Lens ((.~), (<&>), (^.))
import Data.Text (Text, pack)
import System.IO (stdout)
import Data.Aeson.Types

getSheetRange :: Text -> Text -> IO ValueRange 
getSheetRange sheetID range =  do
    lgr <- newLogger Debug stdout
    env <- newEnv <&> (envLogger .~ lgr) . (envScopes .~ spreadsheetsScope)
    runResourceT . runGoogle env $ send  (spreadsheetsValuesGet sheetID range)

coletarDados :: String -> String -> IO [[Value]]
coletarDados sheetID range = do
    gValueRange <- getSheetRange (pack(sheetID)) (pack(range))
    return (gValueRange^.vrValues)

extractTexts :: [Value] -> [Text]
extractTexts [] = []
extractTexts ((String text):xs) = [text] ++ extractTexts xs
extractTexts (_:xs) = [""] ++ extractTexts xs