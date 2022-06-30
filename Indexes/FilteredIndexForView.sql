-- Filteres index a kreált view-hoz

CREATE NONCLUSTERED INDEX [IXF_ForCarsUnder10mView] ON [dbo].[Car] (ListPrice, MotorType)
		WHERE ListPrice < 10000000 AND MotorType = 'hybrid'
GO