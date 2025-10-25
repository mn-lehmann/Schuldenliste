from openpyxl import load_workbook
wb = load_workbook("kassenbuch.xlsx")
ws = wb.active
ws['C5'] = "Testperson"
wb.save('test.xlsx')
t = 0