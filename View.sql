--View 

/*
1. Parse : Kodun s�z dizimini denetliyor
2. Resolve : Sorguda kullan�lan tablolar�n kolonlar�n varl��� denetlenir
3. Optimize : Sorgu sonucu nas�l d�nd�r�lecek (index vs. kullan�m kararlar�)
4. Compile (Derleme) : sorgu makine diline d�nd�r�l�r 
5. Execute : Derlenen sorgu �al��t�r�l�r 
*/


SELECT * FROM sys.messages
USE NORTHWND
GO
SELECT * FROM Invoices
-- view i�indeki baz� alanlar�da se�erek getirebilirz
SELECT CustomerName,OrderID FROM Invoices

CREATE VIEW v_UrunKatTed
AS --gibi
SELECT P.ProductName, P.UnitsInStock,C.CategoryName,S.CompanyName
FROM Products P INNER JOIN Categories C ON C.CategoryID=P.CategoryID
	INNER JOIN Suppliers S ON S.SupplierID=P.SupplierID

SELECT * FROM v_UrunKatTed

--View Silme
--DROP VIEW v_UrunKatTed

--View de tan�mlanmayan kolonlar sorgulanamaz
SELECT ProductName, UnitPrice  FROM v_UrunKatTed
  
SELECT * FROM v_UrunKatTed WHERE CategoryName='Beverages'

INSERT v_UrunKatTed (ProductName,UnitsInStock,CategoryName,CompanyName)
	VALUES ('Nescafe',30,'Kahve','Nestle')

-- bir insert sorgusunda view de kullan�lan kolonlardan birden fazlas�nada data g�nderebilirim.
-- Ama �nemli olan k�stas �nsert sorgusunda AYNI TABLONUN KOLONLARINA data g�ndermeliyim.Yukar�daki gibi hem products tablosuna
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
SELECT COUNT(O.OrderID) 'Siparis Say�s�', E.FirstName+ ' '+E.LastName 'Ad Soyad'
FROM Orders O INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
GROUP BY E.FirstName+ ' '+E.LastName

SELECT * FROM v_SipCal

SELECT * FROM v_UrunKatTed

-- Query penceresini ba�ka �ekildede kullanabiliriz.
-- Sorguyu se�tikten sonra Ctrl+Shift+Q kombinasyonunu kullanarak Query Designer a��l�r.

SELECT COUNT(O.OrderID) 'Siparis Say�s�', E.FirstName+ ' '+E.LastName 'Ad Soyad'
FROM Orders O INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
GROUP BY E.FirstName+ ' '+E.LastName



