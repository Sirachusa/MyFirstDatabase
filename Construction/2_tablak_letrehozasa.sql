USE [MyFleet]

CREATE TABLE [Car] (
  [CarID] int NOT NULL IDENTITY(1, 1),
  [Manufacturer] varchar(50),
  [Type] varchar(50) NOT NULL,
  [Model] varchar(100),
  [Motor] varchar(100) NOT NULL,
  [KW] smallint,
  [HP] smallint,
  [ProductYear] smallint,
  [DoorNo] smallint,
  [SeatNo] smallint,
  [FuelType] varchar(50),
  [MotorType] varchar(20),
  [AVGConsumption] decimal(3,1),
  [ListPrice] int NOT NULL,
  [ModifiedDate] datetime
	CONSTRAINT PK_Car_CarID PRIMARY KEY (CarID))
GO

CREATE TABLE [DictVAT] (
  [VatID] int NOT NULL IDENTITY(1, 1),
  [VATName] varchar(25) NOT NULL,
  [VATPercent] decimal(3,3) NOT NULL,
  [FromDate] date,
  [ToDate] date
CONSTRAINT PK_DictVAT_VatID PRIMARY KEY (VatID))
GO

CREATE TABLE [DeliveryType] (
  [DeliveryTypeID] int NOT NULL IDENTITY(1, 1),
  [DeliveryName] varchar(50) NOT NULL,
  [DeliveryNameEng] varchar(50),
  [DeliveryCode] char(2),
  [Price] int NOT NULL
CONSTRAINT PK_DeliveryType_DeliveryTypeID PRIMARY KEY (DeliveryTypeID))
GO

CREATE TABLE [DeliveryEvent] (
  [DeliveryEventID] int NOT NULL IDENTITY(1, 1),
  [DeliveryTypeID] int,
  [PartnerOrderID] int,
  [EventTypeID] int,
  [DeliveryEventName] varchar(50),
  [DeliveryEventDate] datetime
CONSTRAINT PK_DeliveryEvent_DeliveryEventID PRIMARY KEY (DeliveryEventID))
GO

CREATE TABLE [DictEventType] (
  [EventTypeID] int NOT NULL IDENTITY(1, 1),
  [DeliveryTypeName] varchar(50),
  [DeliveryTypeNameEng] varchar(50),
  [EventTypeCode] char(1),
CONSTRAINT PK_DictEventType_EventTypeID PRIMARY KEY (EventTypeID))
GO

CREATE TABLE [ContractType] (
  [ContractTypeID] int NOT NULL IDENTITY(1, 1),
  [ContractTypeName] varchar(50),
  [ContractTypeNameEng] varchar(50),
  [Months] tinyint,
  [Multiplier] decimal(3,2)
CONSTRAINT PK_ContractType_ContractTypeID PRIMARY KEY (ContractTypeID))
GO

CREATE TABLE [DictDiscount] (
  [DiscountID] int NOT NULL IDENTITY(1, 1),
  [DiscountName] varchar(50),
  [DiscountNameEng] varchar(50),
  [DiscountPercent] decimal(3,2)  
CONSTRAINT PK_DictDiscount_DiscountID PRIMARY KEY (DiscountID))
GO

CREATE TABLE [DictPaymentMethod] (
  [PaymentMethodID] int NOT NULL IDENTITY(1, 1),
  [PaymentMethodName] varchar(50),
  [PaymentMethodEng] varchar(50)
CONSTRAINT PK_DictPaymentMethod_PaymentMethodID PRIMARY KEY (PaymentMethodID))
GO

CREATE TABLE [PartnerOrder] (
  [PartnerOrderID] int NOT NULL IDENTITY(1, 1),
  [carID] int,
  [PaymentMethodID] int,
  [DeliveryTypeID] int,
  [ContractTypeID] int,
  [PartnerID] int,
  [InvoiceID] int,
  [OrderDate] datetime,
CONSTRAINT PK_PartnerOrder_PartnerOrderID PRIMARY KEY (PartnerOrderID))
GO

CREATE TABLE [Invoice] (
  [InvoiceID] int NOT NULL IDENTITY(1, 1),
  [PartnerOrderID] int,
  [PaymentMethodID] int,
  [PartnerID] int,
  [VatID] int,
  [DiscountID] int,
  [OrderDate] date,
  [DueDate] date,
  [ShipDate] date,
  [CarID] int,
  [TotalPrice] int
CONSTRAINT PK_Invoice_InvoiceID PRIMARY KEY (InvoiceID))
GO

CREATE TABLE [ServiceEvent] (
  [ServiceEventID] int NOT NULL IDENTITY(1, 1),
  [ServiceEventName] varchar(50),
  [ServPointID] int,
  [ServTypeID] int,
  [CarID] int,
  [ServiceEventDate] datetime
CONSTRAINT PK_ServiceEvent_ServiceEventID PRIMARY KEY (ServiceEventID))
GO

CREATE TABLE [Partner] (
  [PartnerID] int NOT NULL IDENTITY (1,1),
  [PartnerFullName] varchar(50),
  [LastName] varchar(50) NOT NULL,
  [FirstName] varchar(50) NOT NULL,
  [BirthDate] date NOT NULL,
  [Gender] tinyint,
  [PostalCode] varchar(50),
  [City] varchar(50),
  [Address] varchar(50),
  [isCustomer] bit,
  [isSupplier] bit,
  [isShipper] bit,
  [Phone] varchar(50),
  [Email] varchar(100)
CONSTRAINT PK_Partner_PartnerID PRIMARY KEY (PartnerID))
GO

CREATE TABLE [ServPoint] (
  [ServPointID] int NOT NULL IDENTITY(1, 1),
  [ServPointName] varchar(50),
  [ServPointPostalCode] varchar(50),
  [ServPointCity] varchar(50),
  [ServPointAddress] varchar(50),
  [ServPointPhone] varchar(50),
  [ServTypeID] int,
  [OpenTime] tinyint,
  [CloseTime] tinyint
CONSTRAINT PK_ServPoint_ServPointID PRIMARY KEY (ServPointID))
GO

CREATE TABLE [DictServType] (
  [ServTypeID] int NOT NULL IDENTITY(1, 1),
  [ServTypeName] varchar(50),
  [ServTypeNameEng] varchar(50),
  [ServRate] tinyint
CONSTRAINT PK_DictServType_ServTypeID PRIMARY KEY (ServTypeID))
GO

CREATE TABLE [DictFirstName] (
	[FirstName] varchar(30) NOT NULL,
	[Gender] tinyint NOT NULL,
 CONSTRAINT PK_DictFirstName_FirstName PRIMARY KEY CLUSTERED (FirstName))
 GO

CREATE TABLE [CarPriceChangeLog] (
	[CarPriceChangeLogID] int NOT NULL IDENTITY,
	[CarID] int,
	[DMLAction] varchar(20),
	[OldPrice] varchar (30), 
	[NewPrice] varchar (30),
	[InsertUser] varchar(100) DEFAULT SUSER_SNAME(),
	[InsertDate] datetime2 DEFAULT SYSDATETIME()
 CONSTRAINT PK_CarPriceChangeLog_CarPriceChangeLogID PRIMARY KEY CLUSTERED (CarPriceChangeLogID)
)
GO

ALTER TABLE [CarPriceChangeLog] ADD FOREIGN KEY ([CarID]) REFERENCES [Car] ([CarID])
GO

ALTER TABLE [Invoice] ADD FOREIGN KEY ([DiscountID]) REFERENCES [DictDiscount] ([DiscountID])
GO

ALTER TABLE [Invoice] ADD FOREIGN KEY ([PaymentMethodID]) REFERENCES [DictPaymentMethod] ([PaymentMethodID])
GO

ALTER TABLE [Invoice] ADD FOREIGN KEY ([PartnerOrderID]) REFERENCES [PartnerOrder] ([PartnerOrderID])
GO

ALTER TABLE [PartnerOrder] ADD FOREIGN KEY ([PaymentMethodID]) REFERENCES [DictPaymentMethod] ([PaymentMethodID])
GO

ALTER TABLE [PartnerOrder] ADD FOREIGN KEY ([DeliveryTypeID]) REFERENCES [DeliveryType] ([DeliveryTypeID])
GO

ALTER TABLE [Invoice] ADD FOREIGN KEY ([VatID]) REFERENCES [DictVAT] ([VatID])
GO

ALTER TABLE [Invoice] ADD FOREIGN KEY ([PartnerID]) REFERENCES [Partner] ([PartnerID])
GO

ALTER TABLE [PartnerOrder] ADD FOREIGN KEY ([PartnerID]) REFERENCES [Partner] ([PartnerID])
GO

ALTER TABLE [PartnerOrder] ADD FOREIGN KEY ([ContractTypeID]) REFERENCES [ContractType] ([ContractTypeID])
GO

ALTER TABLE [Invoice] ADD FOREIGN KEY ([CarID]) REFERENCES [Car] ([CarID])
GO

ALTER TABLE [PartnerOrder] ADD FOREIGN KEY ([carID]) REFERENCES [Car] ([CarID])
GO

ALTER TABLE [ServiceEvent] ADD FOREIGN KEY ([CarID]) REFERENCES [Car] ([carID])
GO

ALTER TABLE [ServiceEvent] ADD FOREIGN KEY ([ServPointID]) REFERENCES [ServPoint] ([ServPointID])
GO

ALTER TABLE [DeliveryEvent] ADD FOREIGN KEY ([EventTypeID]) REFERENCES [DictEventType] ([EventTypeID])
GO

ALTER TABLE [DeliveryEvent] ADD FOREIGN KEY ([PartnerOrderID]) REFERENCES [PartnerOrder] ([PartnerOrderID])
GO

ALTER TABLE [ServiceEvent] ADD FOREIGN KEY ([ServTypeID]) REFERENCES [DictServType] ([ServTypeID])
GO