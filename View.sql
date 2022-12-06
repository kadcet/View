--View 

/*
1. Parse : Kodun söz dizimini denetliyor
2. Resolve : Sorguda kullanýlan tablolarýn kolonlarýn varlýðý denetlenir
3. Optimize : Sorgu sonucu nasýl döndürülecek (index vs. kullaným kararlarý)
4. Compile (Derleme) : sorgu makine diline döndürülür 
5. Execute : Derlenen sorgu çalýþtýrýlýr 
*/


SELECT * FROM sys.messages
USE NORTHWND
GO
SELECT * FROM Invoices
-- view içindeki bazý alanlarýda seçerek getirebilirz
SELECT CustomerName,OrderID FROM Invoices

CREATE VIEW v_UrunKatTed
AS --gibi
SELECT P.ProductName, P.UnitsInStock,C.CategoryName,S.CompanyName
FROM Products P INNER JOIN Categories C ON C.CategoryID=P.CategoryID
	INNER JOIN Suppliers S ON S.SupplierID=P.SupplierID

SELECT * FROM v_UrunKatTed

--View Silme
--DROP VIEW v_UrunKatTed

--View de tanýmlanmayan kolonlar sorgulanamaz
SELECT ProductName, UnitPrice  FROM v_UrunKatTed
  
SELECT * FROM v_UrunKatTed WHERE CategoryName='Beverages'

INSERT v_UrunKatTed (ProductName,UnitsInStock,CategoryName,CompanyName)
	VALUES ('Nescafe',30,'Kahve','Nestle')

-- bir insert sorgusunda view de kullanýlan kolonlardan birden fazlasýnada data gönderebilirim.
-- Ama önemli olan kýstas Ýnsert sorgusunda AYNI TABLONUN KOLONLARINA data göndermeliyim.Yukarýdaki gibi hem products tablosuna
-- hem category tablosuna olmaz.
INSERT v_UrunKatTed (ProductName,UnitsInStock)
	VALUES ('Nescafe',30)
GO

CREATE VIEW v_SipCal
AS
SELECT O.OrderID, E.FirstName+ ' '+E.LastName 'Name Surname'
FROM Orders O INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID

SELECT * FROM v_SipCal

ALTER VIEW v_SipCal
AS
SELECT COUNT(O.OrderID) 'Siparis Sayýsý', E.FirstName+ ' '+E.LastName 'Ad Soyad'
FROM Orders O INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
GROUP BY E.FirstName+ ' '+E.LastName

SELECT * FROM v_SipCal

SELECT * FROM v_UrunKatTed

-- Query penceresini baþka þekildede kullanabiliriz.
-- Sorguyu seçtikten sonra Ctrl+Shift+Q kombinasyonunu kullanarak Query Designer açýlýr.

SELECT COUNT(O.OrderID) 'Siparis Sayýsý', E.FirstName+ ' '+E.LastName 'Ad Soyad'
FROM Orders O INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
GROUP BY E.FirstName+ ' '+E.LastName



