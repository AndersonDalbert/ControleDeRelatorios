{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
module Handler.Alunos where

import Import
import Data.Text (Text)

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

getAlunosR :: Handler Value
getAlunosR = returnJson $ Aluno "1" "115210091" "Anderson Dalbert Carvalho Vital"
