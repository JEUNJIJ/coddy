<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About ${sessionScope.loginCompany.companyName}...</title>
    </head>
    <body>
        <jsp:include page="../common/header.jsp" />
		<div class="content">
			<div style="display: flex;">
                <jsp:include page="./companyMenuBar.jsp" />
                <div style="display: flex; float: left; padding-left: 40px;">
                    <jsp:include page="./companyProfileCard.jsp" />
                    &nbsp;
                    <div class="profile-widget" style="width: 500px;">
                        <h1 align="center">Profile</h1>
                        <table align="center" style="width: 100%;">
                            <thead>

                            </thead>
                            <tbody>
                                <tr>
                                    <th>Name</th>
                                    <td>${sessionScope.loginCompany.companyName}</td>
                                    <th>Owner</th>
                                    <td>${sessionScope.loginCompany.companyOwner}</td>
                                </tr>
                                <tr>
                                    <th>ID</th>
                                    <td>${sessionScope.loginCompany.companyId}</td>
                                    <th>Email</th>
                                    <td>${sessionScope.loginCompany.companyEmail}</td>
                                </tr>
                                <tr>
                                    <th>BNO</th>
                                    <td>${sessionScope.loginCompany.companyBno}</td>
                                    <th>JOIN</th>
                                    <td>${sessionScope.loginCompany.companyInsert}</td>
                                </tr>
                                <tr>
                                    <th>Worker</th>
                                    <td>${sessionScope.loginCompany.companyWorker}</td>
                                    <th>Salary</th>
                                    <td>${sessionScope.loginCompany.companySalary}</td>
                                </tr>
                                <tr>
                                    <th rowspan="10">Info</th>
                                    <td colspan="3" rowspan="10">${sessionScope.loginCompany.companyInfo}</td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td></td>
                                    <th></th>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
			</div>
		</div>
		<jsp:include page="../common/footer.jsp" />
    </body>
</html>