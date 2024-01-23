<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title></title>
        <style> 
            .menuBarContent { padding-top: 10%; width: 20%; text-align: center; }
            /*
            .menuBarContent ul { border: 1px solid #00BCD4; border-radius: 20px; }
            .menuBarContent a { text-decoration: none; color: #00BCD4; }
            .menuBarContent a:hover { color: olive; font-size: 20px; }
            */

            nav{ float: none; clear: both; margin: 10% auto; background: #eee; border: 3px solid #00BCD4; border-left: none; border-radius: 20px; }
            nav ul { list-style: none; margin: 0px; padding: 0px; }
            nav li{ float: none; width: 100%; }
            nav li a{
                display: block; 
                width: 100%; 
                padding: 20px; 
                border-left: 5px solid; 
                position: relative; 
                z-index: 2;
                text-decoration: none;
                text-underline-offset: none;
                color: #444;
                box-sizing: border-box;  
                -moz-box-sizing: border-box;  
                -webkit-box-sizing: border-box; 
            }
            nav li a:hover{ border-bottom: 0px; color: #fff;}
            nav li:first-child a{ border-left: 10px solid #3498db; }
            nav li:nth-child(2) a{ border-left: 10px solid #ffd071; }
            nav li:nth-child(3) a{ border-left: 10px solid #f0776c; }
            nav li:nth-child(4) a{ border-left: 10px solid #00BCD4; }
            nav li:last-child a{ border-left: 10px solid #1abc9c; }
            nav li a:after { 
                content: "";
                height: 100%; 
                left: 0; 
                top: 0; 
                width: 0px;  
                position: absolute; 
                transition: all 0.3s ease 0s; 
                -webkit-transition: all 0.3s ease 0s; 
                z-index: -1;
            }
            nav li a:hover:after{ width: 95%; }
            nav li:first-child a:after{ background: #3498db; }
            nav li:nth-child(2) a:after{ background: #ffd071; }
            nav li:nth-child(3) a:after{ background: #f0776c; }
            nav li:nth-child(4) a:after{ background: #00BCD4; }
            nav li:last-child a:after{ background: #1abc9c; }
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 100;
                src: local('Lato Hairline'), local('Lato-Hairline'), url(http://themes.googleusercontent.com/static/fonts/lato/v6/boeCNmOCCh-EWFLSfVffDg.woff) format('woff');
            }
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 300;
                src: local('Lato Light'), local('Lato-Light'), url(http://themes.googleusercontent.com/static/fonts/lato/v6/KT3KS9Aol4WfR6Vas8kNcg.woff) format('woff');
            }
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 400;
                src: local('Lato Regular'), local('Lato-Regular'), url(http://themes.googleusercontent.com/static/fonts/lato/v6/9k-RPmcnxYEPm8CNFsH2gg.woff) format('woff');
            }
            @font-face {
                font-family: 'Lato';
                font-style: normal;
                font-weight: 700;
                src: local('Lato Bold'), local('Lato-Bold'), url(http://themes.googleusercontent.com/static/fonts/lato/v6/wkfQbvfT_02e2IWO3yYueQ.woff) format('woff');
            }
        </style>
    </head>
    <body>
        <div class="menuBarContent">
            <nav>
                <ul>
                    <li><a href="myPage.cp">회사 배너</a></li>
                    <li><a href="myPageInfo.cp">회사 정보</a></li>
                    <li><a href="updateForm.cp">정보 수정</a></li>
                    <li><a href="deleteForm.cp">회원 탈퇴</a></li>
                    <li><a href="myPage.hb">내가 작성한 모집공고</a></li>
                </ul>
            </nav>
        </div>
    </body>
</html>