USE [MyFleet]

BULK INSERT dbo.Car
FROM 'C:\Vizsgaremek_Project\Adatok\Car.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.ContractType
FROM 'C:\Vizsgaremek_Project\Adatok\ContractType.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DeliveryEvent
FROM 'C:\Vizsgaremek_Project\Adatok\DeliveryEvent.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DeliveryType
FROM 'C:\Vizsgaremek_Project\Adatok\DeliveryType.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DictDiscount
FROM 'C:\Vizsgaremek_Project\Adatok\DictDiscount.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DictEventType
FROM 'C:\Vizsgaremek_Project\Adatok\DictEventType.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DictFirstName
FROM 'C:\Vizsgaremek_Project\Adatok\DictFirstName.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DictPaymentMethod
FROM 'C:\Vizsgaremek_Project\Adatok\DictPaymentMethod.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DictServType
FROM 'C:\Vizsgaremek_Project\Adatok\DictServType.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.DictVAT
FROM 'C:\Vizsgaremek_Project\Adatok\DictVAT.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.Invoice
FROM 'C:\Vizsgaremek_Project\Adatok\Invoice.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.[Partner]
FROM 'C:\Vizsgaremek_Project\Adatok\Partner.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.PartnerOrder
FROM 'C:\Vizsgaremek_Project\Adatok\PartnerOrder.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.ServiceEvent
FROM 'C:\Vizsgaremek_Project\Adatok\ServiceEvent.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)

BULK INSERT dbo.Servpoint
FROM 'C:\Vizsgaremek_Project\Adatok\Servpoint.csv'
WITH 
(
CODEPAGE = 65001,
FIRSTROW = 2,
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)