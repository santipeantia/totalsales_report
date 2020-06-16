<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="projectsmanagement.aspx.cs" Inherits="totalsale_report.xtransaction.projectsmanagement" %>
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

            #tblprojectlists i:hover {
                cursor: pointer;
            }

            #tbltranswithoutsalesconsignee i:hover {
                cursor: pointer;
            }

        </style>

        <script>
            $(document).ready(function () {
                //todo something here
                getProjectLists();

                var btntransinv = $('#btntransinv')
                btntransinv.click(function () {
                    //alert('button click');
                    $.ajax({
                        url: '../../xtransaction/trn-projecsmanagement_srv.asmx/GetTransactionMasterWithProjects',
                        method: 'post',
                        datatype: 'json',
                        success: function (data) {
                            var table;
                            table = $('#tbltranswithoutsalesconsignee').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].DocuNo, data[i].DocuDate, data[i].DocuDateDue, data[i].CustCode, data[i].CustName, data[i].EmpCode, data[i].SaleName, data[i].TotalPrice, data[i].urlmember]);
                                });                                 
                            }
                            table.draw();                              
                        }
                    });

                    //$('#bookdetails').modal("show").on('shown.bs.modal', function() {
                    //$(".progress").delay(1000).fadeOut(300);

                    $('#modal-transinv').modal({ backdrop: false });
                    $('#modal-transinv').modal('show');                  
                });

                var btnSavechangesProject = $('#btnSavechangesProject');
                btnSavechangesProject.click(function () {
                    var userscode = '<%= Session["emp_id"] %>';
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;

                    var docuno = $('#docuno').val();
                    var projectname = $('#projectname').val();

                    //alert(docuno);

                    $.ajax({
                        url: '../../xtransaction/trn-projecsmanagement_srv.asmx/GetSavechangeProjectsDesc',
                        method: 'post',
                        data: {
                            DocuNo: docuno,
                            ProjectDesc: projectname,
                            update_by: userscode,
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
                            $('#modal-invoicedetails').modal('hide');
                            getProjectLists();
                        }
                    });
                });

                $("#tblprojectlists").on('click', '.btnSelect', function () {

                    var currentRow = $(this).closest("tr");
                    // this key value is empid
                    var conid = currentRow.find("td:eq(0)").html();
                    var docuno = currentRow.find("td:eq(1)").html();
                    var docudate = currentRow.find("td:eq(2)").html();
                    var docudatedue = currentRow.find("td:eq(3)").html();
                    var empcode = currentRow.find("td:eq(4)").html();
                    var projectdesc = currentRow.find("td:eq(5)").html();

                    //alert(currentRow.text());

                    $.ajax({
                        url: '../../xtransaction/trn-projecsmanagement_srv.asmx/GetInvoiceDetails',
                        method: 'post',
                        data: {
                            docuno: docuno
                        },
                        datatype: 'json',
                        success: function (data) {
                            var table;
                            table = $('#tblinvoicedetails').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].DocuNo, data[i].DocuDate, data[i].Product, data[i].GoodCode, data[i].Model, data[i].Amount, data[i].RentAmount, data[i].TotalPrice]);                                    
                                });
                            }
                            table.draw();
                        }                       
                    });

                    $('#docuno').val(docuno);
                    $('#projectname').val(projectdesc);

                    $('#modal-invoicedetails').modal({ backdrop: false });
                    $('#modal-invoicedetails').modal('show');
                });

                $("#tblprojectlists").on('click', '.btnSelect2', function () {

                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var conid = currentRow.find("td:eq(0)").html();
                    var docuno = currentRow.find("td:eq(1)").html();

                    //alert('delete : ' + currentRow.text());

                    Swal.fire({
                        title: 'Are you sure?',
                        text: "Are you sure you want to delete..?",
                        icon: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, confirm delete.!'
                    }).then((result) => {
                        if (result.value) {
                            deletechangesprojects(docuno);
                        }
                    });
                });
                               

                $("#tbltranswithoutsalesconsignee").on('click', '.btnSelect', function () {

                    var currentRow = $(this).closest("tr");

                    // this key value is empid
                    var docuno = currentRow.find("td:eq(0)").html();
                    var docudate = currentRow.find("td:eq(1)").html();
                    var docudatedue = currentRow.find("td:eq(2)").html();
                    var custcode = currentRow.find("td:eq(3)").html();
                    var custname = currentRow.find("td:eq(4)").html();
                    var empcode = currentRow.find("td:eq(5)").html();
                    var salename = currentRow.find("td:eq(6)").html();
                    var totalprice = currentRow.find("td:eq(7)").html();

                    //alert(docuno);

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
                           
                            updatedatachangesproject(docuno, docudate, empcode, null)
                            $('#modal-transinv').modal('hide');
                            }
                        });
                });
            });

            function getProjectLists() {
                $.ajax({
                    url: '../../xtransaction/trn-projecsmanagement_srv.asmx/GetProjectLists',
                    method: 'post',
                    datatype: 'json',
                    success: function (data) {
                        var table;
                        table = $('#tblprojectlists').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].ID, data[i].DocuNo, data[i].DocuDate, data[i].EmpCode, data[i].EmpName, data[i].ProjectDesc, data[i].CustCode, data[i].CustName, data[i].urlmember, data[i].urltrash]);
                            });
                        }
                        table.draw();
                    }
                });
            }

            function updatedatachangesproject(docuno, docudate, empcode, projectdesc) {
                var userscode = '<%= Session["emp_id"] %>';

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var currentdate = yyyy + '-' + mm + '-' + dd + ' ' + tt;
               
                //alert(docuno + docudate + docudatedue + empcode + salename + custcode + custname);

                $.ajax({
                    url: '../../xtransaction/trn-projecsmanagement_srv.asmx/GetSavechangeProjects',
                    method: 'post',
                    data: {
                        DocuNo: docuno,
                        DocuDate: docudate,                       
                        EmpCode: empcode,                       
                        ProjectDesc: projectdesc,
                        created_by: userscode,
                        create_date: currentdate,
                        update_by: userscode,
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
                        getProjectLists();
                    }
                });
            }


            function deletechangesprojects(docuno) {
                $.ajax({
                    url: '../../xtransaction/trn-projecsmanagement_srv.asmx/GetDeleteProjects',
                    method: 'post',
                    data: {
                        docuno: docuno
                    },
                    datatype: 'json',
                    success: function (data) {
                        // $('#myModalEdit').modal('hide');
                        Swal.fire(
                            'Deleted..!',
                            'Your file has been delete changes.',
                            'success'
                        )
                        getProjectLists();
                    }
                });
            }


        </script>

        <h1>Projects Management  <%--step 1 check pages content name--%>
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
                                        <a href="#">Projects Management</a>
                                        <span class="pull-right">
                                            <button type="button" id="btntransinv" class="btn btn-default btn-sm checkbox-toggle" title="New Entry!">
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
                                        <li class="active"><a href="#tblzone" data-toggle="tab">Projects List</a></li>

                                    </ul>
                                    <div class="tab-content">
                                        <div class="active tab-pane" id="tabusers">
                                            <table id="tblprojectlists" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th class="">ID</th>
                                                        <th class="">DocuNo</th>
                                                        <th class="">DocuDate</th>
                                                        <th class="">EmpCode</th>
                                                        <th class="">EmpName</th>
                                                        <th class="">ProjectDesc</th>
                                                        <th class="">CustCode</th>
                                                        <th class="">CustName</th>
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

        <div class="modal modal-default fade" id="modal-transinv">
            <div class="modal-dialog" style="width: 1000px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Transaction Invoice</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->                       

                        <div class="post">
                            <table id="tbltranswithoutsalesconsignee" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>DocuNo</th>
                                        <th>DocuDate</th>
                                        <th>DocuDateDue</th>
                                        <th>CustCode</th>
                                        <th>CustName</th>
                                        <th>EmpCode</th>
                                        <th>SaleName</th>
                                        <th>TotalPrice</th>
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

        <div class="modal modal-default fade" id="modal-invoicedetails">
            <div class="modal-dialog" style="width: 1100px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Transaction Invoice</h4>
                    </div>
                    <div class="modal-body">
                        <!-- Post -->
                        <div class="post"  style="width: 100%; overflow: scroll; ">

                             <input type="hidden" id="docuno" name="docuno" value="" />

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="txtLabel">Project Name</label>
                                    <input type="text" id="projectname" name="projectname" class="form-control input-sm">
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="txtLabel">Project Update</label>
                                    <button type="button" id="btnSavechangesProject" name="btnSavechangesProject" class="btn btn-info btn-flat btn-block btn-sm">Save Changes</button>
                                </div>
                            </div>                           


                            <table id="tblinvoicedetails" class="table table-striped table-bordered table-hover table-condensed" >
                                <thead>
                                    <tr>
                                        <th>DocuNo</th>
                                        <th>DocuDate</th>
                                        <th>Product</th>
                                        <th>GoodCode</th>
                                        <th>Model</th>
                                        <th>Amount</th>
                                        <th>RentAmount</th>
                                        <th>TotalPrice</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                   <%-- <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnSavechangesProject" name="btnSavechangesProject" class="btn btn-info">Save New</button>                        
                    </div>--%>

                </div>
            </div>
        </div>

        <script>
            
        </script>

    </section>
</asp:Content>
