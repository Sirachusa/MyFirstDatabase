-- Filteres index a kre�lt view-hoz

CREATE NONCLUSTERED INDEX [IXF_ForCarsUnder10mView] ON [dbo].[Car] (ListPrice, MotorType)
		WHERE ListPrice < 10000000 AND MotorType = 'hybrid'
GO