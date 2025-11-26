import oracledb
def getConnection():
    return oracledb.connect\
        (user="ora_user",password="1111",dsn="localhost:1521/xe")  # SQL'ora_user 사용자' -> 속성값 입력 


title = ['번호','이름','국어','영어','수학','합계','평균']

while (True):
    print("[ 학생성적프로그램 ]")
    print("------------------------")
    print("1.학생성적입력")
    print("2.학생성적출력")
    print("3.학생성적수정")
    print("4.학생성적삭제")
    print("0.프로그램종료")
    print("------------------------")
    choice = input('원하는 번호를 입력하세요.>> ')
    
    if choice == "1":
        