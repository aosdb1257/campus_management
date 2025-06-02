<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학사 일정</title>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
<style>
    #calendar {
        height: 600px;
        background-color: white;
        border: 1px solid #ddd;
        padding: 20px;
        border-radius: 10px;
    }
    .calendar-wrapper {
        display: flex;
        gap: 20px;
    }
    .calendar-right {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
    }
    .addSchedulebtn {
        background-color: rgb(44, 62, 80);
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        border: none;
    }
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        background-color: rgba(0,0,0,0.5);
        top: 0; left: 0; width: 100%; height: 100%;
    }
    .modal-content {
        background: white;
        width: 450px;
        margin: 100px auto;
        padding: 20px;
        border-radius: 10px;
    }
</style>
</head>
<body>
<div class="container mt-4 calendar-wrapper">
    <div style="flex: 1;">
        <div id="calendar"></div>
    </div>
    <div class="calendar-right">
        <button class="addSchedulebtn" onclick="openAddModal()">학사일정 추가</button>
    </div>
</div>

<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

<script>
let currentEvent = null;
let calendar = null;

function openAddModal() {
    document.getElementById('addModal').style.display = 'block';
}
function closeAddModal() {
    document.getElementById('addModal').style.display = 'none';
}
function closeDetailModal() {
    document.getElementById('eventModal').style.display = 'none';
}


document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        events: function(info, successCallback, failureCallback) {
            fetch('${contextPath}/campus/calendarEvent')
                .then(res => res.json())
                .then(data => successCallback(data))
                .catch(err => failureCallback(err));
        },
        eventClick: function(info) {
            currentEvent = info.event;

            document.getElementById('detailTitle').value = currentEvent.title;
            document.getElementById('detailDesc').value = currentEvent.extendedProps.description || '';
            document.getElementById('detailTitle').disabled = true;
            document.getElementById('detailDesc').disabled = true;
                    
            const today = new Date();
            today.setHours(0,0,0,0);

            const start = new Date(currentEvent.start);
            const end = new Date(currentEvent.end || currentEvent.start);

            start.setHours(0,0,0,0);
            end.setHours(0,0,0,0);

            // ⭐⭐ 상태 계산
            let statusText = '';
            if (today < start) {
                statusText = '예정';
            } else if (today > end) {
                statusText = '종료';
            } else {
                statusText = '진행중';
            }
            document.getElementById('eventStatus').innerText = '상태 : ' + statusText;

         	// ⭐⭐ 기간 표시		
			const periodStart = currentEvent.start;
			const periodEnd = currentEvent.end;
			
			// ⭐ end -1 day (FullCalendar workaround 보정)
			// FullCalendar는 종료일을 포함하지 않기 때문에, 종료일을 하루 전으로 설정해서 일정 표시
			if (periodEnd) {
			    periodEnd.setDate(periodEnd.getDate() - 1);
			}
			
			const startText = periodStart ? periodStart.toLocaleDateString('ko-KR') : '';
			const endText = periodEnd ? periodEnd.toLocaleDateString('ko-KR') : '';
			
			if (endText === null || endText === '') {
                document.getElementById('detailPeriod').innerText = startText;
			}else{
				document.getElementById('detailPeriod').innerText = startText + ' ~ ' + endText;
			}
		    	
            // ⭐⭐ 모달에 상태 표시 ⭐⭐
            document.getElementById('eventStatus').innerText = '상태 : ' + statusText;
            
            document.getElementById('editBtn').style.display = 'inline-block';
            document.getElementById('saveBtn').style.display = 'none';

            document.getElementById('eventModal').style.display = 'block';
        }
    });
    calendar.render();

    // 일정 추가
    document.getElementById('addScheduleForm').addEventListener('submit', function (e) {
        e.preventDefault();
        
        const startDate = new Date(document.getElementById('newStart').value);
        const endDate = new Date(document.getElementById('newEnd').value || document.getElementById('newStart').value);

        // 시작일이 종료일보다 나중인 경우
        if (startDate > endDate) {
            alert("종료일은 시작일보다 빠를 수 없습니다.");
            return;
        }
        
        fetch('${contextPath}/admin/addEvent', {
        	  method: 'POST',
        	  headers: {
        	    'Content-Type': 'application/x-www-form-urlencoded'
        	  },
        	  body: new URLSearchParams({
        	    title: document.getElementById('newTitle').value,
        	    description: document.getElementById('newDesc').value,
        	    start: document.getElementById('newStart').value,
        	    end: document.getElementById('newEnd').value || document.getElementById('newStart').value,
        	    color: document.getElementById('newColor').value,
        	    admin_id: ${vo.id} // 세션에서 받아온 admin_id (예: ${vo.id})
        	  })
        	})
        	.then(res => res.json())
        	.then(result => {
        	  if (result.success) {
        	    alert("일정이 등록되었습니다.");
        	    closeAddModal();
        	    calendar.refetchEvents();
        	  } else {
        	    alert("등록 실패!");
        	  }
        	});
});

    // 수정 모드 진입
    document.getElementById('editBtn').addEventListener('click', function () {
        document.getElementById('detailTitle').disabled = false;
        document.getElementById('detailDesc').disabled = false;
        document.getElementById('editBtn').style.display = 'none';
        document.getElementById('saveBtn').style.display = 'inline-block';
    });

    // 수정 완료
	document.getElementById('saveBtn').addEventListener('click', function () {
	    const newTitle = document.getElementById('detailTitle').value;
	    const newDesc = document.getElementById('detailDesc').value;
	
	    fetch('${contextPath}/admin/updateEvent', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded'
	        },
	        body: new URLSearchParams({
	            id: currentEvent.id,
	            title: newTitle,
	            description: newDesc
	        })
	    }).then(res => res.json())
	      .then(result => {
	          if (result.success) {
	              currentEvent.setProp('title', newTitle);
	              currentEvent.setExtendedProp('description', newDesc);
	              closeDetailModal();
	          } else {
	              alert("수정 실패!");
	          }
	      });
	});

    // 삭제
	document.getElementById('deleteBtn').addEventListener('click', function () {
	    if (confirm("정말 삭제할까요?")) {
	        fetch('${contextPath}/admin/deleteEvent', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded'
	            },
	            body: new URLSearchParams({
	                id: currentEvent.id
	            })
	        }).then(res => res.json())
	          .then(result => {
	              if (result.success) {
	                  currentEvent.remove();
	                  closeDetailModal();
	              } else {
	                  alert("삭제 실패!");
	              }
	          });
	    }
	});
});
</script>

<!-- 일정 추가 모달 -->
<div class="modal" id="addModal">
  <div class="modal-content">
    <h4>학사일정 등록</h4>
    <form id="addScheduleForm">
      <label>제목</label>
      <input type="text" id="newTitle" class="form-control mb-2" required>

      <label>내용</label>
      <textarea id="newDesc" class="form-control mb-2" rows="3" required></textarea>

      <label>시작일</label>
      <input type="date" id="newStart" class="form-control mb-2" required>

      <label>종료일</label>
      <input type="date" id="newEnd" class="form-control mb-2">

      <label>색상</label>
      <input type="color" id="newColor" class="form-control mb-2" value="#3788d8">

      <div class="d-flex justify-content-end gap-2 mt-3">
        <button type="submit" class="btn btn-success">등록</button>
        <button type="button" class="btn btn-secondary" onclick="closeAddModal()">취소</button>
      </div>
    </form>
  </div>
</div>

<!-- 일정 상세 모달 -->
<div class="modal" id="eventModal">
  <div class="modal-content">
    <h4>일정 상세보기</h4>
    
    <label>기간</label>
    <div id="detailPeriod" style="border: 1px solid #ccc; padding: 5px; border-radius: 5px;"></div>

    
    <label>제목</label>
    <input type="text" id="detailTitle" class="form-control mb-2" disabled>
    
    <label>내용</label>
    <textarea id="detailDesc" class="form-control mb-2" rows="3" disabled></textarea>
    
    <!-- ⭐⭐ 상태 표시 ⭐⭐ -->
    <div id="eventStatus" class="mb-2"></div>

    <div class="d-flex justify-content-end gap-2 mt-3">
      <button id="editBtn" class="btn btn-warning">수정</button>
      <button id="saveBtn" class="btn btn-success" style="display:none;">수정 완료</button>
      <button id="deleteBtn" class="btn btn-danger">삭제</button>
      <button type="button" class="btn btn-secondary" onclick="closeDetailModal()">닫기</button>
    </div>
  </div>
</div>
</body>
</html>
