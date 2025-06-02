-- 관리자 로그인 
-- 아이디  = admin@email.com
-- 비밀번호 = 1234

-- 교수 로그인
-- 아이디  = professor@email.com
-- 비밀번호 = 1234

-- 학생 로그인
-- 아이디 = student@email.com
-- 비밀번호 = 1234

-- 성적 관련기능은 학생2 이메일로 로그인 하셔야 더미 데이터가 존재합니다.
-- 아이디 = student2@email.com
-- 비밀번호 = 1234

-- ✅ 1. 관리자 계정 추가
INSERT INTO User (user_id, name, email, password, role) VALUES
(1, '관리자', 'admin@email.com', '1234', 'ADMIN');

-- ✅ 1. 교수 계정 추가
INSERT INTO User(user_id, name, email, password, role) VALUES (2, '김교수', 'professor@campus.com', '1234', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (2, 'P016', '컴퓨터공학과');

-- ✅ 2. 교수의 강의 5개 등록 (1~8교시 제한 반영)
-- 승인됨: 2개 (is_available = TRUE)
INSERT INTO Subject(subject_code, subject_name, subject_type, open_grade, division, credit, professor_id, professor_name, schedule, capacity, is_available)
VALUES ('SUB101', '자료구조', '전공', 3, 'A', 3, 2, '김교수', '월 2-3교시, 수 6-8교시', 50, TRUE);
INSERT INTO Subject(subject_code, subject_name, subject_type, open_grade, division, credit, professor_id, professor_name, schedule, capacity, is_available)
VALUES ('SUB102', '운영체제', '전공', 3, 'A', 3, 2, '김교수', '월 4-6교시', 50, TRUE);

-- 승인 안됨: 3개 (is_available = FALSE)
INSERT INTO Subject(subject_code, subject_name, subject_type, open_grade, division, credit, professor_id, professor_name, schedule, capacity, is_available)
VALUES ('SUB103', '컴퓨터구조', '전공', 3, 'A', 3, 2, '김교수', '금 1-2교시', 50, FALSE);
INSERT INTO Subject(subject_code, subject_name, subject_type, open_grade, division, credit, professor_id, professor_name, schedule, capacity, is_available)
VALUES ('SUB104', '컴파일러', '전공', 3, 'A', 3, 2, '김교수', '화 3-4교시', 50, FALSE);
INSERT INTO Subject(subject_code, subject_name, subject_type, open_grade, division, credit, professor_id, professor_name, schedule, capacity, is_available)
VALUES ('SUB105', '네트워크', '전공', 3, 'A', 3, 2, '김교수', '수 1-3교시', 50, FALSE);

-- ✅ 3-1. 학생 15(3~17)명 등록(수강신청, 성적, QnA 등록)
INSERT INTO User(user_id, name, email, password, role) VALUES (3, '학생1', 'student@email.com', '1234', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (3, '202401100', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (4, '학생2', 'student2@email.com', '1234', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (4, '202401101', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (5, '학생3', '202401102@campus.com', 'pw102', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (5, '202401102', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (6, '학생4', '202401103@campus.com', 'pw103', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (6, '202401103', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (7, '학생5', '202401104@campus.com', 'pw104', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (7, '202401104', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (8, '학생6', '202401105@campus.com', 'pw105', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (8, '202401105', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (9, '학생7', '202401106@campus.com', 'pw106', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (9, '202401106', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (10, '학생8', '202401107@campus.com', 'pw107', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (10, '202401107', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (11, '학생9', '202401108@campus.com', 'pw108', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (11, '202401108', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (12, '학생10', '202401109@campus.com', 'pw109', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (12, '202401109', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (13, '학생11', '202401110@campus.com', 'pw110', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (13, '202401110', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (14, '학생12', '202401111@campus.com', 'pw111', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (14, '202401111', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (15, '학생13', '202401112@campus.com', 'pw112', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (15, '202401112', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (16, '학생14', '202401113@campus.com', 'pw113', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (16, '202401113', '컴퓨터공학과', 3, '재학');
INSERT INTO User(user_id, name, email, password, role) VALUES (17, '학생15', '202401114@campus.com', 'pw114', 'STUDENT');
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES (17, '202401114', '컴퓨터공학과', 3, '재학');

-- ✅ 3-2. 학생 15명 수강신청 (SUB101: 학생3~12, SUB102: 학생13~17)
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (1, 3, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (2, 4, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (3, 5, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (4, 6, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (5, 7, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (6, 8, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (7, 9, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (8, 10, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (9, 11, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (10, 12, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (11, 13, 'SUB102');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (12, 14, 'SUB102');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (13, 15, 'SUB102');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (14, 16, 'SUB102');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (15, 17, 'SUB102');

-- ✅ 3-3. 학생 15명 성적 등록
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (1, 80, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (2, 81, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (3, 82, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (4, 83, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (5, 84, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (6, 85, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (7, 86, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (8, 87, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (9, 88, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (10, 89, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (11, 90, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (12, 91, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (13, 92, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (14, 93, 'A0', 2);
INSERT INTO Grade(enrollment_id, score, grade, registered_by) VALUES (15, 94, 'A0', 2);

-- ✅ 3-4. 학생 15명 Q&A 등록
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (1, 'SUB101', 3, '질문 제목 1', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (2, 'SUB101', 4, '질문 제목 2', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (3, 'SUB101', 5, '질문 제목 3', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (4, 'SUB101', 6, '질문 제목 4', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (5, 'SUB101', 7, '질문 제목 5', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (6, 'SUB101', 8, '질문 제목 6', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (7, 'SUB101', 9, '질문 제목 7', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (8, 'SUB101', 10, '질문 제목 8', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (9, 'SUB101', 11, '질문 제목 9', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (10, 'SUB101', 12, '질문 제목 10', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (11, 'SUB102', 13, '질문 제목 11', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (12, 'SUB102', 14, '질문 제목 12', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (13, 'SUB102', 15, '질문 제목 13', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (14, 'SUB102', 16, '질문 제목 14', '이 과목 관련 질문입니다.');
INSERT INTO Qna_Student_Professor(qna_id, subject_code, questioner_id, questioner_title, question) VALUES (15, 'SUB102', 17, '질문 제목 15', '이 과목 관련 질문입니다.');



-- ✅ 4-1 추가 학생 55명 등록 (18~72) , 김교수(2)의 자료구조 과목에만 수강신청한 상태
INSERT INTO User(user_id, name, email, password, role) VALUES 
(18, '학생16', '202401018@campus.com', 'pw18', 'STUDENT'),
(19, '학생17', '202401019@campus.com', 'pw19', 'STUDENT'),
(20, '학생18', '202401020@campus.com', 'pw20', 'STUDENT'),
(21, '학생19', '202401021@campus.com', 'pw21', 'STUDENT'),
(22, '학생20', '202401022@campus.com', 'pw22', 'STUDENT'),
(23, '학생21', '202401023@campus.com', 'pw23', 'STUDENT'),
(24, '학생22', '202401024@campus.com', 'pw24', 'STUDENT'),
(25, '학생23', '202401025@campus.com', 'pw25', 'STUDENT'),
(26, '학생24', '202401026@campus.com', 'pw26', 'STUDENT'),
(27, '학생25', '202401027@campus.com', 'pw27', 'STUDENT'),
(28, '학생26', '202401028@campus.com', 'pw28', 'STUDENT'),
(29, '학생27', '202401029@campus.com', 'pw29', 'STUDENT'),
(30, '학생28', '202401030@campus.com', 'pw30', 'STUDENT'),
(31, '학생29', '202401031@campus.com', 'pw31', 'STUDENT'),
(32, '학생30', '202401032@campus.com', 'pw32', 'STUDENT'),
(33, '학생31', '202401033@campus.com', 'pw33', 'STUDENT'),
(34, '학생32', '202401034@campus.com', 'pw34', 'STUDENT'),
(35, '학생33', '202401035@campus.com', 'pw35', 'STUDENT'),
(36, '학생34', '202401036@campus.com', 'pw36', 'STUDENT'),
(37, '학생35', '202401037@campus.com', 'pw37', 'STUDENT'),
(38, '학생36', '202401038@campus.com', 'pw38', 'STUDENT'),
(39, '학생37', '202401039@campus.com', 'pw39', 'STUDENT'),
(40, '학생38', '202401040@campus.com', 'pw40', 'STUDENT'),
(41, '학생39', '202401041@campus.com', 'pw41', 'STUDENT'),
(42, '학생40', '202401042@campus.com', 'pw42', 'STUDENT'),
(43, '학생41', '202401043@campus.com', 'pw43', 'STUDENT'),
(44, '학생42', '202401044@campus.com', 'pw44', 'STUDENT'),
(45, '학생43', '202401045@campus.com', 'pw45', 'STUDENT'),
(46, '학생44', '202401046@campus.com', 'pw46', 'STUDENT'),
(47, '학생45', '202401047@campus.com', 'pw47', 'STUDENT'),
(48, '학생46', '202401048@campus.com', 'pw48', 'STUDENT'),
(49, '학생47', '202401049@campus.com', 'pw49', 'STUDENT'),
(50, '학생48', '202401050@campus.com', 'pw50', 'STUDENT'),
(51, '학생49', '202401051@campus.com', 'pw51', 'STUDENT'),
(52, '학생50', '202401052@campus.com', 'pw52', 'STUDENT'),
(53, '학생51', '202401053@campus.com', 'pw53', 'STUDENT'),
(54, '학생52', '202401054@campus.com', 'pw54', 'STUDENT'),
(55, '학생53', '202401055@campus.com', 'pw55', 'STUDENT'),
(56, '학생54', '202401056@campus.com', 'pw56', 'STUDENT'),
(57, '학생55', '202401057@campus.com', 'pw57', 'STUDENT'),
(58, '학생56', '202401058@campus.com', 'pw58', 'STUDENT'),
(59, '학생57', '202401059@campus.com', 'pw59', 'STUDENT'),
(60, '학생58', '202401060@campus.com', 'pw60', 'STUDENT'),
(61, '학생59', '202401061@campus.com', 'pw61', 'STUDENT'),
(62, '학생60', '202401062@campus.com', 'pw62', 'STUDENT'),
(63, '학생61', '202401063@campus.com', 'pw63', 'STUDENT'),
(64, '학생62', '202401064@campus.com', 'pw64', 'STUDENT'),
(65, '학생63', '202401065@campus.com', 'pw65', 'STUDENT'),
(66, '학생64', '202401066@campus.com', 'pw66', 'STUDENT'),
(67, '학생65', '202401067@campus.com', 'pw67', 'STUDENT'),
(68, '학생66', '202401068@campus.com', 'pw68', 'STUDENT'),
(69, '학생67', '202401069@campus.com', 'pw69', 'STUDENT'),
(70, '학생68', '202401070@campus.com', 'pw70', 'STUDENT'),
(71, '학생69', '202401071@campus.com', 'pw71', 'STUDENT'),
(72, '학생70', '202401072@campus.com', 'pw72', 'STUDENT');

-- ✅ 4-2 학생 55명 등록
INSERT INTO Student(user_id, student_number, department, grade, status) VALUES 
(18, '202401018', '컴퓨터공학과', 3, '재학'),
(19, '202401019', '컴퓨터공학과', 3, '재학'),
(20, '202401020', '컴퓨터공학과', 3, '재학'),
(21, '202401021', '컴퓨터공학과', 3, '재학'),
(22, '202401022', '컴퓨터공학과', 3, '재학'),
(23, '202401023', '컴퓨터공학과', 3, '재학'),
(24, '202401024', '컴퓨터공학과', 3, '재학'),
(25, '202401025', '컴퓨터공학과', 3, '재학'),
(26, '202401026', '컴퓨터공학과', 3, '재학'),
(27, '202401027', '컴퓨터공학과', 3, '재학'),
(28, '202401028', '컴퓨터공학과', 3, '재학'),
(29, '202401029', '컴퓨터공학과', 3, '재학'),
(30, '202401030', '컴퓨터공학과', 3, '재학'),
(31, '202401031', '컴퓨터공학과', 3, '재학'),
(32, '202401032', '컴퓨터공학과', 3, '재학'),
(33, '202401033', '컴퓨터공학과', 3, '재학'),
(34, '202401034', '컴퓨터공학과', 3, '재학'),
(35, '202401035', '컴퓨터공학과', 3, '재학'),
(36, '202401036', '컴퓨터공학과', 3, '재학'),
(37, '202401037', '컴퓨터공학과', 3, '재학'),
(38, '202401038', '컴퓨터공학과', 3, '재학'),
(39, '202401039', '컴퓨터공학과', 3, '재학'),
(40, '202401040', '컴퓨터공학과', 3, '재학'),
(41, '202401041', '컴퓨터공학과', 3, '재학'),
(42, '202401042', '컴퓨터공학과', 3, '재학'),
(43, '202401043', '컴퓨터공학과', 3, '재학'),
(44, '202401044', '컴퓨터공학과', 3, '재학'),
(45, '202401045', '컴퓨터공학과', 3, '재학'),
(46, '202401046', '컴퓨터공학과', 3, '재학'),
(47, '202401047', '컴퓨터공학과', 3, '재학'),
(48, '202401048', '컴퓨터공학과', 3, '재학'),
(49, '202401049', '컴퓨터공학과', 3, '재학'),
(50, '202401050', '컴퓨터공학과', 3, '재학'),
(51, '202401051', '컴퓨터공학과', 3, '재학'),
(52, '202401052', '컴퓨터공학과', 3, '재학'),
(53, '202401053', '컴퓨터공학과', 3, '재학'),
(54, '202401054', '컴퓨터공학과', 3, '재학'),
(55, '202401055', '컴퓨터공학과', 3, '재학'),
(56, '202401056', '컴퓨터공학과', 3, '재학'),
(57, '202401057', '컴퓨터공학과', 3, '재학'),
(58, '202401058', '컴퓨터공학과', 3, '재학'),
(59, '202401059', '컴퓨터공학과', 3, '재학'),
(60, '202401060', '컴퓨터공학과', 3, '재학'),
(61, '202401061', '컴퓨터공학과', 3, '재학'),
(62, '202401062', '컴퓨터공학과', 3, '재학'),
(63, '202401063', '컴퓨터공학과', 3, '재학'),
(64, '202401064', '컴퓨터공학과', 3, '재학'),
(65, '202401065', '컴퓨터공학과', 3, '재학'),
(66, '202401066', '컴퓨터공학과', 3, '재학'),
(67, '202401067', '컴퓨터공학과', 3, '재학'),
(68, '202401068', '컴퓨터공학과', 3, '재학'),
(69, '202401069', '컴퓨터공학과', 3, '재학'),
(70, '202401070', '컴퓨터공학과', 3, '재학'),
(71, '202401071', '컴퓨터공학과', 3, '재학'),
(72, '202401072', '컴퓨터공학과', 3, '재학');


-- ✅ 추가 교수 15명 등록 (73~87)
-- 교수 1 ~ 15 (user_id 73 ~ 87)
INSERT INTO User(user_id, name, email, password, role) VALUES (73, '교수1', 'prof1@campus.com', 'pw201', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (73, '20242001', '컴퓨터공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (74, '교수2', 'prof2@campus.com', 'pw202', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (74, '20242002', '정보통신공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (75, '교수3', 'prof3@campus.com', 'pw203', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (75, '20242003', '전자공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (76, '교수4', 'prof4@campus.com', 'pw204', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (76, '20242004', '소프트웨어공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (77, '교수5', 'prof5@campus.com', 'pw205', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (77, '20242005', '컴퓨터공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (78, '교수6', 'prof6@campus.com', 'pw206', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (78, '20242006', '정보통신공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (79, '교수7', 'prof7@campus.com', 'pw207', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (79, '20242007', '전자공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (80, '교수8', 'prof8@campus.com', 'pw208', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (80, '20242008', '소프트웨어공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (81, '교수9', 'prof9@campus.com', 'pw209', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (81, '20242009', '컴퓨터공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (82, '교수10', 'prof10@campus.com', 'pw210', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (82, '20242010', '정보통신공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (83, '교수11', 'prof11@campus.com', 'pw211', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (83, '20242011', '전자공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (84, '교수12', 'prof12@campus.com', 'pw212', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (84, '20242012', '소프트웨어공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (85, '교수13', 'prof13@campus.com', 'pw213', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (85, '20242013', '컴퓨터공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (86, '교수14', 'prof14@campus.com', 'pw214', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (86, '20242014', '정보통신공학과');
INSERT INTO User(user_id, name, email, password, role) VALUES (87, '교수15', 'prof15@campus.com', 'pw215', 'PROFESSOR');
INSERT INTO Professor(user_id, professor_number, department) VALUES (87, '20242015', '전자공학과');


-- ✅ 4-3 SUB101 수강신청 (enrollment_id: 16~70, 55명)
-- 'SUB101', '자료구조', '전공', 3, 'A', 3, 16, '김교수', '월 2-3교시, 수 6-8교시', 50, TRUE
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (16, 18, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (17, 19, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (18, 20, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (19, 21, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (20, 22, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (21, 23, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (22, 24, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (23, 25, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (24, 26, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (25, 27, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (26, 28, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (27, 29, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (28, 30, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (29, 31, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (30, 32, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (31, 33, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (32, 34, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (33, 35, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (34, 36, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (35, 37, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (36, 38, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (37, 39, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (38, 40, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (39, 41, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (40, 42, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (41, 43, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (42, 44, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (43, 45, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (44, 46, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (45, 47, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (46, 48, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (47, 49, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (48, 50, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (49, 51, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (50, 52, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (51, 53, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (52, 54, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (53, 55, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (54, 56, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (55, 57, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (56, 58, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (57, 59, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (58, 60, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (59, 61, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (60, 62, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (61, 63, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (62, 64, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (63, 65, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (64, 66, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (65, 67, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (66, 68, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (67, 69, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (68, 70, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (69, 71, 'SUB101');
INSERT INTO Enrollment(enrollment_id, student_id, subject_code) VALUES (70, 72, 'SUB101');

-- Notice 관리자 공지사항 등록
INSERT INTO Notice (title, content, admin_id) VALUES
('2025학년도 1학기 개강 안내', '2025학년도 1학기 개강은 3월 3일입니다. 수강 신청 및 시간표를 확인하시기 바랍니다.', 1),
('2025년 동아리 모집 일정 공지', '2025년 동아리 신규 가입은 3월 10일부터 3월 20일까지입니다. 자세한 사항은 학생회관 공지사항을 참고해 주세요.', 1),
('2025년 봄 축제 개최 안내', '2025년 봄 축제는 5월 14일부터 5월 16일까지 개최됩니다. 다양한 프로그램이 준비되어 있으니 많은 참여 바랍니다.', 1),
('도서관 리모델링 공사 안내', '2025년 6월부터 9월까지 중앙도서관 리모델링이 진행될 예정입니다. 이용에 참고하시기 바랍니다.', 1),
('코로나19 예방수칙 준수 요청', '개인 방역 수칙을 준수하고, 실내 마스크 착용을 권장합니다.', 1),
('2025학년도 2학기 휴학 신청 안내', '2학기 휴학 신청은 8월 1일부터 8월 15일까지 온라인으로 접수 가능합니다.', 1),
('장학금 신청 기간 안내', '2025년 1학기 국가장학금 신청 기간은 3월 1일부터 3월 15일까지입니다. 마감일을 놓치지 않도록 주의하세요.', 1),
('기숙사 입주 일정 공지', '2025학년도 1학기 기숙사 입주는 2월 28일부터 가능합니다. 사전 점검을 완료해 주시기 바랍니다.', 1),
('2025년 졸업사진 촬영 안내', '졸업 예정자는 4월 중 촬영 일정에 따라 졸업사진을 촬영하시기 바랍니다.', 1),
('학생증 재발급 안내', '분실 또는 훼손된 학생증은 종합서비스센터에서 재발급받을 수 있습니다.', 1),
('하계 계절학기 신청 안내', '하계 계절학기 수강 신청은 5월 20일부터 5월 30일까지입니다.', 1),
('캡스톤디자인 경진대회 신청', '2025년 캡스톤디자인 경진대회 신청은 4월 1일부터 가능합니다. 자세한 내용은 공지를 참고하세요.', 1),
('교내 근로장학생 모집', '2025학년도 1학기 교내 근로장학생을 모집합니다. 신청은 학생지원팀으로 문의 바랍니다.', 1),
('제2외국어 특별강좌 개설 안내', '2025년 1학기 제2외국어 특별강좌가 개설됩니다. 수강을 희망하는 학생은 신청해 주세요.', 1),
('학사 일정 변경 안내', '2025년 학사일정 중 일부가 변경되었습니다. 변경된 사항은 학교 홈페이지를 참고하시기 바랍니다.', 1);


-- Academic Calendar 관리자 학사일정 등록
INSERT INTO AcademicCalendar (title, start, end, description, color, admin_id) VALUES
('2025년 1학기 개강', '2025-03-02', NULL, '2025년도 1학기 개강일입니다.', '#28a745', 1),
('2025년 1학기 중간고사', '2025-04-17', '2025-04-25', '2025년도 1학기 중간고사 기간입니다.', '#ffc107', 1),
('2025년 1학기 기말고사', '2025-06-15', '2025-06-22', '2025년도 1학기 기말고사 기간입니다.', '#dc3545', 1),
('2025년 1학기 종강', '2025-06-22', NULL, '2025년도 1학기 종강일입니다.', '#007bff', 1),
('2025년 봄 축제', '2025-05-10', '2025-05-12', '봄을 맞이한 대학 축제입니다.', '#6f42c1', 1),
('2025년 체육대회', '2025-05-25', NULL, '전교생이 참여하는 체육대회입니다.', '#17a2b8', 1),
('2025년 여름방학 시작', '2025-06-24', NULL, '1학기 종료 후 여름방학 시작입니다.', '#20c997', 1),
('동아리 박람회', '2025-05-10', '2025-05-11', '다양한 동아리를 소개하는 박람회입니다.', '#8e44ad', 1),
('학생회 간담회', '2025-05-12', NULL, '학생회와 소통하는 간담회입니다.', '#20c997', 1),
('학술제', '2025-04-18', '2025-04-19', '학과별 연구 성과를 전시하는 학술제입니다.', '#3498db', 1),
('봉사활동 모집', '2025-04-17', '2025-04-18', '교내외 봉사활동 참가자 모집 기간입니다.', '#e67e22', 1),
('환경 캠페인', '2025-06-15', NULL, '지구의 날 맞이 환경 보호 캠페인.', '#27ae60', 1);

-- 학생2 성적 확인용 더미 데이터 추가
INSERT INTO Subject (subject_code, subject_name, subject_type, open_grade, division, credit, professor_id, professor_name, schedule, capacity)
VALUES 
('CS101', '프로그래밍 기초', '전공필수', 1, 'A', 3, 2, '김교수', '목 2-4교시', 30),
('MA201', '선형대수', '전공선택', 1, 'B', 3, 2, '김교수', '목 5-7교시', 30),
('IT303', '데이터베이스', '전공필수', 2, 'C', 3, 2, '김교수', '수 6-8교시', 30);

INSERT INTO Enrollment (student_id, subject_code)
VALUES 
(4, 'CS101'),
(4, 'MA201'),
(4, 'IT303');

INSERT INTO Grade (enrollment_id, score, grade, registered_by)
VALUES 
(77,94.5, 'A+', 2),
(78,82.0, 'B+', 2),
(79,76.3, 'C0', 2);

