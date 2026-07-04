bulk insert sample_superstore
from 'C:\Users\SSS\OneDrive\Desktop\samplesuperstoreSQL\sample_superstore.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    rowterminator = '\n',
    tablock
);