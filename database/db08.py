import oracledb

def getConnection():
    return oracledb.connect\
        (user='ora_user',password='1111',dsn='localhost:1521/xe')
        


######퀴즈######
while(True):
    score = input("점수를 입력하세요.>> ")
    
    # db연결실행
    # sql 실행
    conn = getConnection()
    # 창
    cursor = conn.cursor()
    # query구문  / sql에서 가져옴
    query = f"select count(total) from stuscore where total>={score}"
    cursor.execute(query)
    # 데이터 가져옴
    rows = cursor.fetchall()
    
    # stuscore테이블 total컬럼을 비교해서
    # 입력한 점수보다 합계점수가 높은 학생이 몇명인지 출력하시오.
    # query - "select count(total) from stuscore where total>=120;"
    
    print("입력점수 :",score)
    print("입력한 점수보다 높은 학생수 : ",rows[0][0])
    
conn.clase()    

    
    




# 월금   년봉   원화   - 천단위표시해서 출력하시오.
# -------------------------------------------
# 2000  2000*12  2000*12*1743
# select to_number('20,000','99,999'),to_number(replace('30,000',',','')) from dual

# print(f"월급\t년봉\t원화")
# print("-"*50)
# for row in rows:
#     print(row[0],row[1],row[2])
    