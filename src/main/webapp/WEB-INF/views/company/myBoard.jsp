<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>${sessionScope.loginCompany.companyName}가 작성한 취업공고</title>
	<style>
		.tableArea { width: 100%; margin-left: 10px; }

		/* 테이블 css */
		.table_a { border-collapse: separate; border-spacing: 0; width: 100%; color: #666; font: 14px/24px "Open Sans", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", Sans-Serif; text-align: center; }
		.th_a, .td_a { padding: 6px 15px; }
		.th_a { background: #42444e; color: #fff; }
		.tr_a:first-child .th_a:first-child { border-top-left-radius: 6px; }
		.tr_a:first-child .th_a:last-child { border-top-right-radius: 6px; }
		.td_a { border-right: 1px solid #c6c9cc; border-bottom: 1px solid #c6c9cc; }
		.td_a:first-child { border-left: 1px solid #c6c9cc; }
		.tr_a:nth-child(even) .td_a { background: #eaeaed; }
		.tr_a:last-child .td_a:first-child { border-bottom-left-radius: 6px; }
		.tr_a:last-child .td_a:last-child { border-bottom-right-radius: 6px; }

		/* 태그 스타일 */
		.tagList { border: 1px solid grey; border-radius: 8px; margin: 3px; padding: 3px; display: inline-flex; }
        .tagList:before { content: '#'; }
        .tagList:hover { transform: scale(1.24); background-color: black; color: white; }

		/* 인엽이 페이지 네이션 맞추기 */
		.pageForm { width: fit-content; margin: auto; padding-top: 40px; }
        .page-link:hover { cursor: pointer; }
	</style>
	</head>
	<body>
		<jsp:include page="../common/header.jsp" />
		<div class="content">
			<div style="display: flex;">
                <jsp:include page="./companyMenuBar.jsp" />
				<div style="width: 80%;">
					<div class="tableArea">
						<table class="table_a">
							<colgroup>
								<col width="5%"/>
								<col width="30%"/>
								<col width="5%"/>
								<col width="10%"/>
								<col width="10%"/>
								<col width="10%"/>
								<col width="15%"/>
								<col width="15%"/>
							</colgroup>
							<thead>
								<tr class="tr_a">
									<th class="th_a">글번호</th>
									<th class="th_a">제목</th>
									<th class="th_a">조회수</th>
									<th class="th_a">작성일</th>
									<th class="th_a">채용시작</th>
									<th class="th_a">채용마감</th>
									<th class="th_a">장소</th>
									<th class="th_a">태그</th>
								</tr>							
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${ empty requestScope.list }">
										<tr>
											<td class="td_a" colspan="8">글이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="b" items="${requestScope.list}" varStatus="status">
											<tr>
												<td class="td_a">${b.hboardNo}</td>
												<td class="td_a">${b.hboardTitle}</td>
												<td class="td_a">${b.hboardViews}</td>
												<td class="td_a">${b.hboardInsert}</td>						
												<td class="td_a">${b.hboardStart}</td>
												<td class="td_a">${b.hboardEnd}</td>
												<td class="td_a">${b.hboardLocation}</td>
												<td class="td_a">${requestScope.tg_list[status.index]}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<div class="pageForm">
                        <ul class="pagination" style="margin: auto;">
                            <c:if test="${ requestScope.pi.maxPage ne 0 }">
                                <c:choose>
                                    <c:when test="${ requestScope.pi.currentPage eq 1 }">
                                        <li class="page-item disabled">
                                            <a class="page-link">Previous</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" onclick="location.href='myPage.hb?cpage=${requestScope.pi.currentPage - 1}'">Previous</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>  
                                <c:forEach var="p" begin="${requestScope.pi.startPage}" end="${requestScope.pi.endPage}" step="1">
                                    <c:choose>
                                        <c:when test="${ p eq requestScope.pi.currentPage }">
                                            <li class="page-item disabled">
                                                <a class="page-link">${p}</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" onclick="location.href='myPage.hb?cpage=${p}'">${p}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>  
                                <c:choose>
                                    <c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
                                        <li class="page-item disabled">
                                            <a class="page-link">Next</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" onclick="location.href='myPage.hb?cpage=${requestScope.pi.currentPage + 1}'">Next</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </ul>
                    </div>
				</div>
            </div>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</body>
</html>