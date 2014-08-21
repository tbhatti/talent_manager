$(document).ready(function () {
    if($("#role").val()=="Recruiter"){
        $("#container-resume-comments").addClass("hide");
       $("#container-candidates-list").addClass("expanded");
      }
    if($("#role").val()=="Candidate"){
       $("#container-candidates-list").addClass("hide");
        $("#container-resume-comments").addClass("expanded");
    }
    /*if($("#role").val()=="Recruiter"){
       // $("#container-resume").addClass("hide");
       // $("#container-comments").addClass("hide");
        $.ajax({
            url: "/home/show",
            data:"",
            type: "get",
            success: function (data) {

                //$("#container-candidates-list").html(data);

            },
            error: function (data) {
                $.jGrowl("Error while loading company stats");
            },
            complete: function (data) {
            }
        });
    }
    if($("#role").val()=="Candidate") {
        $("#container-resume").addClass("show");
        $("#container-comments").addClass("show");
        $("#container-candidates-list").addClass("hide");
    }*/



});

$(document).on("click", ".js-candidate-details", function (e) {

    var user_id = $(this).attr("user_id");
    $.ajax({
        url: "/home/resume",
        data: "user_id=" + user_id,
        type: "get",
        success: function (data) {
            $("#container-resume-comments").removeClass("hide");
            $("#container-candidates-list").removeClass("expanded");
            $("#container-resume").html('');
            $("#container-resume").html(data);

            /*$("#container-resume").addClass("show");
            $("#container-comments").addClass("show");
            $("#container-candidates-list").addClass("hide");
*/
        },
        error: function (data) {
            $.jGrowl("Error while loading company stats");
        },
        complete: function (data) {
            testComments(user_id);

        }
    });


});

function testComments(user_id){

    $.ajax({
        url: "/home/comments_list",
        data: "user_id=" + user_id,
        type: "get",
        success: function (data) {
            $(".js-container-comments-list").html('');
            $(".js-container-comments-list").html(data);
        },
        error: function (data) {
            $.jGrowl("Error while loading company stats");
        },
        complete: function (data) {
        }
    });

}


