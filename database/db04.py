import oracledb
#db연결함수선언
def getConnection():
    return oracledb.connect\
           (user="ora_user",password="1111",dsn="localhost:1521/xe")



title = ['번호','이름','국어','영어','수학','합계','평균']

while (True):
    print("[ 학생성적프로그램 ]")
    print("-----------------------")
    print("1.학생성적입력")
    print("2.학생성적출력")
    print("3.학생성적수정")
    print("4.학생성적삭제")
    print("0.프로그램종료")
    print("-----------------------")
    choice = input('원하는 번호를 입력하세요.>> ')
    if choice=="1":
        print("[ 학생성적입력 ]")
        name = input("학생이름을 입력하세요.>> ")
        kor = int(input("국어성적을 입력하세요.>> "))
        eng = int(input("영어성적을 입력하세요.>> "))
        math = int(input("수학성적을 입력하세요.>> "))
        total = kor+eng+math
        avg = total/3
        # db저장
        conn = getConnection()  # ora_user사용자 생성
        cursor = conn.cursor()  # saql developer 실행
        query = f"insert into stuscore values (stuscore_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},sysdate)"
        cursor.execute(query)   # 쿼리문을 실행 (ctrl+enter)
        conn.commit() # insert,update,delete commit실행
        print("학생성적을 저장합니다!!")
        print()
        conn.close()  #db연결끊음
    elif choice=="2":
        conn = getConnection() #db연결  # ora_user사용자 생성
        cursor = conn.cursor()          # saql developer 실행
        query = "select * from stuscore"
        cursor.execute(query)  # query문 실행
        rows = cursor.fetchall()  # 검색된 내용 출력
        
        print("[ 학생성적출력 ]")
        print("-"*70)
        print("{}\t{:13s}{}\t{}\t{}\t{}\t{}".format(*title))
        print("-"*70)
        for row in rows:
            print("{}\t{:15s}{}\t{}\t{}\t{}\t{:.2f}".format(*row))
        
        print()
        conn.close() #db연결종료 #필수!
        
    else:
        print("[ 프로그램종료 ]")
        break
    
print("프로그램을 종료합니다.")