CREATE DATABASE Fintech
GO

USE Fintech
GO

CREATE TABLE [dbo].[Customer]
(
	[IDCustomer] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[CustomerName] VARCHAR(150) NOT NULL,
	[Document] VARCHAR(30) NOT NULL UNIQUE,
	[BornDate] DATE NULL,
	[Gender] CHAR(1) NOT NULL DEFAULT 'M',
	[RegisterDate] DATETIME NOT NULL,
	[Active] BIT NOT NULL
)
GO

CREATE TABLE [dbo].[Address]
(
	[IDAddress] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[IDCustomer] INT NOT NULL,
	[AddressType] VARCHAR(50) NULL,
	[CEP] VARCHAR(8) NOT NULL,
	[Street] VARCHAR(300) NOT NULL,
	[Neighborhood] VARCHAR(80) NULL,
	[City] VARCHAR(80) NULL,
	[State] VARCHAR(80) NULL,
	[RegisterDate] DATETIME NOT NULL,
	[Active] BIT NOT NULL
)
GO

ALTER TABLE [dbo].[Address]
ADD CONSTRAINT [FK_Address_Customer] FOREIGN KEY ([IDCustomer])
REFERENCES [dbo].[Customer] ([IDCustomer])

CREATE TABLE [dbo].[Investment]
(
	[IDInvestment] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[InvestmentName] VARCHAR(80) NOT NULL UNIQUE,
	[InvestmentDescription] VARCHAR(300) NULL,
	[Tax] DECIMAL(18, 4) NULL,
	[RegisterDate] DATETIME NOT NULL,
	[Active] BIT NOT NULL
)
GO

CREATE TABLE [dbo].[Account]
(
	[IDAccount] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[IDCustomer] INT NOT NULL UNIQUE,
	[AccountNumber] INT NOT NULL UNIQUE,
	[Amount] DECIMAL(18, 4) NULL,
	[RegisterDate] DATETIME NOT NULL,
	[Active] BIT NOT NULL
)
GO

ALTER TABLE [dbo].[Account]
ADD CONSTRAINT [FK_Account_Customer] FOREIGN KEY ([IDCustomer])
REFERENCES [dbo].[Customer] ([IDCustomer])

CREATE TABLE [dbo].[InvestmentAcquisition]
(
	[IDInvestmentAcquisition] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[IDInvestment] INT NOT NULL,
	[IDAccount] INT NOT NULL,
	[InvestmentAmount] DECIMAL(18, 4) NOT NULL,
	[ValidateDate] DATETIME NOT NULL,
	[RegisterDate] DATETIME NOT NULL,
	[Active] BIT NOT NULL
)
GO

ALTER TABLE [dbo].[InvestmentAcquisition]
ADD CONSTRAINT [FK_InvestmentAcquisition_Investment] FOREIGN KEY ([IDInvestment])
REFERENCES [dbo].[Investment] ([IDInvestment])

ALTER TABLE [dbo].[InvestmentAcquisition]
ADD CONSTRAINT [FK_InvestmentAcquisition_Account] FOREIGN KEY ([IDAccount])
REFERENCES [dbo].[Account] ([IDAccount])

CREATE TABLE [dbo].[AccountTransaction]
(
	[IDAccountTransaction] INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[IDAccount] INT NOT NULL,
	[TransactionValue] DECIMAL(18, 4) NOT NULL,
	[TransactionType] VARCHAR(100) NOT NULL,
	[RegisterDate] DATETIME NOT NULL,
	[Active] BIT NOT NULL
)
GO

ALTER TABLE [dbo].[AccountTransaction]
ADD CONSTRAINT [FK_AccountTransaction_Account] FOREIGN KEY ([IDAccount])
REFERENCES [dbo].[Account] ([IDAccount])