
-------------------------------------------------------------------------------------------------

-- Change Date Format

ALTER TABLE Housing
Add SaleDateConverted Date;

Update Housing
SET SaleDateConverted = CONVERT(Date, SaleDate)

select *
from Housing

-------------------------------------------------------------------------------------------------


-- Checking for NULL values in the property address column.
	Select Count(1)-Count(PropertyAddress) from Housing

-- Populating the NULL entries in the Property Address column based on Parcel_ID.

UPDATE
    Table_A
SET
    Table_A.PropertyAddress = Table_B.PropertyAddress
   
FROM
    Housing AS Table_A
    INNER JOIN Housing AS Table_B
        ON Table_A.ParcelID = Table_B.ParcelID and Table_A.[UniqueID ]<>Table_B.[UniqueID ]
WHERE
    Table_A.PropertyAddress is null

-------------------------------------------------------------------------------------------------

-- The attribte "PropertyAddress" is in a (Address, City) format
-- Let's split the attribute into two columns "Address" and "City"
Select PropertyAddress from Housing


SELECT
SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress)) as City
FROM Housing

ALTER TABLE Housing
Add Address nvarchar(200)

ALTER TABLE Housing
Add City nvarchar(200)

Update Housing
Set Address = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) 

Update Housing
Set City = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress))

-------------------------------------------------------------------------------------------------


/* The "Ownwer Address" column is in a form (Address, city, state)
   Let's split the data into 3 separate colummns and denote them as
   OwnerSplitAddress, OwnerSplitCity and OwnerSplitState
*/



select PARSENAME(REPLACE(OwnerAddress, ',','.'),3), 
 PARSENAME(REPLACE(OwnerAddress, ',','.'),2) ,
PARSENAME(REPLACE(OwnerAddress, ',','.'),1) 
from Housing

ALTER TABLE Housing
ADD OwnerSplitCity nvarchar(200)

ALTER TABLE Housing
ADD OwnerSplitAddress nvarchar(200)

ALTER TABLE Housing
ADD OwnerSplitState nvarchar(200)


UPDATE Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'),3)

UPDATE Housing
SET OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress, ',','.'),2) 

UPDATE Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'),1) 

select * from Housing

-------------------------------------------------------------------------------------------------


/* The distinct values of "SoldAsVacant" attribute are : Yes, No, Y, N.
   Let's change Y and N to "Yes" and "No" for consistency.
*/


Update Housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
			When SoldAsVacant = 'N' Then 'No'
			ELSE SoldAsVacant
			END

-------------------------------------------------------------------------------------------------

-- Delete Unused Columns

select * from Housing

Alter table housing
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate, OwnerSplitCity

