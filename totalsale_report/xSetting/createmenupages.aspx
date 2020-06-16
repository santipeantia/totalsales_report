<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="createmenupages.aspx.cs" Inherits="totalsale_report.xSetting.createmenupages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>
        
        <script>
            $(document).ready(function () {

                //#region single a table
                //$('#example1').DataTable({
                //    //'deferRender': false,                   
                //    'ajax': {
                //        "type": "POST",
                //        "url": "../../xsetting/createmenupages_srv.asmx/GetDataPageMenuAll",
                //        "dataSrc": function (data) {
                            
                //            var return_data = new Array();
                //            for (var i = 0; i < data.length; i++) {
                //                return_data.push({
                //                    'mnu_type_id': data[i].mnu_type_id,
                //                    'mnu_type_name': data[i].mnu_type_name,
                //                    'mnu_id': data[i].mnu_id,
                //                    'mnu_page': data[i].mnu_page,
                //                    'mnu_title': data[i].mnu_title,
                //                    'url1': '<a href="' + data[i].mnu_type_id + '" title="Member"><i class="fa fa-users text-green"></i></a>',
                //                    'url2': '<a href="' + data[i].mnu_id + '" title="Trash"><i class="fa fa-trash text-red"></i></a>'
                //                })
                //            }
                //            return return_data;
                //        }
                //    },
                //    "columns":
                //        [
                //            { 'data': 'mnu_type_name' },
                //            { 'data': 'mnu_page' },
                //            { 'data': 'mnu_title' },
                //            { 'data': 'url1' },
                //            { 'data': 'url2' }
                //        ]
                //});
                //#endregion single
                


                var button1 = $('#button1');
                button1.click(function () {

                    var emp_id = '<%= Session["emp_id"] %>';
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                    var currentdate2 = yyyy + '-' + mm + '-' + dd;


                    Swal.fire({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonColor: '#d33',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Yes, Save it!'
                    }).then((result) => {
                        if (result.value) {

                            //todo web service working here and then after success alert
                            var selSysType = $('#selSysType').val();
                            var xfolder = '';

                            if (selSysType == '1')
                            {
                                xfolder = 'xenterprise';
                            } else if (selSysType == '2')
                            {
                                xfolder = 'xtransaction';
                            } else {
                                xfolder = 'xreporting';
                            }     
                            
                            $.ajax({
                                url: '../../xsetting/createmenupages_srv.asmx/GetInsertMenuPage',
                                method: 'POST',
                                data: {
                                    mnu_type_id: $('#selSysType').val(),
                                    mnu_page: $('#pagename').val(),
                                    mnu_title: $('#pagetitle').val(),
                                    mnu_seqno: $('#seqno').val(),
                                    isactive: '1',
                                    created_by: emp_id,
                                    create_date: currentdate,
                                    update_by: emp_id,
                                    update_date: currentdate
                                },
                                dataType: 'json',
                                //success: function (data) {
                                //    alert(urllink);
                                //}
                               
                                complete: function (data) {
                                    Swal.fire({
                                        title: 'Saved!',
                                        text: 'Your file has been saved.',
                                        type: 'success'
                                    })                              
                                }                     
                            });    

                              //reload();
                            

                        }
                    })
                });


                var btnReload = $('#btnReload');
                btnReload.click(function () {
                    reload();
                });

                var example1 = document.getElementById("example1"), rIndex;
                for (var i = 1; i < example1.rows.length; i++) {
                    for (var j = 0; j < example1.rows[i].cells.length; j++) {
                        example1.rows[i].cells[j].onclick = function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            console.log(rIndex + "  :  " + cIndex);

                            if (this.cellIndex == 5) {

                                var mnu_type_id = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                var mnu_type_name = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var mnu_id = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var mnu_page = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(3)');
                                var mnu_title = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(4)');
                                
                                var stext = $('#mnu_type_id');
                                stext.text(mnu_type_id.text());
                                $('#mnu_type_name').text(mnu_type_name.text());

                                $('#mnu_type_id_edit').val(mnu_type_id.text());
                                $('#mnu_type_name_edit').val(mnu_type_name.text());
                                $('#mnu_id_edit').val(mnu_id.text());
                                $('#mnu_page_edit').val(mnu_page.text());
                                $('#mnu_title_edit').val(mnu_title.text());

                                //call get data user list
                                //getUserLists();

                                getMemberLists(mnu_id.text());
                                getUserLists(mnu_id.text());

                                $("#modal-memberedit").modal({ backdrop: false });
                                $("#modal-memberedit").modal("show");
                            }

                            else if (this.cellIndex == 6) {

                                //todo showing detalis of delete
                                var mnu_id = $("#example1").find('tr:eq(' + rIndex + ')').find('td:eq(2)');

                                Swal.fire({
                                    title: 'Are you sure?',
                                    text: "You won't be able to revert this!",
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Yes, delete it!'
                                }).then((result) => {
                                    if (result.value) {
                                        //todo web service working here and then after success alert     
                                        //alert(empid.text());

                                        $.ajax({
                                            url: '../../xsetting/createmenupages_srv.asmx/GetDeleteMenuLists',
                                            method: 'post',
                                            data: {
                                                mnuid: mnu_id.text()
                                            },
                                            dataType: 'json',
                                            complete: function (data) {
                                                Swal.fire(
                                                    'Saved!',
                                                    'Your file has been saved.',
                                                    'success'
                                                )
                                            }
                                        });
                                    }
                                })
                            }
                        }
                    }
                }
            })

        </script>

        <script>
            function reload() {
                $.ajax({
                    url: '../../xsetting/createmenupages_srv.asmx/GetDataPageMenuAll',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        var trHTML = '';

                        $('#example1 tr:not(:first)').remove();
                        $(data).each(function (index, item) {
                            trHTML += '<tr> ' +
                                '     <td class="hidden">' + item.mnu_type_id + '</td> ' +
                                '     <td>' + item.mnu_type_name + '</td> ' +
                                '     <td class="hidden">' + item.mnu_id + '</td> ' +
                                '     <td>' + item.mnu_page + '</td> ' +
                                '     <td>' + item.mnu_title + '</td> ' +
                                '     <td style="width: 20px; text-align: center;"> ' +
                                '       <a href="' + item.mnu_id + '" title="Member"><i class="fa fa-users text-green"></i></a></td> ' +
                                '     <td style="width: 20px; text-align: center;"> ' +
                                '       <a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td> ' +
                                '</tr>';
                        });

                        $('#example1').append(trHTML);


                        //var table;
                        //table = $('#example1').DataTable();
                        //table.clear();
                        //if (data != '') {
                        //    $.each(data, function (i, item) {
                        //        table.row.add([data[i].mnu_type_id, data[i].mnu_type_name, data[i].mnu_id, data[i].mnu_page, data[i].mnu_title]);
                        //    });
                        //}
                        //else {
                        //    //$('#tbluser').html('<h3>No users are available</h3>');
                        //}
                        //table.draw();
                                               



                        $(function () {
                            var example1 = document.getElementById("example1"), rIndex;
                            for (var i = 1; i < example1.rows.length; i++) {
                                for (var j = 0; j < example1.rows[i].cells.length; j++) {
                                    example1.rows[i].cells[j].onclick = function () {
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;
                                        console.log(rIndex + "  :  " + cIndex);

                                        if (this.cellIndex == 5) {

                                            //todo showing member of mene

                                            alert('Open Modal Member');
                                        }

                                        else if (this.cellIndex == 6) {

                                            //todo showing detalis of delete

                                            alert('Open Modal Delete..>');
                                        }

                                    }
                                }
                            }
                        });


                    }
                });
            }

            function getUserLists(mnuid) {
                $.ajax({
                    url: '../../xsetting/createmenupages_srv.asmx/GetDataUserLists',
                    method: 'post',
                    data: {
                        mnuid: mnuid
                    },
                    dataType: 'json',
                    success: function (data) {
                        //variable table for keep data
                        var table;
                        table = $('#tbluser').DataTable();
                        //remove rows on table
                        table.clear();
                        //check data has rows then
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].empid, data[i].firstname, data[i].lastname, data[i].urllink]);
                            });
                        }
                        else {
                            //$('#tbluser').html('<h3>No users are available</h3>');
                        }
                        //finally draw into a table
                        table.draw();

                        $(function () {
                            //change cursor handle
                            $('#tbluser td').hover(function () {
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;
                                if (rIndex != 0 & cIndex == 3) {
                                    $(this).css('cursor', 'pointer');
                                }
                            });

                             var table = document.getElementById("tbluser"), rIndex;
                            for (var i = 1; i < table.rows.length; i++) {
                                for (var j = 0; j < table.rows[i].cells.length; j++) {
                                    table.rows[i].cells[j].onclick = function () {
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;
                                        console.log(rIndex + "  :  " + cIndex);

                                        var empid = $("#tbluser").find('tr:eq(' + rIndex + ')').find('td:eq(0)');
                                        var usrcreate = '<%= Session["emp_id"] %>';

                                        if (this.cellIndex == 3) {
                                            //confirm delete member
                                            Swal.fire({
                                                title: 'Are you sure?',
                                                text: "You won't be able to revert this!",
                                                icon: 'warning',
                                                showCancelButton: true,
                                                confirmButtonColor: '#3085d6',
                                                cancelButtonColor: '#d33',
                                                confirmButtonText: 'Yes, save it!'
                                            }).then((result) => {
                                                if (result.value) {
                                                    //todo web service working here and then after success alert     
                                                    //alert(empid.text());
                                                    
                                                    $.ajax({
                                                        url: '../../xsetting/createmenupages_srv.asmx/GetSaveMemberLists',
                                                        method: 'POST',
                                                        data: {
                                                            empid: empid.text(),
                                                            mnuid: mnuid,                                                            
                                                            isactive: 'true',
                                                            isdelete: 'false', 
                                                            usrcreate: usrcreate
                                                        },
                                                        dataType: 'json',                                                        
                                                        complete: function (data) {
                                                            Swal.fire(
                                                                'Saved!',
                                                                'Your file has been saved.',
                                                                'success'
                                                            )
                                                            getMemberLists(mnuid);

                                                            getUserLists(mnuid);
                                                        }                                                        
                                                    });                                                   
                                                }
                                            })
                                        }
                                    }
                                }
                            }

                        });
                    }
                });
            };

            function getMemberLists(mnuid) {

                //alert(mnuid)
                // using ajax call web services
                //var mnuid = $('#mnu_id_edit').val();
                $.ajax({
                    url: '../../xsetting/createmenupages_srv.asmx/GetDataMemberLists',
                    data: {
                        mnuid: mnuid
                    },
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {
                        //variable table for keep data
                        var table;
                        table = $('#tblmember').DataTable();
                        //remove rows on table
                        table.clear();
                        //check data has rows then
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].empid, data[i].firstname, data[i].lastname, data[i].urllink]);
                            });
                        }
                        else {
                            //$('#tblmember').html('<h3>No users are available</h3>');
                        }
                        //finally draw into a table
                        table.draw();

                        $(function () {
                            //change cursor handle
                            $('#tblmember td').hover(function () {
                                rIndex = this.parentElement.rowIndex;
                                cIndex = this.cellIndex;
                                if (rIndex != 0 & cIndex == 3) {
                                    $(this).css('cursor', 'pointer');
                                }
                            });

                            var table = document.getElementById("tblmember"), rIndex;
                            for (var i = 1; i < table.rows.length; i++) {
                                for (var j = 0; j < table.rows[i].cells.length; j++) {
                                    table.rows[i].cells[j].onclick = function () {
                                        rIndex = this.parentElement.rowIndex;
                                        cIndex = this.cellIndex;
                                        console.log(rIndex + "  :  " + cIndex);

                                        var empid = $("#tblmember").find('tr:eq(' + rIndex + ')').find('td:eq(0)');

                                        if (this.cellIndex == 3) {
                                            //confirm delete member
                                            Swal.fire({
                                                title: 'Are you sure?',
                                                text: "You won't be able to revert this!",
                                                icon: 'warning',
                                                showCancelButton: true,
                                                confirmButtonColor: '#3085d6',
                                                cancelButtonColor: '#d33',
                                                confirmButtonText: 'Yes, delete it!'
                                            }).then((result) => {
                                                if (result.value) {
                                                    //todo web service working here and then after success alert     
                                                    //alert(empid.text());
                                                    
                                                    $.ajax({
                                                        url: '../../xsetting/createmenupages_srv.asmx/GetDeleteMemberLists',
                                                        method: 'POST',
                                                        data: {
                                                            mnuid: mnuid,
                                                            empid: empid.text()
                                                        },
                                                        dataType: 'json',                                                        
                                                        complete: function (data) {
                                                            Swal.fire(
                                                                'Deleted!',
                                                                'Your file has been deleted.',
                                                                'success'
                                                            )
                                                            getMemberLists(mnuid);

                                                            getUserLists(mnuid);
                                                        }                                                        
                                                    });                                                   
                                                }
                                            })
                                        }
                                    }
                                }
                            }
                        });
                    }
                });

                ////#endregion single
            };

        </script>



        <h1>Create Menu Pages
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary"   style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Menu Setting</a>
                                        <span class="pull-right">
                                            <button type="button" id="btnReload" name="btnReload" class="btn btn-default btn-sm checkbox-toggle" data-toggle="tooltip" title="Reload">
                                                <i class="fa fa-refresh"></i>
                                            </button>
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Monitoring progression of projects</span>
                                </div>
                            </div>
                        </div>


                        <%-- first start here--%>
                        <div class="box-body">

                            <div class="col-md-4">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#activity" data-toggle="tab">Menu Setting</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="activity">
                                            <!-- Post -->
                                            <div class="post">
                                                <div class="form-group">
                                                    <label class="txtLabel">MenuType</label>
                                                    <div class="txtLabel">
                                                        <select id="selSysType" name="selSysType" class="form-control input-sm">
                                                            <option value="1">Enterprise Master</option>
                                                            <option value="2">Transaction Entry</option>
                                                            <option value="3">Reporting</option>
                                                            <option value="4">Help & Support</option>
                                                            <option value="5">Setting</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="txtLabel">Page name</label>
                                                    <input class="form-control input-sm" type="text" id="pagename" name="pagename" placeholder="yourpages.aspx">
                                                </div>
                                                <div class="form-group">
                                                    <label class="txtLabel">Menu Title</label>
                                                    <input class="form-control input-sm" type="text" id="pagetitle" name="pagetitle" placeholder="show display menu">
                                                </div>
                                                <div class="form-group">
                                                    <label class="txtLabel">Seq No.</label>
                                                    <input class="form-control input-sm" type="text" id="seqno" name="seqno" placeholder="sequent number for alight menu">
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <button type="button" id="button1" name="buton1" class="btn btn-primary btn-sm btn-block">Save Entry</button>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8">
                                <table id="example1" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th class="hidden">TypeID</th>
                                            <th>TypeName</th>
                                            <th class="hidden">MenuID</th>
                                            <th>Filename</th>
                                            <th>Title</th>
                                            <th style="width: 20px; text-align: center;">#</th>
                                            <th style="width: 20px; text-align: center;">#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%= strTblDetail %>
                                    </tbody>

                                </table>
                            </div>

                           
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade txtLabel" id="modal-memberedit">
            <div class="modal-dialog"  style="width: 1000px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title txtLabel">Members :  <span class="txtLabel"> <label id="mnu_type_id"></label> <label id="mnu_type_name"></label> </span> </h4> 
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="">
                                <div class="form-group col-md-4 hidden">
                                    <label class="txtLabel">Type ID.</label>
                                    <input class="form-control input-sm" type="text" id="mnu_type_id_edit" name="mnu_type_id_edit" placeholder="">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Menu Type.</label>
                                    <input class="form-control input-sm" type="text" id="mnu_type_name_edit" name="mnu_type_name_edit" disabled placeholder="">
                                </div>

                                <div class="form-group col-md-4 hidden">
                                    <label class="txtLabel">Menu ID.</label>
                                    <input class="form-control input-sm" type="text" id="mnu_id_edit" name="mnu_id_edit" placeholder="">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Page Name.</label>
                                    <input class="form-control input-sm" type="text" id="mnu_page_edit" name="mnu_page_edit" disabled placeholder="">
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="txtLabel">Title Name.</label>
                                    <input class="form-control input-sm" type="text" id="mnu_title_edit" name="mnu_title_edit" disabled placeholder="">
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-6">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#tabusers" data-toggle="tab">User Lists</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabusers">
                                            <!-- Post -->
                                            <div class="post">
                                                <table id="tbluser" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th>EmpCode</th>
                                                            <th>FirstName</th>
                                                            <th>LastName</th>
                                                            <th style="width: 20px; text-align: center;">#</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%--<tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="member"><i class="fa fa-user-plus text-green"></i></a></td>
                                                        </tr>                                                        
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="member"><i class="fa fa-user-plus text-green"></i></a></td>
                                                        </tr>--%>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="col-md-6">
                                <div class="nav-tabs-custom tab-danger">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#tabmember" data-toggle="tab">Member of menu</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabmember">
                                            <!-- Post -->
                                            <div class="post">
                                                <table id="tblmember" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th>EmpCode</th>
                                                            <th>FirstName</th>
                                                            <th>LastName</th>
                                                            <th style="width: 20px; text-align: center;">#</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%--<tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>
                                                        <tr>
                                                            <td>519021</td>
                                                            <td>สันติ</td>
                                                            <td>แป้นตี้ย</td>
                                                            <td style="width: 20px; text-align: center;"><a href="#" title="Trash"><i class="fa fa-trash-o text-red"></i></a></td>
                                                        </tr>--%>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>

                        
                        <p>&nbsp;</p>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default btn-sm pull-left" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary btn-sm">Save changes</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </section>

</asp:Content>
