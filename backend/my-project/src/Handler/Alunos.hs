{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Alunos where

import Import
import Codec.Xlsx
import qualified Data.ByteString.Lazy as L

data Aluno = Aluno
    { aindex :: Text
    , matricula :: Text
    , nome :: Text
}

instance ToJSON Aluno where
    toJSON Aluno {..} = object
        [ "aindex" .= aindex
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

collectTexts :: [(Int, Cell)] -> Int -> [Text]
collectTexts [] _ = []
collectTexts ((_, (Cell _ Nothing _ _)):_) 3 = []
collectTexts ((_, (Cell _ Nothing _ _)):xs) x = collectTexts xs (x + 1)
collectTexts ((_, (Cell _ val _ _)):_) 3 = [getValue val]
collectTexts ((_, (Cell _ val _ _)):xs) x = [getValue val] Prelude.++ collectTexts xs (x + 1)

makeItem :: [Text] -> [Aluno]
makeItem [] = []
makeItem [aindex, matricula, nome] = [Aluno aindex matricula nome]
makeItem _ = []

makeItems :: [(Int, [(Int, Cell)])] -> [Aluno]
makeItems [] = []
makeItems ((_, row):xs) = (makeItem (collectTexts row 1)) Prelude.++ (makeItems xs)

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
