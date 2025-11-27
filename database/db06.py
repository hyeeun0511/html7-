import oracledb

def getConnection():
    return oracledb.connect\
        (user="ora_user",password="1111",dsn="localhost:1521/xe")
        
        
        
        
while(True):
    print("1.입력")
    print("2.출력")
    print("3.수정")
    choice = input("원하는 번호 >>")
    if choice == "1":
        #db연결
        conn = getConnection()
        cursor = conn.cursor()
        # insert,update,delete
        # query = "insert into member values ()"
        # cursor.excute(query)
        # conn.commit()
        
        # select - 여러명:fetchall() list의 튜플타입, 1명:fetchone() 튜플타입
        query = "select * from member where id = 'aaa'" 
        cursor.execute(query)
        rows = cursor.fetchall()
        print(rows)
        
        conn.close()
        
        
        #db연결종료
        pass
    elif choice == "2":
        #db연결
        #db연결종료
        pass
    else:
        #db연결
        #db연결종료
        pass
