package professorcontroller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import professorservice.ProfessorService;
import professorvo.AttendanceViewVo;
import professorvo.EnrolledStudentVo;
import professorvo.GradeInsertVo;
import professorvo.GradeUpdateVo;
import professorvo.GradeVo;
import professorvo.LectureListVo;
import professorvo.LecturePlanVo;
import professorvo.NoticeProfessorVo;
import professorvo.QnaStduentProfessorVo;
import professorvo.QnaVo;
import professorvo.QnaWithReplyVo;
import professorvo.ReplyProfessorVo;
import professorvo.SubjectVo;

@WebServlet("/professor/*")
public class ProfessorController extends HttpServlet {
	private ProfessorService professorService;

	@Override
	public void init() throws ServletException {
		professorService = new ProfessorService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");

		

		String action = request.getPathInfo();
		System.out.println("요청한 2단계 주소 이거:" + action);

		String nextPage = null;
        
		LecturePlanVo planvo = new LecturePlanVo();
		
		// 로그인 중인 교수 id(교수 이메일) 를 얻기 위해
		HttpSession session = request.getSession(false); // false는 세션이 없으면 새로운 세션을 만들지 않음

		// 메인화면 요청 처리
		if (action.equals("/main")) {

			nextPage = "/professors/ProfessorMain.jsp";
		}
		
		/*
		 * ----------------------------------------------------------------------------
		 *                                강의관리
		 * ----------------------------------------------------------------------------
		 */
		
		// ✅ 강의 개설 요청 / 강의 개설 폼 요청
		else if (action.equals("/lectureform")) {
			String id = String.valueOf(session.getAttribute("id"));
			System.out.println("세션 교수 아이디 : " + id);
			System.out.println("강의 개설 폼 요청...");
			
			request.setAttribute("professor_id" , id);
			request.setAttribute("center", "/professors/LectureForm.jsp");
			
			// 강의 테이블 조회
			Vector<SubjectVo> subjectVo = professorService.getAllSubject(id);
			request.setAttribute("subjectList", subjectVo);
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 강의 개설 요청 / 강의 개설 요청
		else if (action.equals("/lecturecreate")) {
		    String subjectCode = request.getParameter("subject_code");
		    String subjectName = request.getParameter("subject_name");
		    String subjectType = request.getParameter("subject_type");
		    int openGrade = Integer.parseInt(request.getParameter("open_grade"));
		    String division = request.getParameter("division");
		    int credit = Integer.parseInt(request.getParameter("credit"));
		    int professorId = Integer.parseInt(request.getParameter("professor_id"));
		    String professorName = request.getParameter("professor_name");
		    int capacity = Integer.parseInt(request.getParameter("capacity"));

		    String[] days = request.getParameterValues("day[]");
		    String[] startTimes = request.getParameterValues("start_time[]");
		    String[] endTimes = request.getParameterValues("end_time[]");

		    StringBuilder scheduleBuilder = new StringBuilder();
		    if (days != null && startTimes != null && endTimes != null) {
		        for (int i = 0; i < days.length; i++) {
		            scheduleBuilder.append(days[i])
		                           .append(" ")
		                           .append(startTimes[i])
		                           .append("-")
		                           .append(endTimes[i])
		                           .append("교시, ");
		        }
		        // 마지막 콤마 제거
		        if (scheduleBuilder.length() > 0) {
		            scheduleBuilder.setLength(scheduleBuilder.length() - 2);
		        }
		    }
		    String schedule = scheduleBuilder.toString();
		    System.out.println(schedule);
		    System.out.println(capacity);
		    // 월 4-6교시, 월 7-8교시

		    SubjectVo subjectVo = new SubjectVo(
		        subjectCode,
		        subjectName,
		        subjectType,
		        openGrade,
		        division,
		        credit,
		        professorId,
		        professorName,
		        schedule,
		        0,          // 현재 수강 인원은 기본 0
		        capacity,
		        false        // 수강 가능 여부
		    );

		    boolean result = professorService.addSubject(subjectVo);
		    
		    if (result) {
		        request.setAttribute("message", "강의 등록이 완료되었습니다!");
		        request.setAttribute("center", "/professors/CompleteRegisteringLecture.jsp");
		    } else {
		        request.setAttribute("message", "강의 등록에 실패했습니다. 다시 시도해주세요.");
		        request.setAttribute("center", "/professors/FailRegisteringLecture.jsp");
		    }
		    nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 나의 요청 강의 확인 / 요청한 강의 확인
		else if (action.equals("/lecturerequest")) {
			String id = String.valueOf(session.getAttribute("id"));
			
			// 나의 강의등록 요청 강의목록
			Vector<SubjectVo> LectureListV = professorService.getAllSubject(id);
			request.setAttribute("subjectList", LectureListV);
			request.setAttribute("center", "/professors/RequestSubjectList.jsp");
			nextPage ="/professors/ProfessorMain.jsp";
		}
		
		// ✅ 나의 강의목록 조회 / 본인이 맡은 강의목록 조회
		else if (action.equals("/lectures")) {
			String id = String.valueOf(session.getAttribute("id"));
			
			Vector<LectureListVo> LectureListV = professorService.getAllLectureList(id);
			request.setAttribute("v", LectureListV);
			
			// 강의 등록 신청 완료 화면
			request.setAttribute("center", "/professors/LectureList.jsp");
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 나의 강의목록 조회 / 강의계획서 조회
		else if (action.equals("/lectures/lectureplan")) {
			String subjectList = request.getParameter("subjectList");
			String subjectCode = request.getParameter("subjectCode");
			
			LecturePlanVo lecturePlanVo = professorService.getAllLecturePlanList(subjectCode);
			request.setAttribute("lecturePlanVo", lecturePlanVo);

			request.setAttribute("subjectList", subjectList);
			
			nextPage = "/professors/LecturePlan.jsp";
		}

		// ✅ 나의 강의목록 조회 / 강의계획서 추가
		else if (action.equals("/lectures/lectureplanadd.do")) {
			PrintWriter pw = response.getWriter();
			planvo.setSubjectCode(request.getParameter("subjectCode"));
			planvo.setSubjectName(request.getParameter("subjectName"));
	        planvo.setProfessorId(request.getParameter("professorId"));
	        planvo.setProfessorName(request.getParameter("professor"));
	        planvo.setLecturePeriod(request.getParameter("lecturePeriod"));
	        planvo.setTargetStudents(request.getParameter("open_grade"));
	        planvo.setMainContent(request.getParameter("mainContent"));
	        planvo.setGoal(request.getParameter("goal"));
	        planvo.setMethod(request.getParameter("method"));
	        planvo.setContent(request.getParameter("content"));
	        planvo.setEvaluation(request.getParameter("evaluation"));
		    
	        boolean result = professorService.addLecturePlan(planvo);

		    if (result) {
		    	pw.println("<script>alert('등록 성공');history.back();</script>");
		    } else {
		        pw.println("<script>alert('등록 실패');history.back();</script>");
		        return;
		    }
			
		}
		// ✅ 나의 강의목록 조회 / 강의계획서 수정
		else if (action.equals("/lectures/lectureplanupdate.do")) {
			PrintWriter pw = response.getWriter();
			planvo.setSubjectCode(request.getParameter("subjectCode"));
			planvo.setSubjectName(request.getParameter("subjectName"));
	        planvo.setProfessorId(request.getParameter("professorId"));
	        planvo.setProfessorName(request.getParameter("professor"));
	        planvo.setLecturePeriod(request.getParameter("lecturePeriod"));
	        planvo.setTargetStudents(request.getParameter("open_grade"));
	        planvo.setMainContent(request.getParameter("mainContent"));
	        planvo.setGoal(request.getParameter("goal"));
	        planvo.setMethod(request.getParameter("method"));
	        planvo.setContent(request.getParameter("content"));
	        planvo.setEvaluation(request.getParameter("evaluation"));
	        
			boolean result = professorService.updateLecturePlan(planvo);
		    if (result) {
		    	pw.println("<script>alert('수정 성공');history.back();</script>");
		    } else {
		        pw.println("<script>alert('등록을 먼저 해야합니다.');history.back();</script>");
		        return;
		    }
		}
		// ✅ 나의 강의목록 조회 / 강의계획서 삭제
		else if (action.equals("/lectures/lectureplandelete.do")) {
			PrintWriter pw = response.getWriter();
			String subjectCode = request.getParameter("subjectCode");
			
			System.out.println("강의계획서 삭제... ");
			
			boolean result = professorService.deleteLecturePlan(subjectCode);
			if (result) {
				pw.println("<script>");
				pw.println("alert('삭제 성공');");
				pw.println("window.close();");
				pw.println("</script>");
				return;
		    } else {
		        pw.println("<script>alert('등록이 되지 않았습니다.');history.back();</script>");
		        return;
		    }
		}
		// ✅ 나의 시간표 조회 / 교수 강의 시간표 조회
		else if (action.equals("/timetable")) {
			String id = String.valueOf(session.getAttribute("id"));
			System.out.println("교수 강의 시간표 조회... : " + id);
			// 강의 테이블 조회
			Vector<SubjectVo> subjectVo = professorService.getAllSubject(id);
			request.setAttribute("subjectList", subjectVo);
			request.setAttribute("center" , "/professors/TimeTable.jsp");
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		
		/*
		 * ----------------------------------------------------------------------------
		 *                                수강생 관리
		 * ----------------------------------------------------------------------------
		 */
		
		// ✅ 수강신청 학생명단 확인 / 수강신청 학생명단 조회
		else if(action.equals("/enrolledstudent")) {
			String professor_id = String.valueOf(session.getAttribute("id"));
			System.out.println("수강신청 학생명단 확인");
			
			Vector<EnrolledStudentVo> enrolledStudentVo = professorService.getAllEnrolledStudentList(professor_id);
			request.setAttribute("enrolledStudentList", enrolledStudentVo);
			request.setAttribute("center", "/professors/EnrolledStudentList.jsp");
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 수강생 출석관리 / 출석관리 화면
		else if(action.equals("/attendancemanage")) {
			System.out.println("출석조회시작...");
			String professor_id = String.valueOf(session.getAttribute("id"));
			int professordId  = Integer.parseInt(professor_id);
			
			// 교수 담당 과목 조회
			Vector<LectureListVo> subjectVo = professorService.getAllLectureList2(professor_id);
			request.setAttribute("subjectList", subjectVo);
			
			// 과목과 날짜가 선택된 경우에만 출결 목록 조회(옵션에서 선택한 과목과 날짜)
	        String subjectCode = request.getParameter("subject_code");
	        String date = request.getParameter("date");			
	        
	        if (subjectCode != null && date != null) {
	            Vector<AttendanceViewVo> studentList = professorService.getAttendanceListBySubjectAndDate(subjectCode, date);
	            request.setAttribute("studentList", studentList);
	        }
	        
	        request.setAttribute("center", "/professors/attendance.jsp");
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 수강생 출석관리 / 출결 편집
		else if(action.equals("/attendanceedit")) {
		    PrintWriter pwriter  = response.getWriter();
		    String professor_id = String.valueOf(session.getAttribute("id"));
		    int professorId = Integer.parseInt(professor_id);

		    String subjectCode = request.getParameter("subject_code");
		    String date = request.getParameter("date");

		    boolean success = true;

		    try {
		        Enumeration<String> paramNames = request.getParameterNames();
		        while (paramNames.hasMoreElements()) {
		            String paramName = paramNames.nextElement();

		            if (paramName.startsWith("status_")) {
		                int enrollmentId = Integer.parseInt(paramName.substring("status_".length()));
		                String status = request.getParameter(paramName);

		                if (status != null && !status.isEmpty()) {
		                    professorService.saveOrUpdateAttendance(enrollmentId, date, status, professorId);
		                }
		            }
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        success = false;
		    }

		    if (success) {
		    	pwriter.println("<script>alert('✅ 출결이 저장되었습니다.'); window.location.href = document.referrer;</script>");
		    } else {
		    	pwriter.println("<script>alert('❌ 출결 저장 중 오류가 발생했습니다.'); history.back();</script>");
		    }
		    return;
		}
		/*
		 * ----------------------------------------------------------------------------
		 *                                성적 관리
		 * ----------------------------------------------------------------------------
		 */
		
		// ✅ 수강생 성적조회 / 강의목록에서 수강생 성적조회
		else if(action.equals("/gradeslist")) {
			String professor_id = String.valueOf(session.getAttribute("id"));
			System.out.println("성적 조회...\n");
			
			// 성적조회
			Vector<GradeVo> gradeVo = professorService.getAllGrade(professor_id);
			// 과목조회
			Vector<LectureListVo> subjectVo = professorService.getAllLectureList2(professor_id);
			
			request.setAttribute("gradeList", gradeVo);
			request.setAttribute("subjectList", subjectVo);
			request.setAttribute("center", "/professors/GradeList.jsp");
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 수강생 성적 입력,수정 / 수강생 성적 입력,수정 화면
		else if(action.equals("/gradesedit")) {
			request.setAttribute("center", "/professors/ProfessorEditMain.jsp");
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 수강생 성적 입력,수정 / 수강생 성적 입력 화면
		else if(action.equals("/gradesinsert")) {
			String professor_id = String.valueOf(session.getAttribute("id"));
			System.out.println("성적 조회...\n");
			
			// 성적조회
			Vector<GradeVo> gradeVo = professorService.getInsertGrade(professor_id);
			// 과목조회
			Vector<LectureListVo> subjectVo = professorService.getAllLectureList2(professor_id);
			
			request.setAttribute("gradeList", gradeVo);
			request.setAttribute("subjectList", subjectVo);
			request.setAttribute("center", "/professors/GradeInsert.jsp");
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 수강생 성적 입력,수정 / 수강생 성적 수정 화면
		else if(action.equals("/gradesupdate")) {
			String professor_id = String.valueOf(session.getAttribute("id"));
			System.out.println("성적 조회...\n");
			
			// 성적조회
			Vector<GradeVo> gradeVo = professorService.getUpdateGrade(professor_id);
			// 과목조회
			Vector<LectureListVo> subjectVo = professorService.getAllLectureList2(professor_id);
			
			request.setAttribute("gradeList", gradeVo);
			request.setAttribute("subjectList", subjectVo);
			request.setAttribute("center", "/professors/GradeUpdate.jsp");
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 수강생 성적 입력,수정 / 수강생 성적 입력
		else if(action.equals("/gradesinsert.do")) {
			 // JSON 데이터를 읽고 파싱
	        BufferedReader reader = request.getReader();
	        Gson gson = new Gson();
	        GradeInsertVo data = gson.fromJson(reader, GradeInsertVo.class);

	        // DB 업데이트
	        boolean result = professorService.insertGrade(data);

	        if (result) {
	            System.out.println("성공적으로 성적이 등록되었습니다.");
	        } else {
	        	System.out.println("업데이트 실패 (DB 오류)");
	        }
	        return;
		}
		// ✅ 수강생 성적 입력,수정 / 수강생 성적 수정
		else if(action.equals("/gradesupdate.do")) {
			 // JSON 데이터를 읽고 파싱
	        BufferedReader reader = request.getReader();
	        Gson gson = new Gson();
	        GradeUpdateVo data = gson.fromJson(reader, GradeUpdateVo.class);

	        // DB 업데이트
	        boolean result = professorService.updateGrade(data);

	        if (result) {
	            System.out.println("성공적으로 성적이 수정되었습니다.");
	        } else {
	        	System.out.println("업데이트 실패 (DB 오류)");
	        }
	        return;
		}
		
		/*
		 * ----------------------------------------------------------------------------
		 *                                커뮤니케이션 관리
		 * ----------------------------------------------------------------------------
		 */
		// ✅ 공지사항 / 교수 공지사항 화면 요청(공지사항 조회)
		else if(action.equals("/noticeprofessor")) {
			String professor_id = String.valueOf(session.getAttribute("id"));
			
			Vector<NoticeProfessorVo> noticeVo = professorService.getAllNoticeProfessorList(professor_id);
			request.setAttribute("noticeVo", noticeVo);
			request.setAttribute("center", "NoticeProfessor.jsp");
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 공지사항 / 교수 공지사항 등록
		else if(action.equals("/noticeinsert.do")) {
			 PrintWriter pw = response.getWriter();
			 File currentDirPath = new File("c:\\file_repo");
			 DiskFileItemFactory factory = new DiskFileItemFactory();
			 factory.setSizeThreshold(1024*1024);
			 factory.setRepository(currentDirPath);
			 
			 ServletFileUpload upload = new ServletFileUpload(factory);
		        
			 String title = null;
		     String content = null;
	         String fileName = null;
	         String filePath = null;
	         long fileSize = 0;
	         String professor_id = String.valueOf(session.getAttribute("id"));
	         int professorId = Integer.parseInt(professor_id);
	         
			 try {
				 List<FileItem> items = upload.parseRequest(request);  
				 for (FileItem item : items) {
					// 일반 입력 필드인지 확인 (true: text, textarea 등 / false: 파일)
			        if (item.isFormField()) {
			            // 일반 입력 필드 (title, content 등)
			            String fieldName = item.getFieldName(); // name 속성 (예: title, content)
			            String value = item.getString("UTF-8"); // 사용자가 입력한 값 (한글 깨짐 방지)

			            // 각각의 name에 따라 변수에 저장
			            if ("title".equals(fieldName)) title = value;
			            if ("content".equals(fieldName)) content = value;

			        } else {
			            // 파일명이 비어있지 않은지 확인 (파일이 실제로 업로드 되었는지 확인)
			            if (!item.getName().isEmpty()) {

			                // 업로드된 파일 이름만 추출 (경로 없이 순수 파일명만)
			                fileName = new File(item.getName()).getName(); 
			                // 예: 사용자가 "C:\Users\홍길동\sample.pdf" 업로드 → "sample.pdf"

			                // 서버에 저장할 전체 경로 구성 (예: C:/프로젝트경로/upload/sample.pdf)
			                filePath = currentDirPath + File.separator + fileName;

			                // 파일 크기 (byte) 저장
			                fileSize = item.getSize(); 
			                // 예: 153256 (바이트 단위)

			                // 파일을 실제 서버에 저장 (하드디스크에 write)
			                item.write(new File(filePath));

			            }
			        }
				 }
	            // VO 객체 구성 (생략 가능)
	            NoticeProfessorVo vo = new NoticeProfessorVo();
	            vo.setTitle(title);
	            vo.setContent(content);
	            vo.setUserId(professorId);
	            vo.setFileName(fileName);
	            vo.setFilePath(currentDirPath + "/" + fileName); // DB에는 상대 경로 저장 추천
	            vo.setFileSize(fileSize);
	            
	            professorService.insertNoticeProfessor(vo);
	            
	            response.sendRedirect(request.getContextPath() + "/professor/noticeprofessor");
	            return;
			 } catch (Exception e) {
				 e.printStackTrace();
				 pw.println("<script>alert('등록 실패');history.back();</script>");
				 
			 }
		}
		// ✅ 공지사항 / 교수 공지사항 수정
		else if(action.equals("/noticeupdate.do")) {
			 PrintWriter pw = response.getWriter();
			 File currentDirPath = new File("c:\\file_repo");
			 DiskFileItemFactory factory = new DiskFileItemFactory();
			 factory.setSizeThreshold(1024*1024);
			 factory.setRepository(currentDirPath);
			 
			 ServletFileUpload upload = new ServletFileUpload(factory);
		        
			 int noticeId = 0;
			 String title = null;
		     String content = null;
	         String fileName = null;
	         String filePath = null;
	         long fileSize = 0;
	         
			 try {
				 List<FileItem> items = upload.parseRequest(request);  
				 for (FileItem item : items) {
					// 일반 입력 필드인지 확인 (true: text, textarea 등 / false: 파일)
			        if (item.isFormField()) {
			            // 일반 입력 필드 (title, content 등)
			            String fieldName = item.getFieldName(); // name 속성 (예: title, content)
			            String value = item.getString("UTF-8"); // 사용자가 입력한 값 (한글 깨짐 방지)

			            // 각각의 name에 따라 변수에 저장
			            if ("notice_id".equals(fieldName)) noticeId = Integer.parseInt(value);
			            if ("title".equals(fieldName)) title = value;
			            if ("content".equals(fieldName)) content = value;

			        } else {
			            // 파일명이 비어있지 않은지 확인 (파일이 실제로 업로드 되었는지 확인)
			            if (!item.getName().isEmpty()) {

			                // 업로드된 파일 이름만 추출 (경로 없이 순수 파일명만)
			                fileName = new File(item.getName()).getName(); 
			                // 예: 사용자가 "C:\Users\홍길동\sample.pdf" 업로드 → "sample.pdf"

			                // 서버에 저장할 전체 경로 구성 (예: C:/프로젝트경로/upload/sample.pdf)
			                filePath = currentDirPath + File.separator + fileName;

			                // 파일 크기 (byte) 저장
			                fileSize = item.getSize(); 
			                // 예: 153256 (바이트 단위)

			                // 파일을 실제 서버에 저장 (하드디스크에 write)
			                item.write(new File(filePath));

			            }
			        }
				 }
	            NoticeProfessorVo vo = new NoticeProfessorVo();
	            vo.setNoticeId(noticeId);
	            vo.setTitle(title);
	            vo.setContent(content);
	            vo.setFileName(fileName);
	            vo.setFilePath(currentDirPath + "/" + fileName); // DB에는 상대 경로 저장 추천
	            vo.setFileSize(fileSize);
	            
	            boolean result = professorService.updateNoticeProfessor(vo);
	            
				if (result) {
		            pw.println("<script>");
		            pw.println("alert('수정이 완료되었습니다.');");
		            pw.println("window.opener.location.reload();"); // 부모 창 새로고침
		            pw.println("window.close();");                 // 현재 창(팝업) 닫기
		            pw.println("</script>");
				} else {
		            pw.println("<script>");
		            pw.println("alert('수정이 실패했습니다.');");
		            pw.println("window.close();");                 // 현재 창(팝업) 닫기
		            pw.println("</script>");
				}
			 } catch (Exception e) {
				 e.printStackTrace();
				 pw.println("<script>alert('예기치 못한 오류가 발생했습니다.');window.close();</script>");
			 }
			 return;
		}
		// ✅ 공지사항 / 교수 공지사항 삭제
		else if(action.equals("/deletenotice.do")) {
			PrintWriter pw = response.getWriter();
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			String[] noticeIds = request.getParameterValues("noticeIds");
			boolean result = professorService.deleteProfessorNotice(noticeIds);
			
			if (result) {
				out.write("success");
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				out.write("fail");
			}
			out.flush();
			return;
		}
		// ✅ 공지사항 / 공지사항 내용 확인
		else if(action.equals("/noticedetail")) {
			String noticeId = request.getParameter("noticeId");
			System.out.println("noticeid : "+noticeId);
			
			NoticeProfessorVo notice = professorService.getNoticeById(noticeId);
			
			request.setAttribute("noticeVo", notice);
			
			nextPage = "/professors/NoticeDetail.jsp";
		}
		// ✅ 공지사항 / 파일 다운로드 처리
		else if (action.equals("/noticedownload.do")) {
		    String file_repo = "C:\\file_repo";
		    String fileName = request.getParameter("fileName");
		    String downFile = file_repo + "\\" + fileName;

		    File file = new File(downFile);
		    
		    if (!file.exists()) {
		        // 예외나 로그만 찍고 return; (절대 response.getWriter() 쓰지 말 것)
		        response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
		        return;
		    }

		    // 응답 헤더 설정
		    response.setContentType("application/octet-stream");
		    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		    response.setHeader("Pragma", "no-cache");
		    response.setHeader("Expires", "0");

		    String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

		    try (
		        FileInputStream in = new FileInputStream(file);
		        OutputStream out = response.getOutputStream();
		    ) {
		        byte[] buffer = new byte[8192];
		        int bytesRead;
		        while ((bytesRead = in.read(buffer)) != -1) {
		            out.write(buffer, 0, bytesRead);
		        }
		        out.flush();
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "파일 다운로드 중 오류 발생");
		    }

		    return;
		}

		// ✅ 질문,답변 / 강의 관련 질문 모아보기
		else if(action.equals("/qnalist")) {
			String professor_id = String.valueOf(session.getAttribute("id"));
			Vector<QnaStduentProfessorVo> qspvo = professorService.getAllQna(professor_id);
			Vector<LectureListVo> subjectVo = professorService.getAllLectureList2(professor_id);
			
			// qna 조회
			request.setAttribute("QnaList", qspvo);
			// 과목조회
			request.setAttribute("subjectList", subjectVo);
			request.setAttribute("center", "/professors/QnaStudentProfessor.jsp");
			
			nextPage = "/professors/ProfessorMain.jsp";
		}
		// ✅ 질문,답변 / 특정 질문글 보기
		else if(action.equals("/qnadetail")) {
			int qnaId = Integer.parseInt(request.getParameter("qnaId"));
			
			QnaWithReplyVo qrv = professorService.getQnaWithReply(qnaId);
			
			// qna 조회
			request.setAttribute("qrv", qrv);
			
			nextPage = "/professors/Qna.jsp";
		}
		// ✅ 질문,답변 / 교수가 학생 질문 삭제
		else if (action.equals("/deleteqna")) {
			PrintWriter pw = response.getWriter();
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			String[] qnaIds = request.getParameterValues("qnaIds");
			boolean result = professorService.deleteStudentQna(qnaIds);
			
			if (result) {
				out.write("success");
			} else {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				out.write("fail");
			}
			out.flush();
			return;
		}
		// ✅ 질문,답변 / 교수 답변 등록
		else if (action.equals("/qnaprofessor/append.do")) {
			PrintWriter pw = response.getWriter();
		    BufferedReader reader = request.getReader();
		    Gson gson = new Gson();
		    ReplyProfessorVo vo = gson.fromJson(reader, ReplyProfessorVo.class);

		    String professor_id = String.valueOf(session.getAttribute("id"));
		    
		    boolean result = professorService.insertReply(vo, professor_id);

		    response.setContentType("application/json;charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.print("{\"success\": " + result + ", \"message\": \"" + (result ? "등록 완료" : "등록 실패") + "\"}");
		    return;
		}
		// ✅ 질문,답변 / 교수 답변 수정
		else if (action.equals("/qnaprofessor/update.do")) {
			PrintWriter pw = response.getWriter();
		    BufferedReader reader = request.getReader();
		    Gson gson = new Gson();
		    ReplyProfessorVo vo = gson.fromJson(reader, ReplyProfessorVo.class);

		    boolean result = professorService.updateReply(vo);

		    response.setContentType("application/json;charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.print("{\"success\": " + result + ", \"message\": \"" + (result ? "수정 완료" : "수정 실패") + "\"}");
		    return;
		}
		// ✅ 질문,답변 / 교수 답변 추가 삭제
		else if (action.equals("/qnaprofessor/delete.do")) {
			PrintWriter pw = response.getWriter();
		    BufferedReader reader = request.getReader();
		    JsonObject obj = JsonParser.parseReader(reader).getAsJsonObject();
		    int qnaId = obj.get("qnaId").getAsInt();

		    boolean result = professorService.deleteReply(qnaId);

		    response.setContentType("application/json;charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.print("{\"success\": " + result + ", \"message\": \"" + (result ? "삭제 완료" : "삭제 실패") + "\"}");
		    return;
		}
		
		System.out.println("nextpage 값 : " + nextPage);
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
		
	}
}
