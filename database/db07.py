import oracledb

def getConnection():
    return oracledb.connect\
        (user='ora_user',password='1111',dsn='localhost:1521/xe')
        
# db연결실행
# sql 실행
conn = getConnection()
# 창
cursor = conn.cursor()
# query구문  / oracle에서 가져옴
query = "select substr(phone,0,3),substr(phone,5,3),substr(phone,9,4) from member"
cursor.execute(query)
# 데이터 가져옴
rows = cursor.fetchall()


# 1. member테이블에서 phone컬럼을 분리해서 가져와서 출력

# 국번 전화번호1 전화번호2   <- 출력형태
#-------------------------------------
# 527  250      1397

# 데이터 출력
print(f"국번\t전번1\t전번2")
print("-"*50)
for row in rows:
    print("{}\t{}\t{}".format(*row))




# 2. member테이블에서 phone컬럼을 가져와서 파이썬에서 분리해서 출력
# 국번 전화번호1 전화번호2   <- 출력형태
#-------------------------------------
# 527  250      1397
query = "select phone from member"
cursor.execute(query)
rows = cursor.fetchall()
print(f"국번\t전번1\t전번2")
print("-"*50)
for row in rows:
    r = row[0].split("-")
    print("{}\t{}\t{}".format(*r))



# sql연결확인
print("연결 : ",conn)
conn.close()



