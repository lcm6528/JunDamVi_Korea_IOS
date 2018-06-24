maxRow = 7 #최대 높이

row = 1
while row <= maxRow:
    col = 1
    while col < maxRow*2:
        if row == maxRow or col - row == maxRow/2 -1 or row + col == maxRow/2 + 1:
            print('*', end = '')
        else:
            print(' ', end = '')
        col += 1
 
    row += 1
    print()
