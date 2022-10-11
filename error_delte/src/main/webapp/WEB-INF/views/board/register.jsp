<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Register</h1>
    </div>
    <!--/.col-lg-12-->
</div>
<!--/.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Board Register</div>
            <!--/.panel-heading-->
            <div class="panel-body">
                <form role="form" action="register" method="post">
                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" name="title">
                    </div>

                    <div class="form-group">
                        <label>Test Area</label>
                        <textarea class="form-control" row="3" name="content"></textarea>
                    </div>

                    <div class="form-group">
                        <label>Writer</label><input class="form-control" name="writer">
                    </div>

                    <button type="submit" class="btn btn-default">Submit Button</button>
                    <button type="reset" class="btn btn-default">Reset Button</button>
                </form>

            </div>
            <!-- end panel-body -->
        </div>
        <!-- end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->

<!-- 파일 첨부 추가 -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">File Attach</div>
            <!--/.panel-heading-->
            <div class="panel-body">
                <div class="form-group uploadDiv">
                    <input type="file" name="uploadFile" multiple>
                </div>

                <div class="uploadResult">
                    <ul>
                    </ul>
                </div>
            </div>
            <!-- end panel-body -->
        </div>
        <!-- end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->

<%@ include file="../includes/footer.jsp"%>