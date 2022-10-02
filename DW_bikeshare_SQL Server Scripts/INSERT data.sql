use bikeshare
go

BULK INSERT payment
FROM 'D:\Udacity\Azure\DW for Bikeshare Analytics\Out\payments.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR='\n',
    BATCHSIZE=250000,
    MAXERRORS=2);


BULK INSERT rider
FROM 'D:\Udacity\Azure\DW for Bikeshare Analytics\Out\riders.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR='\n',
    BATCHSIZE=250000,
    MAXERRORS=2);

BULK INSERT station
FROM 'D:\Udacity\Azure\DW for Bikeshare Analytics\Out\stations.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR='\n',
    BATCHSIZE=250000,
    MAXERRORS=2);

BULK INSERT trip
FROM 'D:\Udacity\Azure\DW for Bikeshare Analytics\Out\trips.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR='\n',
    BATCHSIZE=250000,
    MAXERRORS=2);
