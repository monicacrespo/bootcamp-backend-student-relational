﻿CREATE TABLE [dbo].[users]
(
	[id] [int] NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[name] [varchar](50) NOT NULL UNIQUE
)
