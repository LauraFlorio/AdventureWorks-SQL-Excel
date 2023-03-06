-- Tables:
-- Year of analysis: 2022 (OrderDate)
-- i)	Total Internet Sales by Category
-- ii)	Total Internet Sales by OrderDate Month
-- iii)	Total Internet Sales Amount vs Cost by Country
-- iv)	 Total Internet Sales by Gender

select top(5) * from FactInternetSales -- TABLE 1
select top(5) * from DimProductCategory -- TABLE 2
select top(5) * from DimSalesTerritory -- TABLE 3
select top(5) * from DimCustomer -- TABLE 4

-- Columns:

-- SalesOrderNumber                        (TABLE 1: FactInternetSales)
-- OrderDate                               (TABLE 1: FactInternetSales)
-- EnglishProductCategoryName              (TABLE 2: DimProductCategory)
-- First Name + Last Name                  (TABLE 4: DimCustomer)
-- Gender                                  (TABLE 4: DimCustomer)
-- SalesTerritoryCountry                   (TABLE 3: DimSalesTerritory)
-- OrderQuantity                           (TABLE 1: FactInternetSales)
-- TotalProductCost                        (TABLE 1: FactInternetSales)
-- SalesAmount                             (TABLE 1: FactInternetSales)


-- Creating view INTERNET_SALES
GO
CREATE OR ALTER VIEW INTERNET_SALES as
select 
	fis.SalesOrderNumber,
	fis.OrderDate,
	dpc.EnglishProductCategoryName as ProductCategory,
	dc.FirstName + ' ' + dc.LastName as CustomerName,
	dc.Gender as CustomerGender,
	dst.SalesTerritoryCountry as SalesCountry,
	fis.OrderQuantity as SalesQuantity,
	fis.TotalProductCost,
	fis.SalesAmount
from
	FactInternetSales fis
	left join DimProduct dp on fis.ProductKey = dp.ProductKey
		left join DimProductSubcategory dps on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
			left join DimProductCategory dpc on dps.ProductCategoryKey = dpc.ProductCategoryKey
	left join DimSalesTerritory dst on fis.SalesTerritoryKey = dst.SalesTerritoryKey
	left join DimCustomer dc on fis.CustomerKey = dc.CustomerKey
where year(OrderDate) = 2022
GO

select * from INTERNET_SALES
