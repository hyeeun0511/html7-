import datetime
from stuConnect import *  # stuConnect.pt에 있는 모든것을 가져온다는 의미
conn = getConnection()    # 연결
title = ['번호','이름','국어','영어','수학','합계','평균','날짜','등수','등급']


# 1. 성적입력
def stuInput():
    name = input("이름을 입력하세요.>> ")
    kor = int(input("국어점수를 입력하세요.>> "))    # 숫자-> int로 숫자변환 해줘야함
    eng = int(input("영어점수를 입력하세요.>> "))
    math = int(input("수학점수를 입력하세요.>> "))
    total = kor+eng+math
    avg = total/3
    query = f"insert into stuscore3 values (\
        stuscore3_seq.nextval,'{name}',{kor},{eng},{math},{total},{avg},\
            sysdate,0,' ')"
    #
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute(query)
    conn.commit()
    conn.close()
    #
    print(name,"학생성적이 입력되었습니다.")
    print()  


# 2. 성적출력
def stuOutput():
    query = "select * from stuscore3 order by sno"  # 전체출력부분 갖고옴
    #
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute(query)  # query문이 있어야 적용됨
    #
    rows = cursor.fetchall()  # 입력된 모든(fetchall) 값을 가져옴  # rows:for문에 적용이 됨
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(*title))
    print("-"*50)
    for r in rows:   # 반복 필요X -> r
        print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
        # title = ['번호','이름', '국어',  '영어', '수학',  '합계',    '평균',            '날짜',           '등수',    '등급']
        # 평균, 날짜 : 함수
    print()
    conn.commit()  # 마지막에 위치_정보를 불러온 후 commit하고 닫아야함 // 순서.위치 중요
    conn.close()
        


# 3. 성적수정
def stuUpdate():
    # 1) 학생 검색
    name = input("수정하려는 학생이름을 입력하세요.>> ")
    # db연결
    #  # 서로 연관되어있음
    conn = getConnection()
    cursor = conn.cursor()
    query = f"select * from stuscore where name like '%{name}%'"
    cursor.execute(query)
    rows = cursor.fetchall()
    #
    print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}").format(*title)
    print("-"*80)
    if len(rows)>0:
        for r in rows:
            print(f"{r[0]}\t{r[1]}\t{r[2]}\t{r[3]}\t{r[4]}\t{r[5]}\t{r[6]:.2f}\t{r[7].strftime("%y-%m-%d")}\t{r[8]}\t{r[9]}")
            # title = ['번호','이름', '국어',  '영어', '수학',  '합계',    '평균',            '날짜',           '등수',    '등급']
            print()
            choice = input("수정하려는 학생번호를 입력하세요.>> ")
            #
            query = f"select * from stuscore3 where sno = {choice}"
            cursor = conn.cursor()
            r = cursor.fetchone()
            if r:
                print(r)
#-----------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            #

# 4. 성적삭제


# 5. 학생검색


# 6. 학생정렬


# 7. 등수처리


