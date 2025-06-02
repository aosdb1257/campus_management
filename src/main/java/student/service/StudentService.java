package student.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import member.vo.StudentVO;
import member.vo.UserVO;
import student.vo.LectureVO;
import student.vo.StudentGradeVO;
import student.vo.StudentQnaListVO;
import student.vo.StudentQnaWithRelpyVO;
import student.vo.StudentQusetionVO;
import student.vo.StudentSubjectVO;
import student.vo.StudentTimetableVO;

public interface StudentService {
    
    // 학생 수강신청 요청
    int enroll(HttpServletRequest req);
    
    // 학생 수강목록 확인
    List<LectureVO> getLectureList(HttpServletRequest req);

    // 학생 수강신청 취소요청
    void enrollDelete(HttpServletRequest req);

    // 학생 전체 학기 성적 조회
    List getGrades(HttpServletRequest req);

    // 학생 성적 상세 조회 (특정 학기)
    List getGradesDetail(HttpServletRequest req);

    // 학생 시간표 조회
    List<StudentTimetableVO> getTimeTable(HttpServletRequest req);

    // 학생 개인정보 조회 (StudentVO)
    UserVO getStudent(HttpServletRequest req);

    // 학생 개인정보 수정 요청
    void updateStudent(HttpServletRequest req);

    // 학생 학교관련 질문글 등록 요청
    void qnaCampus(HttpServletRequest req);

    // 학생 전체정보(이름/학번/학년/전공/학적상태 등) 조회
    Map<String, Object> getStudentFullInfo(HttpServletRequest req);

    // 학생이 수강한 학기 목록 조회
    List<String> getSemesterList(HttpServletRequest req);
    
    // 학생이 수강신청 가능한 목록 조회
	List<LectureVO> getList(HttpServletRequest req);
	
	// 학생이 수강중인 과목 목록
	List<StudentSubjectVO> getStudentSubject(HttpServletRequest req);
	
	// 교수, 학생 질문 테이블 조회
	List<StudentQnaListVO> getStudentQna(HttpServletRequest req);
	// 특정 과목에 대한 질문 테이블 조회 (select option 용)
	List<StudentQnaListVO> getQnaBySubject(String subjectCode);
	// 특정 질문 조회
	StudentQnaWithRelpyVO getQnaWithReply(String qnaId);
	// 학생 질문 등록
	int insertStudentQna(HttpServletRequest req, StudentQusetionVO vo);

	void studentDeleteQ(int qnaId);
}
