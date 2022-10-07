<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="New Reply!!">
                </div>
                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name="replyDate" value="">
                </div>

            </div>
            <div class="modal-footer">
                <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>

$(function(){

    var bnoValue = '<c:out value="${board.bno}"/>';
    var replyUL = $(".chat");

    showList(1);

    function showList(page){
        replyService.getList({bno:bnoValue, page:page||1},
        function(list){
            var str = "";
            if(list==null || list.length ==0){
                replyUL.html("");
                return;
            }

            for(var i=0, len=list.length||0; i<len; i++){
                str += "<li class='left clearfix' data-rno ='"+list[i].rno+"'>";
                str += "    <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
                str += "        <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
                str += "            <p>"+list[i].reply+"</p></div></li>";
            }

            replyUL.html(str);
        }); // end function(list)
    } // end showList
});
</script>
<%-- replyService Test 코드
<script type="text/javascript">
        console.log("======================");
        console.log("JS TEST");

        var bnoValue = '<c:out value="${board.bno}"/>';

        //for replyService add test
        /*
        replyService.add(
            {reply:"JS TEST", replyer:"tester", bno:bnoValue}
            ,
            function(result) {
                alert("RESULT: "+result);
            }
        );
        */

        // reply List Test
        replyService.getList(
            {bno:bnoValue, page:1}
            ,
            function(list){
                for(var i=0, len=list.length||0; i<len; i++){
                    console.log(list[i]);
                }
            }
        );
/*
        // 14번 댓글 삭제 테스트
        replyService.remove(13,
            function(count){
                console.log(count);
                if(count==="success"){
                    alert("REMOVED");
                }
            }
            ,
            function(err){
                alert('ERROR...');
            }
        );
*/

        replyService.update({
            rno : 9,
            bno : bnoValue,
            reply : "댓글 수정...."
            },
            function (result){
                alert("수정 완료....");
            }
        );

        replyService.get(9, function(data){
            console.log(data)
        });
</script>
--%>

<script type="text/javascript">
    $(function(){

        var operForm = $("#operForm");

        $("button[data-oper='modify']").on("click", function(e){

            operForm.attr("action", "modify").submit();
        });

        $("button[data-oper='list']").on("click", function(e){

            operForm.find("#bno").remove();
            operForm.attr("action", "list");
            operForm.submit();
        });

    });
</script>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
    <!--/.col-lg-12-->
</div>
<!--/.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Board Read Page</div>
            <!--/.panel-heading-->
            <div class="panel-body">
                <div class="form-group">
                    <label>Bno</label>
                    <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Title</label>
                    <input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/>
                    </textarea>
                </div>

                <div class="form-group">
                    <label>Writer</label>
                    <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
                </div>

                <button data-oper="modify" class="btn btn-default">Modify</button>
                <button data-oper="list" class="btn btn-info">List</button>

                <form id="operForm" action="modify" method="get">
                    <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                    <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                    <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
                    <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                    <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                </form>
            </div>
            <!-- end panel-body -->
        </div>
        <!-- end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <!--/.panel-->
        <div class="panel panel-default">
            <%--
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply
            </div>
            --%>

            <div class="panel-heading">
                <i class="fa fa-comment fa-fw"></i>Reply
                <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
            </div>


            <!-- /.panel-heading -->
            <div class="panel-body">
                <ul class="chat">
                    <!-- start reply -->
                    <li class="left clearfix" data-rno="12">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2018-01-01 13:13</small>
                            </div>
                            <p>Good job!</p>
                        </div>
                    </li>
                    <!-- end reply -->
                </ul>
                <!-- ./end ul-->
            </div>
            <!-- /.panel.chat-panel-->
        </div>
    </div>
    <!-- ./end row -->
</div>
<%@ include file="../includes/footer.jsp"%>