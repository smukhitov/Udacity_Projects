DECLARE @StartDate DATE
DECLARE @EndDate DATE
SET @StartDate = '20130101'
SET @EndDate = '20210301'

WHILE @StartDate <= @EndDate
    BEGIN
        INSERT INTO [dimDate]
        SELECT
            
            @StartDate,
            DATEPART(WEEKDAY, @StartDate),
            DATEPART(DAY, @StartDate),
            DATEPART(WEEK, @StartDate),
            DATEPART(QUARTER, @StartDate),
            DATEPART(MONTH, @StartDate),
            DATEPART(YEAR, @StartDate)

        SET @StartDate = DATEADD(day, 1, @StartDate)
    END
