--clean data
select * from nashvillehousing

--standard date format
select saleDateconverted,CONVERT(date,saledate) from nashvillehousing


update nashvillehousing set saledate = CONVERT(date,saledate)

alter table nashvillehousing
add saleDateConverted date

update nashvillehousing
set saleDateConverted = CONVERT(date,saledate)

--poplate property address data

select * from nashvillehousing
order by parcelID
select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) from Nashvillehousing a
join Nashvillehousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a 
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from Nashvillehousing a join Nashvillehousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null	

--breaking out address into individual column (address, city, state)
select PropertyAddress from Nashvillehousing
order by parcelID

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress)) as address
from Nashvillehousing


alter table nashvillehousing
add PropertySplitAddress nvarchar(255);

update Nashvillehousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) 


alter table nashvillehousing
add PropertySplitCity nvarchar(255);

update Nashvillehousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress))

select * from Nashvillehousing

select OwnerAddress from Nashvillehousing

select 
PARSENAME(replace(OwnerAddress,',','.'),3),
PARSENAME(replace(OwnerAddress,',','.'),2),
PARSENAME(replace(OwnerAddress,',','.'),1)
from Nashvillehousing


alter table nashvillehousing
add OwnerSplitAddress nvarchar(255);

update Nashvillehousing
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3)


alter table nashvillehousing
add OwnerSplitCity nvarchar(255);

update Nashvillehousing
set OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'),2)

alter table nashvillehousing
add OwnerSplitState nvarchar(255);

update Nashvillehousing
set OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)

select * from Nashvillehousing
--change  Y and N to Yes and No in "sold as vacant" field
select distinct (SoldAsVacant), COUNT(SoldAsVacant)
from Nashvillehousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'yes'
	   when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end
from Nashvillehousing

update Nashvillehousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'yes'
	   when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end

--remove duplicate
with RowNumCTE as(
select *,
	ROW_NUMBER() over (
	partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by
					UniqueID
					) row_num
from Nashvillehousing
--order by ParcelID
)
select * from RowNumCTE
where row_num >1
order by PropertyAddress

--delete unused columns

alter table Nashvillehousing
drop column OwnerAddress, TaxDistrict,PropertyAddress

alter table Nashvillehousing
drop column SaleDate


