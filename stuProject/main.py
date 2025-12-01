# import stuConnect
from stuConnect import *  # stuConnect에서 갖고옴
from stuFunc import *     # stuFunc에서 갖고옴

conn = getConnection()
# print("연결 : ",conn)  --확인차


# -----------------------------
# while문
while True:
    print("[ 학생성적처리 프로그램 ]")
    print("1. 성적입력")
    print("2. 성적출력")
    print("3. 성적수정")
    print("4. 성적삭제")
    print("5. 학생검색")
    print("6. 학생정렬")
    print("7. 등수처리")  ##
    print("0. 프로그램 종료")
    print("-"*50)
    choice = input("원하는 번호를 입력하세요.>> ")
    if choice == "1": # 성적입력
        #pass  # 일단pass로
        stuInput()
    elif choice == "2": # 성적출력
        stuOutput()
    elif choice == "3": # 성적수정
        stuUpdate()
    elif choice == "4": # 성적삭제
        pass
    elif choice == "5": # 학생검색
        pass
    elif choice == "6": # 학생정렬
        pass
    elif choice == "7": # 등수처리
        pass
    else:               # 0. 프로그램 종료
        print("[프로그램 종료]") 
        break           # 반복 종료