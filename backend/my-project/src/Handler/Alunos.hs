{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Alunos where

import Import
import Text.Printf
import Codec.Xlsx
import qualified Data.ByteString.Lazy as L
import Data.Dates

data Aluno = Aluno
	{ index :: Text
	, matricula :: Text
	, nome :: Text
}

instance ToJSON Aluno where
	toJSON Aluno {..} = object
		[ "index" .= index
		, "matricula" .= matricula
		, "nome" .= nome
		]

getRows :: Maybe CellMap -> [(Int, [(Int, Cell)])]
getRows Nothing = []
getRows (Just a) = toRows a

getValue :: Maybe CellValue -> Text
getValue Nothing = ""
getValue (Just (CellText text)) = text
getValue (Just (CellRich (RichTextRun _ text:_))) = text
getValue _ = ""

collectTexts :: [(Int, Cell)] -> [Text]
collectTexts [] = []
collectTexts ((_, (Cell _ Nothing _ _)):xs) = collectTexts xs
collectTexts ((_, (Cell _ val _ _)):xs) = [getValue val] Prelude.++ collectTexts xs

makeItem :: [Text] -> [Aluno]
makeItem [] = []
makeItem [index, matricula, nome] =
     [Aluno index matricula nome]
makeItem _ = []

makeItems :: [(Int, [(Int, Cell)])] -> [Aluno]
makeItems [] = []
makeItems ((_, row):xs) = (makeItem (collectTexts row)) Prelude.++ (makeItems xs)

preMakeItems :: [(Int, [(Int, Cell)])] -> [Aluno]
preMakeItems [] = []
preMakeItems rows = makeItems (Prelude.tail (Prelude.tail rows))

extractRowsFromXlsx :: Xlsx -> [(Int, [(Int, Cell)])]
extractRowsFromXlsx (Xlsx [] _ _ _ _) = []
extractRowsFromXlsx (Xlsx ((_, (Worksheet _ _ cells _ _ _ _ _ _ _ _ _ _ _)):_) _ _ _ _) = toRows cells

optionsAlunosR :: Handler RepPlain
optionsAlunosR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    return $ RepPlain $ toContent ("" :: Text)


getAlunosR :: Handler Value
getAlunosR = do
	addHeader "Access-Control-Allow-Origin" "*"
	bs <- liftIO $ L.readFile "./data/alunos.xlsx"
	let xlsx = toXlsx bs
	returnJson $ preMakeItems (extractRowsFromXlsx xlsx)
