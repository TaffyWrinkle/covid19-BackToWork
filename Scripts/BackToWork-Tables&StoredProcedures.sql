/****** Object:  Table [dbo].[LabTestInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabTestInfo](
	[UserId] [nvarchar](50) NOT NULL,
	[DateOfEntry] [datetime] NOT NULL,
	[TestType] [nvarchar](30) NULL,
	[TestDate] [datetime] NULL,
	[TestResult] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestStatus](
	[UserId] [nvarchar](50) NOT NULL,
	[DateOfEntry] [datetime] NOT NULL,
	[ReturnRequestStatus] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SymptomsInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SymptomsInfo](
	[UserId] [nvarchar](50) NOT NULL,
	[DateOfEntry] [datetime] NOT NULL,
	[UserIsExposed] [bit] NOT NULL,
	[ExposureDate] [datetime] NULL,
	[QuarantineStartDate] [datetime] NULL,
	[QuarantineEndDate] [datetime] NULL,
	[IsSymptomatic] [bit] NOT NULL,
	[SymptomFever] [bit] NULL,
	[SymptomCough] [bit] NULL,
	[SymptomShortnessOfBreath] [bit] NULL,
	[SymptomChills] [bit] NULL,
	[SymptomMusclePain] [bit] NULL,
	[SymptomSoreThroat] [bit] NULL,
	[SymptomLossOfSmellTaste] [bit] NULL,
	[SymptomVomiting] [bit] NULL,
	[SymptomDiarrhea] [bit] NULL,
	[Temperature] [decimal](5, 2) NULL,
	[UserIsSymptomatic] [bit] NULL,
	[ClearToWorkToday] [bit] NOT NULL,
	[GUID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserId] [nvarchar](50) NOT NULL,
	[UserGUID] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](50) NULL,
	[YearOfBirth] [int] NOT NULL,
	[MobileNumber] [nvarchar](15) NULL,
	[EmailAddress] [nvarchar](100) NOT NULL,
	[StreetAddress1] [nvarchar](50) NULL,
	[StreetAddress2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](30) NULL,
	[TeamsAddress] [nvarchar](1500) NULL,
	[TwilioAddress] [nvarchar](1500) NULL,
	[RequestBTWEmail] [nvarchar](100) NULL,
	[RequestBTWMobile] [nvarchar](15) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LabTestInfo] ADD  DEFAULT (getdate()) FOR [DateOfEntry]
GO
ALTER TABLE [dbo].[RequestStatus] ADD  DEFAULT (getdate()) FOR [DateOfEntry]
GO
ALTER TABLE [dbo].[SymptomsInfo] ADD  DEFAULT (getdate()) FOR [DateOfEntry]
GO
/****** Object:  StoredProcedure [dbo].[GetAllTeamsAddress]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTeamsAddress] 
AS
SELECT UserId, TeamsAddress from UserInfo
GO
/****** Object:  StoredProcedure [dbo].[GetAllUsersContactInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllUsersContactInfo] 
AS
Select UserId, FullName, EmailAddress, MobileNumber from UserInfo
GO
/****** Object:  StoredProcedure [dbo].[GetSingleUserContactInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSingleUserContactInfo] @UserId nvarchar(50)
AS
Select TOP(1) UserId, FullName, EmailAddress, MobileNumber from UserInfo where UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[GetLabTestInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLabTestInfo] @UserId nvarchar(50)
AS
SELECT TOP(1) UserId, DateOfEntry, TestType, TestDate, TestResult
FROM LabTestInfo WHERE UserId = @UserId
ORDER BY DateOfEntry DESC
GO
/****** Object:  StoredProcedure [dbo].[GetRequestStatus]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRequestStatus] @UserId nvarchar(50)
AS
SELECT TOP(1) UserId, DateOfEntry, ReturnRequestStatus
FROM RequestStatus WHERE UserId = @UserId
ORDER BY DateOfEntry DESC
GO
/****** Object:  StoredProcedure [dbo].[GetSymptomsInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSymptomsInfo] @UserId nvarchar(50)
AS
SELECT TOP(1) UserId, DateOfEntry, UserIsExposed, ExposureDate, QuarantineStartDate, QuarantineEndDate, IsSymptomatic, SymptomFever, SymptomCough, SymptomShortnessOfBreath, SymptomChills, SymptomMusclePain, SymptomSoreThroat, SymptomLossOfSmellTaste, SymptomVomiting, SymptomDiarrhea, Temperature, UserIsSymptomatic, ClearToWorkToday, GUID
FROM SymptomsInfo WHERE UserId = @UserId ORDER BY DateOfEntry DESC 
GO
/****** Object:  StoredProcedure [dbo].[GetUserInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserInfo] @UserId nvarchar(50)
AS
SELECT UserId, UserGUID, Password, FirstName, LastName, FullName, Role, YearOfBirth, MobileNumber, EmailAddress, StreetAddress1, StreetAddress2, City, State, Country,ZipCode, TeamsAddress, TwilioAddress,RequestBTWEmail, RequestBTWMobile
FROM UserInfo WHERE UserId = @UserId
GO
/****** Object:  StoredProcedure [dbo].[PostLabTestInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PostLabTestInfo] @UserId nvarchar(50), @DateOfEntry datetime, @TestType nvarchar(30)=null, @TestDate datetime=null, @TestResult nvarchar(10)=null
AS
SET NOCOUNT ON
INSERT INTO [dbo].[LabTestInfo]
           ([UserId]
           ,[DateOfEntry]
           ,[TestType]
		   ,[TestDate]
		   ,[TestResult])
       VALUES
           (@UserId
           ,@DateOfEntry
           ,@TestType
		   ,@TestDate
		   ,@TestResult)           
GO
/****** Object:  StoredProcedure [dbo].[PostRequestStatus]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PostRequestStatus] @UserId nvarchar(50), @DateOfEntry datetime, @ReturnRequestStatus nvarchar(10)=null
AS
SET NOCOUNT ON
INSERT INTO [dbo].[RequestStatus]
           ([UserId]
           ,[DateOfEntry]
           ,[ReturnRequestStatus])
       VALUES
           (@UserId
           ,@DateOfEntry
           ,@ReturnRequestStatus)           
GO
/****** Object:  StoredProcedure [dbo].[PostSymptomsInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PostSymptomsInfo] @UserId nvarchar(50), @DateOfEntry datetime, @UserIsExposed bit, @ExposureDate datetime=null, 
@QuarantineStartDate datetime=null, @QuarantineEndDate datetime=null, @IsSymptomatic bit, @SymptomFever bit=null, @SymptomCough bit=null, @SymptomShortnessOfBreath bit=null, 
@SymptomChills bit=null, @SymptomMusclePain bit=null, @SymptomSoreThroat bit=null, @SymptomLossOfSmellTaste bit=null, @SymptomVomiting bit=null, @SymptomDiarrhea bit=null, 
@Temperature decimal(5,2)=null, @UserIsSymptomatic bit=null, @ClearToWorkToday bit, @GUID nvarchar(50)=null
AS
SET NOCOUNT ON
INSERT INTO [dbo].[SymptomsInfo]
           ([UserId]
           ,[DateOfEntry]
           ,[UserIsExposed]
		   ,[ExposureDate]
		   ,[QuarantineStartDate]
		   ,[QuarantineEndDate]
		   ,[IsSymptomatic]
		   ,[SymptomFever]
		   ,[SymptomCough]
		   ,[SymptomShortnessOfBreath]
		   ,[SymptomChills]
		   ,[SymptomMusclePain]
		   ,[SymptomSoreThroat]
		   ,[SymptomLossOfSmellTaste]
		   ,[SymptomVomiting]
		   ,[SymptomDiarrhea]
		   ,[Temperature]
		   ,[UserIsSymptomatic]
		   ,[ClearToWorkToday]
		   ,[GUID])
       VALUES
           (@UserId
           ,@DateOfEntry
           ,@UserIsExposed
		   ,@ExposureDate
		   ,@QuarantineStartDate
		   ,@QuarantineEndDate
		   ,@IsSymptomatic
		   ,@SymptomFever
		   ,@SymptomCough
		   ,@SymptomShortnessOfBreath
		   ,@SymptomChills
		   ,@SymptomMusclePain
		   ,@SymptomSoreThroat
		   ,@SymptomLossOfSmellTaste
		   ,@SymptomVomiting
		   ,@SymptomDiarrhea
		   ,@Temperature
		   ,@UserIsSymptomatic
		   ,@ClearToWorkToday
		   ,@GUID)           
GO
/****** Object:  StoredProcedure [dbo].[PostUserInfo]    Script Date: 6/10/2020 1:59:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PostUserInfo] @UserId nvarchar(50), @FullName nvarchar(100), @YearOfBirth int, @EmailAddress nvarchar(100)
AS
SET NOCOUNT ON
INSERT INTO [dbo].[UserInfo]
           ([UserId]
		   ,[FullName]
		   ,[YearOfBirth]
		   ,[EmailAddress])
       VALUES
           (@UserId
		   ,@FullName
		   ,@YearOfBirth
		   ,@EmailAddress)           
GO
/****** Object:  View [dbo].[v_SymptomsInfo]    Script Date: 6/10/2020 3:02:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_SymptomsInfo]
AS
SELECT        UserId, convert(varchar, DateOfEntry, 101) as DateOfEntry, convert(varchar, DateOfEntry, 8) as TimeOfEntry, UserIsExposed, convert(varchar, ExposureDate, 101) as ExposureDate, convert(varchar, ExposureDate, 8) as ExposureTime, convert(varchar, QuarantineStartDate, 101) as QuarantineStartDate, convert(varchar, QuarantineStartDate, 8) as QuarantineStartTime, convert(varchar, QuarantineEndDate, 101) as QuarantineEndDate, convert(varchar, QuarantineEndDate, 8) as QuarantineEndTime, IsSymptomatic, SymptomFever, SymptomCough, SymptomShortnessOfBreath, SymptomChills, SymptomMusclePain, 
                         SymptomSoreThroat, SymptomLossOfSmellTaste, SymptomVomiting, SymptomDiarrhea, Temperature, UserIsSymptomatic, ClearToWorkToday, GUID
FROM            dbo.SymptomsInfo
GO
/****** Object:  View [dbo].[v_RequestStatus]    Script Date: 6/10/2020 3:02:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_RequestStatus]
AS
SELECT        UserId, convert(varchar, DateOfEntry, 101) as DateOfEntry, convert(varchar, DateOfEntry, 8) as TimeOfEntry, ReturnRequestStatus
FROM            dbo.RequestStatus
GO
/****** Object:  View [dbo].[v_LabTestInfo]    Script Date: 6/10/2020 3:02:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_LabTestInfo]
AS
SELECT        UserId, convert(varchar, DateOfEntry, 101) as DateOfEntry, convert(varchar, DateOfEntry, 8) as TimeOfEntry, TestType, convert(varchar, TestDate, 101) as TestDate, convert(varchar, TestDate, 8) as TestTime, TestResult
FROM            dbo.LabTestInfo
GO
