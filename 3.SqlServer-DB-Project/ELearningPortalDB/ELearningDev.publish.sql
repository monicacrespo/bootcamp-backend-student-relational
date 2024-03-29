﻿/*
Deployment script for ELearningDev

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ELearningDev"
:setvar DefaultFilePrefix "ELearningDev"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Dropping Foreign Key [dbo].[FK_categories_categories]...';


GO
ALTER TABLE [dbo].[categories] DROP CONSTRAINT [FK_categories_categories];


GO
PRINT N'Altering Table [dbo].[categories]...';


GO
ALTER TABLE [dbo].[categories] ALTER COLUMN [categories_id] INT NULL;


GO
PRINT N'Creating Foreign Key [dbo].[FK_categories_categories]...';


GO
ALTER TABLE [dbo].[categories] WITH NOCHECK
    ADD CONSTRAINT [FK_categories_categories] FOREIGN KEY ([categories_id]) REFERENCES [dbo].[categories] ([id]);


GO
PRINT N'Refreshing View [dbo].[vLecturesCoursesCategory]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[vLecturesCoursesCategory]';


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[categories] WITH CHECK CHECK CONSTRAINT [FK_categories_categories];


GO
PRINT N'Update complete.';


GO
