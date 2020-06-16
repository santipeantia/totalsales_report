<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="epm-zone.aspx.cs" Inherits="totalsale_report.xenterprise.epm_zone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>

        <style>
            .hide_column {
                display: none;
            }

            #tblzone i:hover {
                cursor: pointer;
            }

            #tblemployee i:hover {
                cursor: pointer;
            }

            #tblheadteam i:hover {
                cursor: pointer;
            }

            #tblproduct i:hover {
                cursor: pointer;
            }

            #tblzone-prd i:hover {
                cursor: pointer;
            }

            #tblzone-member i:hover {
                cursor: pointer;
            }
        </style>

        <script>
            $(document).ready(function () {
                //todo something here
                getZoneLists();
                getSaleLists();
                
                var aprd = $('#aprd')
                aprd.click(function () {
                    $('#btnprd').removeClass('hidden'); 
                    $('#btnlist').addClass('hidden');                 
                });

                 var alist = $('#alist')
                alist.click(function () {
                    $('#btnprd').addClass('hidden');
                    $('#btnlist').removeClass('hidden');        
                });
                  
                
                $("#tblzone").on('click', '.btnSelect', function () {
                    // get the current row
                    //var currentRow = $(this).closest("tr");

                    //var emp_id = currentRow.find("td:eq(0)").html(); // get current row 1st table cell td value
                    //var firstname = currentRow.find("td:eq(1)").html(); // get current row 2nd table cell td value
                    //var lastname = currentRow.find("td:eq(2)").html(); // get current row 3rd table cell  td value
                    //var data = emp_id + "\n" + firstname + "\n" + lastname;

                    //alert('select 2');

                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var zoneid = currentRow.find("td:eq(0)").html();
                    var zonename = currentRow.find("td:eq(1)").html();
                    var isactive = currentRow.find("td:eq(5)").html();

                    //alert(zoneid);

                    $('#zone_id_edit').val(zoneid);
                    $('#zonename_edit').val(zonename);

                    $.ajax({
                        url: '../../xenterprise/emp-zone_srv.asmx/GetZoneActivebyId',
                        method: 'post',
                        data: {
                            zone_id: zoneid
                        },
                        datatype: 'json',
                        success: function (data) {
                            var obj = jQuery.parseJSON(JSON.stringify(data));
                            if (obj != '') {

                                var headid;
                                var headname;

                                $.each(obj, function (key, inval) {
                                    $('#selstatus_edit').val(inval["isactive"]).change();
                                    headid = data[key].head_id;
                                    headname = data[key].head_name;
                                });

                                $('#headercode').val(headid);
                                $('#headername').val(headname);

                                //console.log(headid + ':' + headname);
                            }
                        }
                    })

                    getZoneCateLists(zoneid);
                    getZoneMemberLists(zoneid);

                    $('#myModalEdit').modal({ backdrop: false });
                    $('#myModalEdit').modal('show');
                });

                $("#tblzone").on('click', '.btnSelect2', function () {
                    // get the current row

                    //alert('select 2');
                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var zoneid = currentRow.find("td:eq(0)").html();
                    var zonename = currentRow.find("td:eq(1)").html();
                    var isactive = currentRow.find("td:eq(5)").html();

                    alert('Member of : ' + zoneid);


                });

                $("#tblzone").on('click', '.btnSelect3', function () {
                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var zoneid = currentRow.find("td:eq(0)").html();

                    //todo showing detalis of delete
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "Are you sure you want to update changes?!",
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, update changes.!'
                    }).then((result) => {
                        if (result.value) {
                            deletedchanges(zoneid);
                        }
                    });
                });

                $('#tblheadteam').on('click', '.btnSelect', function () {

                    var currentRow = $(this).closest("tr");
                    // this key value is empid
                    var empid = currentRow.find("td:eq(0)").html();
                    var fullname = currentRow.find("td:eq(1)").html();
                    var position = currentRow.find("td:eq(2)").html();

                    $('#headercode').val(empid);
                    $('#headername').val(fullname);

                    $('#modal-headteam').modal({ backdrop: false });
                    $('#modal-headteam').modal('hide');

                });

                $('#tblzone-prd').on('click', '.btnSelect', function () {
                    var currentRow = $(this).closest("tr");
                    
                    var zone_id = $('#zone_id_edit').val();
                    var catecode = currentRow.find("td:eq(0)").html();

                    Swal.fire({
                        title: 'Are you sure?',
                        text: "Are you sure you want to update changes?!",
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, update changes.!'
                    }).then((result) => {
                        if (result.value) {
                            deletedcatechanges(zone_id, catecode);
                        }
                    });
                });
                                
                $('#tblzone-member').on('click', '.btnSelect', function () {
                    var currentRow = $(this).closest("tr");

                    var zone_id = $('#zone_id_edit').val();
                    var empid = currentRow.find("td:eq(1)").html();

                    //alert(zone_id + ':' + empid);

                    //return;
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "Are you sure you want to update changes?!",
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, update changes.!'
                    }).then((result) => {
                        if (result.value) {
                            deletememberchanges(zone_id, empid);
                        }
                    });
                });


                $('#tblproduct').on('click', '.btnSelect', function () {
                    var empcode = '<%= Session["emp_id"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var catecode = currentRow.find("td:eq(0)").html();
                    var catename = currentRow.find("td:eq(1)").html();

                    var zone_id = $('#zone_id_edit').val();
                    var zonename = $('#zonename_edit').val();

                    console.log(catecode + ' : ' + catename + ' : ' + zone_id + ' : ' + zonename);

                    $.ajax({
                        url: '../../xenterprise/emp-zone_srv.asmx/GetZoneCateSaveChanges',
                        method: 'post',
                        data: {
                            trans_id: '1',
                            zone_catid: null,
                            zone_id: zone_id,
                            catecode: catecode,
                            catename: catename,
                            zone_desc: zonename,
                            isactive: '1',
                            created_by: empcode,
                            create_date: currentdate,
                            update_by: empcode,
                            update_date: currentdate
                        },
                        datatype: 'json',
                        success: function (data) {
                            //alert('success');

                            getProductCategory(zone_id);
                            getZoneCateLists(zone_id);
                        }
                    })

                    //$('#modal-products').modal({ backdrop: false });
                    //$('#modal-products').modal('hide');

                });

                $("#modal-employee").on('click', '.btnSelect', function () {
                    
                    var empcode = '<%= Session["emp_id"] %>';

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var empid = currentRow.find("td:eq(0)").html();
                    var fullname = currentRow.find("td:eq(1)").html();
                    var position = currentRow.find("td:eq(2)").html();

                    var zone_id = $('#zone_id_edit').val();
                    var zonename = $('#zonename_edit').val();

                    $.ajax({
                        url: '../../xenterprise/emp-zone_srv.asmx/GetZoneMemberSaveChanges',
                        method: 'post',
                        data: {
                            trans_id: '1',
                            zone_memid: null,
                            zone_id: zone_id,
                            emp_id: empid,
                            fullname: fullname,
                            position: position,
                            zone_desc: zonename,
                            isactive: '1',
                            head_id: $('#headcode_edit').val(),
                            head_name: $('#headcode_name_edit').val(),
                            created_by: empcode,
                            create_date: currentdate,
                            update_by: empcode,
                            update_date: currentdate
                        },
                        datatype: 'json',
                        success: function (data) {
                            //alert('success');
                            getZoneMemberLists(zone_id);
                        }
                    })

                    $('#modal-employee').modal({ backdrop: false });
                    $('#modal-employee').modal('hide');

                });

                var btnSavechanges = $('#btnSavechanges');
                btnSavechanges.click(function () {
                    savedatachanges();
                });

                var btnUpdatechanges = $('#btnUpdatechanges');
                btnUpdatechanges.click(function () {
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "Are you sure you want to update changes?!",
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, update changes.!'
                    }).then((result) => {
                        if (result.value) {
                            updatedatachanges();
                        }
                    });
                });

                var btnheadteam = $('#btnheadteam');
                btnheadteam.click(function () {
                    //var headercode = $('#headercode').val();


                    //alert('click')
                    $("#modal-headteam").appendTo("body");
                    $('#modal-headteam').modal({ backdrop: false });
                    $('#modal-headteam').modal('show');

                });

                var btnlist = $('#btnlist');
                btnlist.click(function () {
                    var headercode = $('#headercode').val();

                    if (headercode == '') {
                        Swal.fire({
                            position: 'center-center',
                            icon: 'error',
                            title: 'Team Header Not Found..',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                    else {
                        //alert('click')
                        $("#modal-employee").appendTo("body");
                        $('#modal-employee').modal({ backdrop: false });
                        $('#modal-employee').modal('show');
                    }
                });

                var btnprd = $('#btnprd');
                btnprd.click(function () {
                    var headercode = $('#headercode').val();

                    if (headercode == '') {
                        Swal.fire({
                            position: 'center-center',
                            icon: 'error',
                            title: 'Team Header Not Found..',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                    else {
                        //alert('click')
                        var zone_id = $('#zone_id_edit').val();
                        getProductCategory(zone_id);

                        $("#modal-products").appendTo("body");
                        $('#modal-products').modal({ backdrop: false });
                        $('#modal-products').modal('show');
                    }
                });

            });

            function getZoneLists() {
                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetZoneLists',
                    method: 'post',
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblzone').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].zone_id, data[i].zone_desc, data[i].firstname, data[i].lastname, data[i].create_date, data[i].status_desc, data[i].urlview, data[i].urltrash]);
                            });
                        }

                        table.draw();
                        bindtablezone();

                        ////in case need to visible columns
                        //table.column(0).visible(false);                         

                        //// incase need to hidded header and columns
                        //$('#tblzone th:nth-of-type(6)').addClass('hidden');
                        //$('#tblzone td:nth-of-type(6)').addClass('hidden');                       
                    }
                });
            }

            function getSaleLists() {
                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetSaleLists',
                    method: 'post',
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblemployee').DataTable();
                        table.clear();

                        var table2;
                        table2 = $('#tblheadteam').DataTable();
                        table2.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].emp_id, data[i].fullname, data[i].position, data[i].urllink]);

                                table2.row.add([data[i].emp_id, data[i].fullname, data[i].position, data[i].urllink]);
                            });
                        }

                        table.draw();
                        table2.draw();
                    }
                });
            }

            function getProductCategory(zone_id, catecode) {
                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetZoneCategory',
                    method: 'post',
                    data: {
                        zone_id: zone_id,
                        catecode: catecode
                        },
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblproduct').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].CateCode, data[i].CateName,  data[i].urllink]);
                            });
                        }
                        table.draw();
                    }
                });
            }

            function bindtablezone() {
                var table = document.getElementById("tblzone"), rIndex;
                for (var i = 1; i < table.rows.length; i++) {
                    for (var j = 0; j < table.rows[i].cells.length; j++) {


                        //if (this.cellIndex == 7) {

                        //        //alert('7');

                        //        $(this.cellIndex).css("cursor", "pointer");
                        //        //alert('Open Modal Delete..');
                        //    }


                        table.rows[i].cells[j].onclick = function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            console.log(rIndex + "  :  " + cIndex);

                            if (this.cellIndex == 6) {

                                //todo showing member of mene
                                // get key value from table 


                                //alert('Open Modal Edit Member..');
                            }

                            else if (this.cellIndex == 7) {

                                //alert('7');

                                //$(this).css("cursor", "pointer");
                                //alert('Open Modal Delete..');
                            }

                        }
                    }
                }
            }

            function getZoneMemberLists(zone_id) {
                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetZoneMemberLists',
                    method: 'post',
                    data: {
                        zone_id
                    },
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblzone-member').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].zone_memid, data[i].emp_id, data[i].fullname, data[i].position, data[i].urltrash]);
                            });
                        }

                        table.draw();


                        $('#tblzone-member th:nth-of-type(1)').addClass('hidden');
                        $('#tblzone-member td:nth-of-type(1)').addClass('hidden');

                    }
                });
            }

            function getZoneCateLists(zone_id) {
                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetZoneCateLists',
                    method: 'post',
                    data: {
                        zone_id
                    },
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblzone-prd').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].catecode, data[i].catename, data[i].urllink]);
                            });
                        }

                        table.draw();
                    }
                });
            }

        </script>

        <h1>Zone Pages  <%--step 1 check pages content name--%>
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary" style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Zone Setting</a>
                                        <span class="pull-right">
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


                        <%-- <%--step 2 design user interface ui below--%>
                        <div class="box-body txtLabel">

                            <div class="col-md-12">
                                <div class="nav-tabs-custom tab-info">
                                    <ul class="nav nav-tabs">
                                        <%-- create contente tab body--%>
                                        <li class="active"><a href="#tblzone" data-toggle="tab">Zone Lists</a></li>

                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabusers">
                                            <table id="tblzone" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th class="">CateCode</th>
                                                        <th class="">CateName</th>
                                                        <th class="">Firstname</th>
                                                        <th class="">Lastname</th>
                                                        <th class="">Date</th>
                                                        <th class="">Status</th>
                                                        <th style="width: 20px; text-align: center;">#</th>
                                                        <th style="width: 20px; text-align: center;">#</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="myModalNew">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">New Entry</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">

                            <%--<div class="form-group">
                                <label class="txtLabel">Zone ID</label>
                                <input type="text" id="zone_id" name="emp_id" class="form-control input-sm" required>
                                
                            </div>--%>

                            <div class="form-group">
                                <label class="txtLabel">Zone Name</label>
                                <input type="text" id="zonename" name="zonename" class="form-control input-sm" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Status</label>
                                <div class="txtLabel">
                                    <select id="selstatus" name="selstatus" class="form-control input-sm " style="width: 100%">
                                        <option value="1">Status is active</option>
                                        <option value="0">Status is cancel</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnSavechanges" name="btnSavechanges" class="btn btn-info">Save New</button>
                        <button type="button" class="btn btn-danger hidden" id="btnsavenew" runat="server">Save New</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <div class="modal modal-default fade" id="myModalEdit">
            <div class="modal-dialog"  style="width: 700px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">

                            <div class="form-group hidden">
                                <label class="txtLabel">Zone ID</label>
                                <input type="text" id="zone_id_edit" name="zone_id_edit" class="form-control input-sm" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Zone Name</label>
                                <input type="text" id="zonename_edit" name="zonename_edit" class="form-control input-sm" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Status</label>
                                <div class="txtLabel">
                                    <select id="selstatus_edit" name="selstatus_edit" class="form-control input-sm " style="width: 100%">
                                        <option value="1">Status is active</option>
                                        <option value="0">Status is cancel</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group hidden">
                                <label class="txtLabel">HeadCode</label>
                                <input type="text" id="headercode" name="headercode" class="form-control input-sm" required>
                            </div>

                            <div class="form-group">
                                <label class="txtLabel">Head Team</label>
                                <div class="input-group input-group-sm">
                                    <input type="text" id="headername" name="headername" class="form-control input-sm" readonly>
                                    <span class="input-group-btn">
                                        <button type="button" id="btnheadteam" name="btnheadteam" class="btn btn-info btn-flat">Go..!</button>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="nav-tabs-custom">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a href="#product" id="aprd" data-toggle="tab">Products</a></li>
                                        <li><a href="#member" id="alist" data-toggle="tab">Member</a></li>

                                        <span class="pull-right">
                                            <button type="button" id="btnprd" name="btnprd" class="btn btn-default btn-sm " data-toggle="tooltip" title="Product">
                                                <i class="fa fa-align-center"></i>
                                            </button>

                                            <button type="button" id="btnlist" name="btnlist" class="btn btn-default btn-sm hidden" data-toggle="tooltip" title="Member">
                                                <i class="fa fa-users"></i>
                                            </button>
                                        </span>
                                    </ul>
                                    
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="product">
                                            <p style="padding-bottom: 5px">
                                                <small>add new product lists</small>
                                               
                                            </p>

                                            <table id="tblzone-prd" class="table table-bordered table-striped table-hover table-condensed">
                                                <thead>
                                                    <tr>
                                                        <th>CateCode</th>
                                                        <th>CateName</th>                                                        
                                                        <th style="width: 20px; text-align: center;">#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>                                                  
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="tab-pane" id="member">
                                            <p style="padding-bottom: 5px">
                                                <small>add new member lists</small>
                                               
                                            </p>

                                            <table id="tblzone-member" class="table table-bordered table-striped table-hover table-condensed">
                                                <thead>
                                                    <tr>
                                                        <th>ZoneMemId</th>
                                                        <th>EmpId</th>
                                                        <th>Fullname</th>
                                                        <th>Position</th>
                                                        <th style="width: 20px; text-align: center;">#</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                   
                                                </tbody>
                                            </table>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnUpdatechanges" name="btnUpdatechanges" class="btn btn-info">Update Changes</button>
                        <button type="button" class="btn btn-danger hidden" id="Button1" runat="server">Save New</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
        </div>

        <div class="modal modal-default fade" id="modal-products">
            <div class="modal-dialog" style="width: 600px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Category</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post" >

                            <table id="tblproduct" class="table table-striped table-bordered table-hover table-condensed">
                                <thead>
                                    <tr>
                                        <th>CateCode</th>
                                        <th>CateName</th>                                        
                                        <th style="width: 20px; text-align: center;">#</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>


                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="modal-headteam">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Head Team</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">

                            <table id="tblheadteam" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>EmpId</th>
                                        <th>Fullname</th>
                                        <th>Position</th>
                                        <th style="width: 20px; text-align: center;">#</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>


                </div>
            </div>
        </div>

        <div class="modal modal-default fade" id="modal-employee">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Employee</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post">

                            <table id="tblemployee" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>EmpId</th>
                                        <th>Fullname</th>
                                        <th>Position</th>
                                        <th style="width: 20px; text-align: center;">#</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>


                </div>
            </div>
        </div>

        <script>
            function openModal() {

                $('#myModalNew').modal({ backdrop: false });
                $('#myModalNew').modal('show');
            }


            function validatesave() {

                Swal.fire({
                    title: 'Are you sure?',
                    text: "Are you sure you want to save changes?!",
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, save changes.!'
                }).then((result) => {
                    if (result.value) {
                        savedatachanges();
                    }
                });

                //return;
            }

            function savedatachanges() {
                var empcode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetSavechangeZone',
                    method: 'post',
                    data: {
                        trans_id: '0',
                        zone_id: null,
                        zone_desc: $('#zonename').val(),
                        isactive: $('#selstatus').val(),
                        head_id: null,
                        head_name: null,
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        $('#myModalNew').modal('hide');

                        $('#zonename').val('');

                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                        getZoneLists();
                    }
                });
            }

            function updatedatachanges() {
                var empcode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetSavechangeZone',
                    method: 'post',
                    data: {
                        trans_id: '1',
                        zone_id: $('#zone_id_edit').val(),
                        zone_desc: $('#zonename_edit').val(),
                        isactive: $('#selstatus_edit').val(),
                        head_id: $('#headercode').val(),
                        head_name: $('#headername').val(),
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        // $('#myModalEdit').modal('hide');
                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )

                        //$('#zone_id_edit').val('');
                        //$('#zonename_edit').val('');

                        getZoneLists();
                    }
                });
            }

            function deletedchanges(id) {
                var empcode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                $.ajax({
                    url: '../../xenterprise/emp-zone_srv.asmx/GetSavechangeZone',
                    method: 'post',
                    data: {
                        trans_id: '2',
                        zone_id: id,
                        zone_desc: null,
                        isactive: null,
                        created_by: empcode,
                        create_date: currentdate,
                        update_by: empcode,
                        update_date: currentdate
                    },
                    datatype: 'json',
                    success: function (data) {
                        Swal.fire(
                            'Saved!',
                            'Your file has been save changes.',
                            'success'
                        )
                        getZoneLists();
                    }
                });
            }

           function deletedcatechanges(zone_id, catecode){
               var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                 $.ajax({
                        url: '../../xenterprise/emp-zone_srv.asmx/GetZoneCateSaveChanges',
                        method: 'post',
                        data: {
                            trans_id: '3',
                            zone_catid: null,
                            zone_id: zone_id,
                            catecode: catecode,
                            catename: null,
                            zone_desc: null,
                            isactive: '1',
                            created_by: null,
                            create_date: currentdate,
                            update_by: null,
                            update_date: currentdate
                        },
                        datatype: 'json',
                        success: function (data) {
                            Swal.fire(
                                'Saved!',
                                'Your file has been save changes.',
                                'success'
                            )

                            getProductCategory(zone_id);
                            getZoneCateLists(zone_id);
                        }
                    })
            }

           function deletememberchanges(zone_id, empid){
               var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
                var currentdate2 = yyyy + '-' + mm + '-' + dd;

                  $.ajax({
                        url: '../../xenterprise/emp-zone_srv.asmx/GetZoneMemberSaveChanges',
                        method: 'post',
                        data: {
                            trans_id: '3',
                            zone_memid: null,
                            zone_id: zone_id,
                            emp_id: empid,
                            fullname: null,
                            position: null,
                            zone_desc: null,
                            isactive: '1',
                            head_id: null,
                            head_name: null,
                            created_by: null,
                            create_date: null,
                            update_by: null,
                            update_date: null
                        },
                        datatype: 'json',
                        success: function (data) {
                            //alert('success');
                            getZoneMemberLists(zone_id);
                        }
                    })
            }




        </script>

    </section>

</asp:Content>
