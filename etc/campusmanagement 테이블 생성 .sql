-- 계정 생성 및 권한 부여
 create user 'campusadmin'@'%' identified by '1234';
 GRANT ALL PRIVILEGES ON campusmanagement.* TO 'campusadmin'@'%';
 
FLUSH PRIVILEGES;
 
drop database campusmanagement;

commit;

-- DB 생성 및 선택
create database campusmanagement;
use campusmanagement;

SELECT user, host FROM mysql.user WHERE user = 'campusadmin';

-- =================================================== 멤버 관련 ==============================================================

-- 사용자 테이블
CREATE TABLE User (
    user_id INT auto_increment PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'PROFESSOR', 'ADMIN') NOT NULL
);

-- 학생 테이블
CREATE TABLE Student (
    user_id INT PRIMARY KEY,
    student_number VARCHAR(20) UNIQUE,
    department VARCHAR(100),
    grade INT,
    status ENUM('재학','휴학','졸업')NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- 교수 테이블
CREATE TABLE Professor (
    user_id INT PRIMARY KEY,
    professor_number VARCHAR(20) UNIQUE,
    department VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- 과목 테이블
CREATE TABLE Subject (
    subject_code VARCHAR(20) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    subject_type VARCHAR(50) NOT NULL,
    open_grade INT NOT NULL,
    division VARCHAR(10),
    credit INT NOT NULL,
    professor_id INT,
    professor_name VARCHAR(50),
    schedule VARCHAR(100),
    current_enrollment INT DEFAULT 0,
    capacity INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (professor_id) REFERENCES User(user_id)
);

-- 수강신청 테이블
CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_code VARCHAR(20) NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Student(user_id),
    FOREIGN KEY (subject_code) REFERENCES Subject(subject_code),
    UNIQUE (student_id, subject_code)
);

-- 출결 테이블
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('PRESENT', 'ABSENT', 'LATE') NOT NULL,
    checked_by INT NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id),
    FOREIGN KEY (checked_by) REFERENCES User(user_id),
    UNIQUE (enrollment_id, date)
);

-- 성적 테이블
CREATE TABLE Grade (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    score DECIMAL(5,2) NOT NULL,
    grade CHAR(2),
    registered_by INT NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id),
    FOREIGN KEY (registered_by) REFERENCES Professor(user_id)
);

-- 공지사항 테이블
CREATE TABLE Notice (
    notice_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_id INT NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES User(user_id)
);

-- 공지사항 테이블(교수)
CREATE TABLE NoticeProfessor (
    notice_id INT AUTO_INCREMENT PRIMARY KEY, -- 공지사항 ID
    title VARCHAR(200) NOT NULL, -- 제목
    content TEXT NOT NULL, -- 내용
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성 일시
    user_id INT NOT NULL, -- 교수 ID
    file_name VARCHAR(255), -- 업로드된 파일명
    file_path VARCHAR(255), -- 파일 경로 (서버에 저장된 경로)
    file_size BIGINT, -- 파일 크기 (바이트 단위)
    FOREIGN KEY (user_id) REFERENCES Professor(user_id)
);

-- 학사일정 테이블
CREATE TABLE AcademicCalendar (
    calendar_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    start DATE NOT NULL,
    end DATE,
    description TEXT,
    color VARCHAR(100),
    admin_id INT NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES User(user_id)
);

select * from AcademicCalendar;

-- QnA: 학생 → 교수
CREATE TABLE Qna_Student_Professor (
    qna_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(20) NOT NULL,
    questioner_id INT NOT NULL,
    questioner_title VARCHAR(100) NOT NULL,
    question TEXT NOT NULL,
    question_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subject_code) REFERENCES Subject(subject_code),
    FOREIGN KEY (questioner_id) REFERENCES Student(user_id)
);

CREATE TABLE Reply_Qna_Professor (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    qna_id INT NOT NULL,
    professor_number INT NOT NULL,
    reply_content TEXT NOT NULL,
    reply_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qna_id) REFERENCES Qna_Student_Professor(qna_id),
    FOREIGN KEY (professor_number) REFERENCES Professor(user_id)
);

-- QnA: 사용자 → 관리자
CREATE TABLE Qna_User_Admin (
    qna_id INT AUTO_INCREMENT PRIMARY KEY,
    questioner_id INT NOT NULL,
    question_title VARCHAR(100) NOT NULL,
    question TEXT NOT NULL,
    question_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (questioner_id) REFERENCES User(user_id)
);

CREATE TABLE Reply_Qna_Admin (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    qna_id INT NOT NULL,
    user_id INT NOT NULL,
    reply_content TEXT NOT NULL,
    reply_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qna_id) REFERENCES Qna_User_Admin(qna_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- 강의 계획서 테이블
CREATE TABLE lecture_plan (
    plan_id INT AUTO_INCREMENT PRIMARY KEY, -- 강의계획서 ID
    subject_code VARCHAR(10) NOT NULL UNIQUE, -- 교과 코드
    subject_name VARCHAR(10) NOT NULL, -- 과목 이름
    professor_id VARCHAR(20) NOT NULL, -- 교수 ID
    professor_name VARCHAR(50) NOT NULL, -- 교수 이름
    lecture_period VARCHAR(100), -- 강의 기간 (예: "2025.03~2025.06")
    target_students VARCHAR(100), -- 수강 대상
    main_content TEXT, -- 주요 내용
    goal TEXT, -- 강의 목표
    method TEXT, -- 강의 방법
    content TEXT, -- 강의 내용
    evaluation TEXT, -- 평가 방법
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 등록일시
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 수정일시
);