USE [sample]
GO

/****** Object:  Table [dbo].[person]    Script Date: 3/21/2023 10:15:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[person_noIndex](
	[id] [int] NOT NULL,
	[lastname] [varchar](50) NULL,
	[firstname] [varchar](50) NULL,
	[age] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[person_noIndex]  WITH CHECK ADD CHECK  (([age]>=(18)))
GO


