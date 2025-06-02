package student.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import member.vo.StudentVO;
import member.vo.UserVO;
import student.dao.StudentDAO;
import student.vo.LectureVO;
import student.vo.SemesterGradeVO;
import student.vo.StudentGradeVO;
import student.vo.StudentQnaListVO;
import student.vo.StudentQnaWithRelpyVO;
import student.vo.StudentQusetionVO;
import student.vo.StudentSubjectVO;
import student.vo.StudentTimetableVO;
import student.vo.SubjectGradeVO;

public class StudentServiceImpl implements StudentService {

    private StudentDAO studentDAO = new StudentDAO();

    //학생이 수강신청 가능한 목록 조회
    @Override
    public List<LectureVO> getList(HttpServletRequest req) {
    
    	return studentDAO.getList(req);
    }
    
    //학생 수강 신청 요청
    @Override
    public int enroll(HttpServletRequest req) {
    	
    	//수강 신청할 과목의 정원보다 현재 인원이 적은지 확인
    	int result = studentDAO.checkCapacity(req);
    	
    	if(result == 1) {
        	String subject_code = req.getParameter("subjectCode");
        	
        	//학생 아이디
        	Integer student_id = (Integer)req.getSession().getAttribute("id");
        	
        	studentDAO.enroll(subject_code,student_id);
        	
        	//수강신청후 수강현재인원수 변경
        	studentDAO.updateCurrentEnrollment(subject_code);
    	}
    	
    	return result;

    }
    
    @Override
    public List<LectureVO> getLectureList(HttpServletRequest req) {
        
    	// 학생이 수강신청 가능한 목록 조회
    	Integer student_id = (Integer)req.getSession().getAttribute("id");
    	
        return studentDAO.getLectureList(student_id);
    }

    @Override
    public void enrollDelete(HttpServletRequest req) {
    	
    	int enrollment_id = Integer.parseInt(req.getParameter("enrollmentId"));
    	String subject_code = req.getParameter("subjectCode");
    	int id = (Integer)req.getSession().getAttribute("id");
    	
    	studentDAO.enrollDelete(req,subject_code,id,enrollment_id);
    	
    }

    // 전체 학기 성적 조회
    @Override
	public List<StudentGradeVO> getGrades(HttpServletRequest req) {
		return studentDAO.getGrades(req);
	}  

    // 특정 학기 성적 상세 조회
    @Override
    public List<SubjectGradeVO> getGradesDetail(HttpServletRequest req) {

        return null;
    }


	@Override
    public List<StudentTimetableVO> getTimeTable(HttpServletRequest req) {
        return studentDAO.getTimeTable(req);
    }

    // 학생 정보 (학번, 학년, 전공, 학적상태 등)
    @Override
    public UserVO getStudent(HttpServletRequest req) {
    	
    	// 세션에서 학생 아이디를 가져옴
    	Integer student_id = (Integer)req.getSession().getAttribute("id");
    	
    	// 학생 정보를 가져옴
    	
    	// 학생 아이디를 이용하여 학생 정보를 조회
        return studentDAO.getStudent(student_id);
    }

    // 학생 전체정보 (이름 + 학번 + 전공 + 학년 + 학적상태 등)
    @Override
    public Map<String, Object> getStudentFullInfo(HttpServletRequest req) {

        return null;
    }

    // 학생이 수강한 학기 목록 조회
    @Override
    public List<String> getSemesterList(HttpServletRequest req) {

        return null;
    }

    @Override
    public void updateStudent(HttpServletRequest req) {
        

		Integer student_id = (Integer)req.getSession().getAttribute("id");
		
		// 학생 정보를 가져옴
		UserVO userVO = studentDAO.getStudent(student_id);
		
		// 수정된 정보를 가져옴
		if(req.getParameter("email") != null) {
			userVO.setEmail(req.getParameter("email"));
		}
		
		if(req.getParameter("password") != null) {
			userVO.setPassword(req.getParameter("password"));
		}
		
		if(req.getParameter("status") != null) {
			userVO.getStudentVO().setStatus(req.getParameter("status"));
		}
		
		// 학생 정보를 업데이트
		studentDAO.updateStudent(userVO);
    }


    @Override
    public void qnaCampus(HttpServletRequest req) {
       
    	studentDAO.qnaCampus(req);
    	
    }

	@Override
	public List<StudentSubjectVO> getStudentSubject(HttpServletRequest req) {
		return studentDAO.getStudentSubject(req);
	}
	// 교수, 학생 질문 테이블 조회
	@Override
	public List<StudentQnaListVO> getStudentQna(HttpServletRequest req) {
		return studentDAO.getStudentQna(req);
	}
	// 특정 과목에 대한 질문 테이블 조회 (select option 용)
	@Override
	public List<StudentQnaListVO> getQnaBySubject(String subjectCode) {
		return studentDAO.getQnaBySubject(subjectCode);
	}
    // 특정 질문 조회
	@Override
	public StudentQnaWithRelpyVO getQnaWithReply(String qnaId) {
		return studentDAO.getQnaWithReply(qnaId);
	}
	// 학생 질문 등록

	@Override
	public int insertStudentQna(HttpServletRequest req, StudentQusetionVO vo) {
		return studentDAO.insertStudentQna(req, vo);
	}

	@Override
	public void studentDeleteQ(int qnaId) {
		studentDAO.studentDeleteQ(qnaId);
	}
	
}
