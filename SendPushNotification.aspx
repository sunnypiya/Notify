<%@ Page Title="" Language="C#" MasterPageFile="~/SSAMstAfterLogin.master" AutoEventWireup="true" CodeFile="SendPushNotification.aspx.cs" Inherits="SupremeAdmin_SendPushNotification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

       <title>Push Notification </title>

    

   <%-- <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="../Css/ScrollbarCss.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container">
        <center>
            <img id="imgLoading" width="50" height="50" src="https://media.giphy.com/media/xTk9ZvMnbIiIew7IpW/source.gif" />
            <div id="info">

            </div>
        </center>
        <center>
            <h3 class="text-info" onclick="GetPromisedData()">
                Send Notification to Subscribe Users
            </h3>
        </center>
        <div class="row">
            <div class="col-lg-6 ">
                Message Title :
                <input type="text" id="txtTitle" class="form-control" />

            </div>

            <div class="col-lg-6 ">
                Message Body :
                <input type="text" id="txtBody" class="form-control" />

            </div>


        </div>
        <div class="row">
            <div class="col-lg-6 ">
                Message Doc Link :
                <input type="text" id="txtLink" class="form-control" />

            </div>
            <div class="col-lg-6 ">
                Notification Image to be displayed :
                <input type="text" id="txtImgUrl" class="form-control" />

            </div>
        </div>
        <center>
            <br />
            <button type="button" id="btnSend" onclick="Send();" class="btn btn-success ">Send</button>
        </center>

        <hr />
        <div class="row">

            <div class="col-lg-6 offset-lg-3" style="height:500px; overflow-x:auto;">


                <ul class="list-group" id="lstGroupList">
                    <center>
                        <li class="list-group-item  font-weight-bold" aria-disabled="true">
                            <input type="checkbox" class="chkboxUserSelectAll" onclick="SelectAllUsers(this)" />
                            <a href="#" onclick=" LoadData()" class="text-info"> Load List of Active Users</a>
                        </li>
                    </center>

                    <li class="list-group-item">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-lg-12">


                                </div>
                            </div>
                        </div>

                    </li>

                </ul>
            </div>
        </div>


    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">

        const workerMain = new Worker("../worker.js");

        //workerMain.onmessage = e => {
        //    console.log('Woker says : ' + e.data + ' ');

        //}
        //if (typeof (Worker) !== "undefined") {
        //    console.log('Supported');
        //    if (typeof (worker) == "undefined") {
        //        var worker = new Worker("worker.js");
        //        //worker.postMessage(10000000);
        //    }
        //}

        async function display() {
            var x = await GetPromisedData();
            console.log(x);
        }

        display();


        async function GetPromisedData() {
            return new Promise((res, rej) => {

                setTimeout(() => {
                    res("Welcome All!")
                }, 300)

            })
        }

        //GetPromisedData().then(data => {
        //    console.log(data)
        //})


        //function getData() {
        //    fetch("SendToken.asmx/GetActiveUsers").then
        //        (data => {

        //            return data.json();
        //        }).then(data2 => {

        //            document.getElementById("info").innerHTML =
        //                `
        //                <ul>
        //                <li>${data2[0].User_FullName}</l>
        //                <li>${data2[0].FCM_Token_ID}</l>

        //                </ul>`;

        //            console.log(data2);
        //        })
        //}

        var userList;
        $("#imgLoading").hide();


        function Send() {

            // Getting all the checkboxes
            var chkboxlst = $(".chkboxUser");



            // looping through all the checkboxes

            for (var j = 0; j < chkboxlst.length; j++) {

                //console.log(chkboxlst[j].value);

                //checking current checkbox Is checked or not

                if (chkboxlst[j].checked) {

                    console.log(chkboxlst[j].value);

                    SendNotificationByID(chkboxlst[j].value)

                    //$.ajax({
                    //    url: 'SendToken.asmx/GetTokens',
                    //    method: 'post',
                    //    dataType: 'json',
                    //    contentType: 'application/json',
                    //    data: '{ "User_Id":"' + chkboxlst[j].value + '", "Counter":"njfnj"}',
                    //    success: function (data) {

                    //        console.log(data);

                    //        //for (var i = 0; i < data.length; i++) {
                    //        //    console.log(data[i].FCM_Token_ID);
                    //        //    //SendNotificationByID(data[i].FCM_Token_ID)
                    //        //}
                    //    },
                    //    error: function (err) {
                    //        console.log(err);
                    //    }
                    //});



                }
            }
        }


        function SendNotificationByID(TokenId) {
            console.log(TokenId);
            var title = $("#txtTitle").val();
            var txtBody = $("#txtBody").val();
            var txtLink = $("#txtLink").val();
            var txtImgUrl = $("#txtImgUrl").val();


            var key = 'AAAAlTU0oqE:APA91bEqMDKvTGRD8WHuW3rFgEQYGDorVJbvcCDG1jvhq80BJ40Fc4AAaAgPwmwtg14xPUN6yBsS7N-IU4j3KpEr13dxkpLbz9hkz2U4tUg1J2N1e7XcEnebsk_Rq8xH2B8U6K9O_M8l';
            //var to = 'YOUR-IID-TOKEN';
            var to = TokenId;
            var notification = {
                'title': title,
                'body': txtBody,
                'image': "https://media.9curry.com/uploads/organization/image/1870/iasri-logo.png",
                'icon': "https://media.9curry.com/uploads/organization/image/1870/iasri-logo.png",
                'click_action': txtLink
            };

            fetch('https://fcm.googleapis.com/fcm/send', {
                'method': 'POST',
                'headers': {
                    'Authorization': 'key=' + key,
                    'Content-Type': 'application/json'
                },
                'body': JSON.stringify({
                    'notification': notification,
                    'to': to
                })




            }).then(function (response) {
                console.log("Success");
                console.log(response);
            }).catch(function (error) {
                console.log("Failed");
                console.error(error);
            })
        }


        function SelectAllUsers(chkBox) {
            var chkboxlst = $(".chkboxUser");

            for (i = 0; i < chkboxlst.length; i++) {
                if (chkBox.checked) {
                    chkboxlst[i].checked = true;
                }
                else {
                    chkboxlst[i].checked = false;
                }
            }
        }



        function addToList(chkBox) {


            var chkboxlst = $(".chkboxUser");
            var chkboxUserSelectAll = $(".chkboxUserSelectAll")[0];
            //console.log(chkboxUserSelectAll[0]);
            var counter = 0;

            for (i = 0; i < chkboxlst.length; i++) {
                if (chkboxlst[i].checked) {
                    counter++;
                }

            }

            if (chkboxlst.length == counter) {
                chkboxUserSelectAll.checked = true;
            }
            else {
                chkboxUserSelectAll.checked = false;
            }


        }



       async function LoadData() {

            

            $("#imgLoading").attr("style", "display: block");//;


            $('#lstGroupList').empty();

            $.ajax({
                url: '../SendToken.asmx/GetActiveUsers',
                method: 'get',
                dataType: 'json',
                //data:'',
                success:  function (data) {


                    console.log(data);
                    var lstGroup = $('#lstGroupList');
                    lstGroup.append(`<center><li class="list-group-item  font-weight-bold" aria-disabled="true"><input type="checkbox" class="chkboxUserSelectAll" onclick="SelectAllUsers(this)"/><a href="#"  class="text-info" onclick="LoadData()"> Load List of Active Users</a></li></center><li class="list-group-item" onclick="LoadData()">
                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <div class="col-lg-12">


                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </li>`);


                    //workerMain.postMessage(10000000);


                    for (var i = 0; i < data.length; i++) {
                        //console.log(data[i].userPhoto.substring(1, data[i].userPhoto.length));
                        if (data[i].FCM_Token_Platform.includes('Win32')) {
                            data[i].FCM_Token_Platform = "Windows";
                        }
                        else if (data[i].FCM_Token_Platform.includes('Linux')) {
                            data[i].FCM_Token_Platform = "Android"
                        }

                        try {
                            var listItem = '<li  class="list-group-item shadow" ><input type="checkbox" class="chkboxUser" onclick="addToList(this)"  id="chk' + data[i].User_ID + '" value="' + data[i].FCM_Token_ID + '" /><img src="' + data[i].User_ProfilePhoto.substring(1, data[i].User_ProfilePhoto.length) + '" class="rounded-circle " width="50" height="50" />  ' + data[i].User_FullName + ' <p class="text-info text-right"> (Platform) : ' + data[i].FCM_Token_Platform +'</p> </li> <span><a id="' + data[i].User_ID + '"  class="btn-link text-info" ></a></span> ';
                        }
                        catch (err) {
                            var listItem = '<li  class="list-group-item shadow" ><input type="checkbox" class="chkboxUser" onclick="addToList(this)"  id="chk' + data[i].User_ID + '" value="' + data[i].FCM_Token_ID + '" /><img src="" class="rounded-circle " width="50" height="50" />  ' + data[i].User_FullName + '  <p class="text-info text-right"> (Platform) : ' + data[i].FCM_Token_Platform +'</p>  </li> <span><a id="' + data[i].User_ID + '"  class="btn-link text-info" ></a></span> ';
                        }

                        lstGroup.append(listItem);
                        //console.log(listItem);
                    }
                   
                    
                    $("#imgLoading").attr("style", "display:none");

                }
            });

        }
    </script>

</asp:Content>

