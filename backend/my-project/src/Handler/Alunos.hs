{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Alunos where

import Import

import Reader.GogolReader

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

makeItem :: [Text] -> [Aluno]
makeItem [] = []
makeItem [aindex, matricula, nome] = [Aluno aindex matricula nome]
makeItem _ = []

makeItems :: [[Value]] -> [Aluno]
makeItems [] = []
makeItems (x:xs) = (makeItem (extractTexts x)) Prelude.++ makeItems xs

optionsAlunosR :: Handler RepPlain
optionsAlunosR = do
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "GET, OPTIONS"
    return $ RepPlain $ toContent ("" :: Text)

getAlunosR :: Handler Value
getAlunosR = do
    addHeader "Access-Control-Allow-Origin" "*"
    sheet <- liftIO $ (coletarDados "1N755Sj0TN9DtAme3T4-EoPCHBcnehivfrd0xU6J97yQ" "Sheet1!A:C")
    returnJson $ makeItems sheet
