<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>취업 공고 게시판</title>
        <style>
            .outerForm { width: 100%; height: 100%; padding-top: 3%; padding-bottom: 3%; }
            .searchForm { width: 100%; height: 15%; padding: 3%; background: linear-gradient(white, rgb(181, 211, 250)); color: black; }
            .searchForm1 { width: 100%; height: 100%; border-radius: 20px; color: black; }
            .searchForm1 div { width: 100%; border-radius: 20px; }
            .searchForm2 { width: 100%; height: 0%; border-radius: 12px; border: 2.2px solid khaki; }
            .hboardMain { width: 100%; height: 70%; padding: 3%; }
            .recommendForm { width: 100%; height: 15%; padding: 3%; }
            #hboardSort { width: 200px; text-align: center; }
            #hboardCareer { width: 100%; height: 50px; text-align: center; border: none; font-size: 20px; background: inherit; color: inherit; }
            #hboardEducation { width: 100%; height: 50px; text-align: center; border: none; font-size: 20px; background: inherit; color: inherit; }
            #hboardLocation { width: 100%; height: 50px; text-align: center; border: none; font-size: 20px; background: inherit; color: inherit; }

            /* 태그 개인 설정 */
            tags { width: 100%; color: darkgoldenrod; }
            .tags-look .tagify__dropdown__item {
                display: inline-block; border-radius: 3px; padding: .3em .5em; border: 1px solid #CCC;
                background: #F3F3F3; margin: .2em; font-size: .85em; color: black; transition: 0s;
            }
            .tags-look .tagify__dropdown__item--active { color: black; }
            .tags-look .tagify__dropdown__item:hover { background: lightyellow; border-color: gold; }
            .tagify__tag { background-color: inherit; }
            .pageForm { width: 100%; height: 15%; }

            /* 카드 css */
            .card { width: 250px; height: 540px; background: white; padding: .4em; border-radius: 6px; margin: 15px; margin-bottom: 20px; }
            .card-image { background-color: rgb(236, 236, 236); width: 100%; height: 130px; border-radius: 6px 6px 0 0; text-align: center; line-height:130px; }
            .card-image:hover { cursor: pointer; transform: scale(0.98); }
            .location { text-transform: uppercase; font-size: 0.7em; font-weight: 600; color: #5271FF; padding: 10px 7px 0; width: 50%; }
            .location:hover { cursor: pointer; transform: scale(1.12); background-color: #5271FF; color: whitesmoke; }
            .heading { font-weight: 600; color: rgb(88, 87, 87); padding: 7px; }
            .heading h5:hover { cursor: pointer; }
            .info { color: gray; font-weight: 400; font-size: 11px; padding-top: 20px; width: 90%; display: flex; }
            .name { font-weight: 600; }
            .card:hover { border: 1px ridge white; box-shadow: 5px 5px 5px 5px #6E9DDC; }
            .card-list{ width: 100%; margin-top: 50px; border-top: 1px solid lightgray; display: flex; flex-wrap: wrap; }
            .footing { height: 120px; width: 100%; word-break: break-all; }
            .tagList { border: 1px solid grey; border-radius: 8px; margin: 3px; padding: 3px; display: inline-flex; }
            .tagList:before { content: '#'; }
            .tagList:hover { cursor: pointer; transform: scale(1.24); background-color: black; color: white; }
            .tagListNo { border: 1px solid grey; border-radius: 8px; margin: 3px; padding: 3px; display: inline-flex; }
            .tagListNo:before { content: '#'; }
            /* .tagListNo:hover { transform: scale(1.24); } */

            /* 좋아요 */
            .container input { position: absolute; opacity: 0; cursor: pointer; height: 0; width: 0; }
            .container { display: inline-block; position: relative; cursor: pointer; font-size: 12px; user-select: none; transition: 100ms; padding-bottom: 10px; }
            .checkmark { top: 0; left: 0; height: 2em; width: 2em; transition: 100ms; animation: dislike_effect 400ms ease; }
            .container input:checked ~ .checkmark path { fill: #FF5353; stroke-width: 0; }
            .container input:checked ~ .checkmark { animation: like_effect 400ms ease; }
            .container:hover { transform: scale(1.1); }
            @keyframes like_effect { 0% { transform: scale(0); } 50% { transform: scale(1.2); } 100% { transform: scale(1); } }
            @keyframes dislike_effect { 0% { transform: scale(0); } 50% { transform: scale(1.2); } 100% { transform: scale(1); } }

            /* 인엽이 페이지 네이션 맞추기 */
            .pageForm { width: fit-content; margin: auto; padding-top: 40px; }
            .page-link:hover { cursor: pointer; }

            /* 인엽이 툴팁 */
            .text { color: #5271FF; font-size: 14px; }
            .tooltip-container { position: relative; display: inline-block; margin-left: 10px; }
            .tooltip {
                position: absolute; top: 100%; left: 50%; transform: translateX(-50%); opacity: 0; visibility: hidden;
                background: white; color: black; padding: 10px; border-radius: 4px; transition: opacity 0.3s, visibility 0.3s, top 0.3s, background 0.3s;
                z-index: 1; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
            .tooltip::before { content: ""; position: absolute; bottom: 100%; left: 50%; border-width: 8px; border-style: solid; border-color: transparent transparent #5271FF transparent; transform: translateX(-50%); }
            .tooltip-container:hover .tooltip { top: 120%; opacity: 1; visibility: visible; background: white; transform: translate(-50%, -5px); }
        </style>
    </head>
    <body>
        <jsp:include page="../../common/header.jsp" />
        <div class="content">
            <div class="outerForm">
                <div class="searchForm">
                    <div class="searchForm1">
                        <div style="width: 100%; height: 40%; margin: auto; display: flex; border: 2px solid silver; padding: 1%;">
                            <div style="width: 33%; height: 100%; display: flex;">
                                <h5 style="width: 40%; margin: auto;" align="center">경력 구분</h5>
                                <div style="width: 60%; margin: auto;">
                                    <select name="hboardCareer" id="hboardCareer" size="">
                                        <option value="none" selected>경력무관</option>
                                        <option value="intern">인턴</option>
                                        <option value="newcomer">신입</option>
                                        <option value="junior">주니어</option>
                                        <option value="middle">미들</option>
                                        <option value="senior">시니어</option>
                                    </select>
                                </div>
                            </div>
                            <div style="width: 33%; height: 100%; display: flex;">
                                <h5 style="width: 40%; margin: auto;" align="center">학력 구분</h5>
                                <div style="width: 60%; margin: auto;">
                                    <select name="hboardEducation" id="hboardEducation" size="">
                                        <option value="none" selected>학력무관</option>
                                        <option value="highSchool">고등학교 졸업</option>
                                        <option value="juniorCollege">전문대학 졸업</option>
                                        <option value="university">대학 졸업</option>
                                        <option value="master">석사 이상</option>
                                        <option value="doctor">박사 이상</option>
                                        <option value="professor">교수 및 연구원</option>
                                    </select>
                                </div>
                            </div>
                            <div style="width: 33%; height: 100%; display: flex;">
                                <h5 style="width: 40%; margin: auto;" align="center">지역 구분</h5>
                                <div style="width: 60%; margin: auto;">
                                    <select name="hboardLocation" id="hboardLocation" size="">
                                        <option value="all" selected>전체지역</option>
                                        <option value="서울특별시">서울특별시</option>
                                        <option value="경기도">경기도</option>
                                        <option value="인천광역시">인천광역시</option>
                                        <option value="강원도">강원도</option>
                                        <option value="충청북도">충청북도</option>
                                        <option value="세종시">세종시</option>
                                        <option value="충청남도">충청남도</option>
                                        <option value="대전광역시">대전광역시</option>
                                        <option value="경상북도">경상북도</option>
                                        <option value="대구광역시">대구광역시</option>
                                        <option value="울산광역시">울산광역시</option>
                                        <option value="부산광역시">부산광역시</option>
                                        <option value="경상남도">경상남도</option>
                                        <option value="전라북도">전라북도</option>
                                        <option value="전라남도">전라남도</option>
                                        <option value="광주광역시">광주광역시</option>
                                        <option value="제주도">제주도</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div style="width: 100%; height: 60%; display: flex; border: 2px solid silver; padding: 1%;">
                            <h5 style="width: 10%; margin: auto;" align="center">#태그</h5>
                            <div style="width: 90%; margin: auto;">
                                <jsp:include page="../../common/tagAll.jsp" />
                            </div>
                        </div>
                    </div><br>
                    <div class="searchForm2">
                    </div>
                </div>
                <div class="hboardMain">
                    <div style="width: 100%; height: 10%;">
                        <div style="float: right; display: flex; margin-top: 2%; margin-bottom: 2%;">
                            <select name="hboardSort" id="hboardSort">
                                <option value="new" selected>최신순</option>
                                <option value="old">마감순</option>
                                <option value="view">조회순</option>
                                <option value="salary">연봉순</option>
                            </select>
                            &nbsp;
                            <input type="search" class="form-control form-control-lg" id="hboardSearch" name="keyword">
                            &nbsp;&nbsp;
                            <span onclick="onSearch(1);" style="height: 100%;"><svg xmlns="http://www.w3.org/2000/svg" height="3em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M416 208c0 45.9-14.9 88.3-40 122.7L502.6 457.4c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L330.7 376c-34.4 25.2-76.8 40-122.7 40C93.1 416 0 322.9 0 208S93.1 0 208 0S416 93.1 416 208zM208 352a144 144 0 1 0 0-288 144 144 0 1 0 0 288z"/></svg></span>
                        </div>
                    </div>
                    <div style="width: 100%; height: 5%; display: flex;">
                        <div style="width: 50%;">
                            <label for="viewOn" class="form-check-label"><input type="checkbox" class="form-check-input" name="viewOn" id="viewOn">&nbsp;모집중인 공고만 보기</label>
                        </div>
                        <c:choose>
                            <c:when test="${not empty sessionScope.loginCompany}">
                                <div style="width: 50%;"><a href="insertForm.hb" style="text-decoration: none; color: inherit; border: 3px solod sandybrown; float: right;">모집 공고 작성하기</a></div>
                            </c:when>
                        </c:choose>
                    </div>
                    <div style="width: 100%; height: 70%;">
                        <div class="content_2">
                            <div class="card-list">
                                <c:forEach var="b" items="${requestScope.list}" varStatus="status">
                                    <div class="card">
                                        <div class="card-image" onclick="location.href='boardDetail.hb?hno=${b.hboardNo}'">
                                            <img src="${requestScope.at_list[status.index].hattachmentPath}/${requestScope.at_list[status.index].hattachmentChange}" width="80%" height="80%" style="vertical-align:middle;" onerror="this.src='resources/image/white.jpg'">
                                        </div>
                                        <div class="location" onclick="onSearchAddWhere('${b.hboardLocation}')">${b.hboardLocation}</div>
                                        <div class="heading">   
                                            <h5 onclick="location.href='boardDetail.hb?hno=${b.hboardNo}'">${b.hboardTitle}</h5>
                                            <div class="company">${b.companyNo}</div>
                                            <div style="display: flex; width: 100%;">
                                                <div class="info">
                                                    <i class="fas fa-eye" style="line-height: 18px;"></i><p style="color: indianred; font-weight: bold; font-size: 12px;">조회수&nbsp;${b.hboardViews}</p>
                                                </div>
                                                <c:if test="${not empty sessionScope.loginMember}">
                                                    <c:choose>
                                                        <c:when test="${requestScope.ws_list[status.index]}">
                                                            <label class="container">찜하기
                                                                <input type="checkbox" checked="checked" name="favorite" onclick="onWish('${b.hboardNo}');">
                                                                <div class="checkmark">
                                                                    <svg viewBox="0 0 256 256">
                                                                    <rect fill="none" height="512" width="512"></rect>
                                                                    <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                                                                </div>
                                                            </label>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <label class="container">찜하기
                                                                <input type="checkbox" name="favorite" onclick="onWish('${b.hboardNo}');">
                                                                <div class="checkmark">
                                                                    <svg viewBox="0 0 256 256">
                                                                    <rect fill="none" height="512" width="512"></rect>
                                                                    <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                                                                </div>
                                                            </label>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </div>
                                            <div style="display: flex; width: 100%;">
                                                <p style="color: #6E9DDC; font-weight: bold; font-size: 12px;">
                                                    <c:if test="${b.hboardEducation eq 'none'}"> 학력무관 </c:if> <c:if test="${b.hboardEducation eq 'highSchool'}"> 고등학교 졸업 </c:if> <c:if test="${b.hboardEducation eq 'juniorCollege'}"> 전문대학 졸업 </c:if> <c:if test="${b.hboardEducation eq 'university'}"> 대학 졸업 </c:if> <c:if test="${b.hboardEducation eq 'master'}"> 석사 이상 </c:if> <c:if test="${b.hboardEducation eq 'doctor'}"> 박사 이상 </c:if> <c:if test="${b.hboardEducation eq 'professor'}"> 교수 및 연구원 </c:if>
                                                </p><p style="color: gray; font-weight: bold; font-size: 12px;">&nbsp;||&nbsp;</p><p style="color: sandybrown; font-weight: bold; font-size: 12px;">
                                                    <c:if test="${b.hboardCareer eq 'none'}"> 경력무관 </c:if> <c:if test="${b.hboardCareer eq 'intern'}"> 인턴 </c:if> <c:if test="${b.hboardCareer eq 'newcomer'}"> 신입 </c:if> <c:if test="${b.hboardCareer eq 'junior'}"> 주니어 </c:if> <c:if test="${b.hboardCareer eq 'middle'}"> 미들 </c:if> <c:if test="${b.hboardCareer eq 'senior'}"> 시니어 </c:if>
                                                </p>
                                            </div>
                                            <div style="display: flex; width: 100%;">
                                                <div style="width: 45%;">${b.hboardStart}</div>
                                                <div style="width: 10%;">&nbsp;~&nbsp;</div>
                                                <div style="width: 45%;">${b.hboardEnd}</div>
                                            </div>
                                        </div> 
                                        <div class="footing">
                                            <c:if test="${ empty requestScope.tg_list[status.index]}">
                                                <span class="tagListNo">태그없음</span>
                                            </c:if>
                                            <c:forEach var="tg" items="${requestScope.tg_list[status.index]}" begin="0" end="4">
                                                <span class="tagList" onclick="onSearchAddTag('${tg.tagsNo}')">${tg.tagsNo}</span>
                                            </c:forEach>
                                            <div class="tooltip-container">
                                                <c:if test="${fn:length(requestScope.tg_list[status.index]) gt 5 }">
                                                    <span class="text">그리고 ${fn:length(requestScope.tg_list[status.index])-5}개의 태그</span>
                                                    <span class="tooltip">
                                                        <c:forEach var="tg" items="${requestScope.tg_list[status.index]}" begin="5" end="${fn:length(requestScope.tg_list[status.index])}">
                                                            <span class="tagList" onclick="onSearchAddTag('${tg.tagsNo}')">${tg.tagsNo}</span>
                                                        </c:forEach>
                                                    </span>
                                                </c:if>
                                            </div>
                                        </div>                         
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
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
                                            <a class="page-link" onclick="onSearch('${requestScope.pi.currentPage - 1}');">Previous</a>
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
                                                <a class="page-link" onclick="onSearch('${p}');">${p}</a>
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
                                            <a class="page-link" onclick="onSearch('${requestScope.pi.currentPage + 1}');">Next</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </ul>
                    </div>
                </div>
                <div class="recommendForm">

                </div>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                $("#hboardSearch").val(getParameter("search"));
                $("#hboardSort").val(getParameter("sort"));
                $("#hboardCareer").val(getParameter("career"));
                $("#hboardEducation").val(getParameter("education"));
                $("#hboardLocation").val(getParameter("where"));
                if(getParameter("viewOn") == 't') { $("#viewOn").attr("checked", true); }
                tagifyAll.addTags(getParameter("tag"));
            })
            function onWish(e) {
                $.ajax({
						url: "boardWish.hb",
	    				type: "get",
						data: {hboardNo: e},
						success: function(result) { console.log(result); },
						error: function() { console.log("찜하기 실패"); }
				});
            }
            function onSearch(cp) {
                let cpage = cp;
                let search = $("#hboardSearch").val();
                let sort = $("#hboardSort").val();
                let career = $("#hboardCareer").val();
                let education = $("#hboardEducation").val();
                let tag = $("#tagAllName").val();
                let where = $("#hboardLocation").val();
                let viewOn = 'f';
                if($("#viewOn").is(":checked") == true) { viewOn = 't'; }
                tag = replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(tag, "[", ""), "]", ""), "{", ""), "}", ""), "\"value\":", ""), "\"", "");
                location.href='listView.hb?cpage='+cpage+'&search='+search+'&sort='+sort+'&career='+career+'&education='+education+'&tag='+tag+'&where='+where+'&viewOn='+viewOn;
            }
            function getParameter(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }
            function replaceAll(str, searchStr, replaceStr) { return str.split(searchStr).join(replaceStr); }
            function onSearchAddTag(tagName) {
                let tagList = getParameter("tag").split(",");
                if(tagList.indexOf(tagName) > -1) { }
                else { location.href='listView.hb?cpage='+getParameter("cpage")+'&search='+getParameter("search")+'&sort='+getParameter("sort")+'&career='+getParameter("career")+'&education='+getParameter("education")+'&tag='+getParameter("tag")+','+tagName+'&where='+getParameter("where")+'&viewOn='+getParameter("viewOn"); }
            }
            function onSearchAddWhere(whereName) { location.href='listView.hb?cpage='+getParameter("cpage")+'&search='+getParameter("search")+'&sort='+getParameter("sort")+'&career='+getParameter("career")+'&education='+getParameter("education")+'&tag='+getParameter("tag")+'&where='+whereName+'&viewOn='+getParameter("viewOn"); }
        </script>
        <jsp:include page="../../common/footer.jsp" />
    </body>
</html>