<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="marketing-sales-reportmkt.aspx.cs" Inherits="totalsale_report.xreporting.marketing_sales_reportmkt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>

        <script src="https://rawgit.com/unconditional/jquery-table2excel/master/src/jquery.table2excel.js"></script>

        <style>
            .hide_column {
                display: none;
            }

          
            #overlay {
                position: fixed;
                top: 0;
                width: 100%;
                height: 100%;
                display: none;
                background: rgba(0,0,0,0.6);
            }

            .cv-spinner {
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .spinner {
                width: 40px;
                height: 40px;
                border: 4px #ddd solid;
                border-top: 4px #2e93e6 solid;
                border-radius: 50%;
                animation: sp-anime 0.8s infinite linear;
            }

            @keyframes sp-anime {
                100% {
                    transform: rotate(360deg);
                }
            }

            .is-hide {
                display: none;
            }

            .myclass {
                text-align: right;
            }

            .mycenter {
                text-align: center;
            }
        </style>

        <script>
            $(document).ready(function () {

                 var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var monthname = "";
                var yyyy = today.getFullYear();
                var yeartree = yyyy - 2;
                var yeartwo = yyyy - 1;
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                if (mm == "01") { monthname = "Jan"; }
                else if (mm == "02") { monthname = "Feb"; }
                else if (mm == "03") { monthname = "Mar"; }
                else if (mm == "04") { monthname = "Apr"; }
                else if (mm == "05") { monthname = "May"; }
                else if (mm == "06") { monthname = "Jun"; }
                else if (mm == "07") { monthname = "Jul"; }
                else if (mm == "08") { monthname = "Aug"; }
                else if (mm == "09") { monthname = "Sep"; }
                else if (mm == "10") { monthname = "Oct"; }
                else if (mm == "11") { monthname = "Nov"; }
                else { monthname = "Dec"; }
                               
                $('#lblTotalTreeYear').text(yeartree);
                $('#lblTotalTwoYear').text(yeartwo);
                $('#lblTotalOneYear').text('Jan-'+monthname+' '+yeartwo);
                $('#lblTotalYearToDate').text('Jan-' + monthname + ' ' + yyyy);
                $('#lbldetailofyear').text(yyyy);


                //Get update architect name by company
                var selectzoneid = $('#selectzoneid');
                var selectsalesname = $('#selectsalesname');
                $.ajax({
                    url: 'reporting_srv.asmx/GetDataZoneListsMKT',
                    method: 'post',
                    //data: {
                    //    id: strVal0.text()
                    //},
                    datatype: 'json',
                    success: function (data) {
                        selectzoneid.empty();
                        selectzoneid.append($('<option/>', { value: -1, text: 'Selected team members..' }));
                        selectsalesname.append($('<option/>', { value: -1, text: 'Selected sales members..' }));
                        $(data).each(function (index, item) {
                            selectzoneid.append($('<option/>', { value: item.zone_id, text: item.zone_desc }));
                           
                        });
                    }
                });

                selectzoneid.change(function () {
                    var selectzoneid = $(this).children("option:selected").val();
                    //alert(selectzoneid);
                    //getDataSalesnameWithZoneid(selectzoneid);
                    
                    $.ajax({
                        url: 'reporting_srv.asmx/GetDataSalenameWithZoneid',
                        method: 'post',
                        data: {
                            zoneid: selectzoneid
                        },
                        datatype: 'json',
                        success: function (data) {
                            selectsalesname.empty();
                            selectsalesname.append($('<option/>', { value: -1, text: 'Selected all members..' }));
                            $(data).each(function (index, item) {
                                selectsalesname.append($('<option/>', { value: item.emp_id, text: item.fullname }));
                            });
                            //var table;
                            //table = $('#tblsalecode').DataTable();
                            //table.clear();

                            //if (data != '') {
                            //    $.each(data, function (i, item) {
                            //        table.row.add([data[i].emp_id, data[i].fullname, data[i].position, data[i].zone_desc, data[i].chk]);
                            //    });
                            //}
                            //table.draw();
                            //$('#loademployee').hide();
                        }
                    });
                });

                var btnviewreport = $('#btnViewReport');
                btnviewreport.click(function () {
                    var zoneid = $('#selectzoneid').val();
                    var zonename = $('#selectzoneid option:selected').text();
                    var empcode = $('#selectsalesname').val();
                    var empname = $('#selectsalesname option:selected').text();
                    var docudate = $('#datepickerstart').val();
                    var search = $('#txtsearch').val();

                    getResultReport(zoneid, zonename, empcode, empname, docudate, search);

                });

                var btnPdfStrategic = $('#btnPdfStrategicR2')
                btnPdfStrategic.click(function () {

                    var rpt_id = 'strategicmkt';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);

                });

                var btnRefInv = $('#btnRefInv');
                btnRefInv.click(function () {
                    //alert('test');

                    //$('#example-result').text('');
                    //getDataInvoiceList();

                    $("#modal-refinvoice").modal({ backdrop: false });
                    $("#modal-refinvoice").modal("show");

                });

                 var btncheck = $('#btncheck');
                btncheck.click(function () {

                    // declare variable table for assign attribute
                    var table = $('#tblsalecode').DataTable();
                    var arr = [];
                    var checkedvalues = table.$('input:checked').each(function () {
                        arr.push($(this).attr('id'))
                    });
                    // convert array to string                    

                    arr = arr.toString();
                    var empid = arr.split(",");
                    
                    $('#example-result').text(empid + ',');
                    //table.$('input:checked').removeAttr('checked');  
                    var xempid = $('#example-result').text();

                    $('#txtRefDoc').val(xempid);
                    $("#modal-refinvoice").modal("hide");
                });
                
                var btnuncheck = $('#btnuncheck');
                btnuncheck.click(function () {
                    //alert('uncheck..');
                    var table = $('#tblsalecode').DataTable();                    
                    var checkedvalues = table.$('input:checked').each(function () {
                        $(this).prop("checked", false);
                    });

                    $('#example-result').text('');

                });

                var btncheckedall = $('#btncheckedall')
                btncheckedall.click(function () {
                    //alert('uncheck..');
                    var table = $('#tblsalecode').DataTable();    
                    
                    $("input", table.rows({ search: 'applied' }).nodes()).each(function () {
                        $(this).prop("checked", true);
                    });

                    $('#example-result').text('');
                });
               
            });

            function getResultReport(zoneid, zonename, empcode, empname, docudate, search) {
               // alert(zoneid + zonename + empcode + empname + docudate);

                var today = new Date(docudate);
                var dd = String(today.getDate()).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var monthname = "";
                var yyyy = today.getFullYear();
                var yeartree = yyyy - 2;
                var yeartwo = yyyy - 1;
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                 if (mm == "01") { monthname = "Jan"; }
                else if (mm == "02") { monthname = "Feb"; }
                else if (mm == "03") { monthname = "Mar"; }
                else if (mm == "04") { monthname = "Apr"; }
                else if (mm == "05") { monthname = "May"; }
                else if (mm == "06") { monthname = "Jun"; }
                else if (mm == "07") { monthname = "Jul"; }
                else if (mm == "08") { monthname = "Aug"; }
                else if (mm == "09") { monthname = "Sep"; }
                else if (mm == "10") { monthname = "Oct"; }
                else if (mm == "11") { monthname = "Nov"; }
                else { monthname = "Dec"; }

                console.log(today, dd, mm, monthname, yyyy, yeartwo, yeartree);

                $('#lblTotalTreeYear').text(yeartree);
                $('#lblTotalTwoYear').text(yeartwo);
                $('#lblTotalOneYear').text('Jan-'+monthname+' '+yeartwo);
                $('#lblTotalYearToDate').text('Jan-' + monthname + ' ' + yyyy);
                $('#lbldetailofyear').text(yyyy);

                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetResultReportMKTR2',
                    method: 'post',
                    data: {
                        zoneid: zoneid,
                        zonename: zonename,
                        empcode: empcode,
                        empname: empname,
                        docudate: docudate,
                        search: search
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblResultReport tr td").remove();
                        $("#loaderDivStrategic").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblResultReport').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].seqno, data[i].CustName, data[i].CustProvince, data[i].CusType, data[i].totaltreeyear,
                                    data[i].totaltwoyear, data[i].totalytdlast, data[i].totalytdnow, data[i].variance + "%", data[i].mjan, data[i].mfeb, data[i].mmar,
                                    data[i].mapr, data[i].mmay, data[i].mjun, data[i].mjul, data[i].maug, data[i].msep, data[i].moct, data[i].mnov, data[i].mdec
                                    //data[i].ZoneId, data[i].ZoneName, data[i].EmpCode, data[i].EmpName, data[i].DocuDate
                                ]);
                            });
                        }
                        table.draw();
                        $('#tblResultReport td:nth-of-type(1)').addClass('mycenter');
                        $('#tblResultReport td:nth-of-type(3)').addClass('mycenter');
                        $('#tblResultReport td:nth-of-type(4)').addClass('myclass');
                        $('#tblResultReport td:nth-of-type(5)').addClass('myclass');
                        $('#tblResultReport td:nth-of-type(6)').addClass('myclass');
                        $('#tblResultReport td:nth-of-type(7)').addClass('myclass');
                        $('#tblResultReport td:nth-of-type(8)').addClass('myclass');
                        $('#tblResultReport td:nth-of-type(9)').addClass('myclass');
                        $('#tblResultReport td:nth-of-type(10)').addClass('myclass'); //jan
                        $('#tblResultReport td:nth-of-type(11)').addClass('myclass'); //feb
                        $('#tblResultReport td:nth-of-type(12)').addClass('myclass'); //mar
                        $('#tblResultReport td:nth-of-type(13)').addClass('myclass'); //apr
                        $('#tblResultReport td:nth-of-type(14)').addClass('myclass'); //may
                        $('#tblResultReport td:nth-of-type(15)').addClass('myclass'); //jun
                        $('#tblResultReport td:nth-of-type(16)').addClass('myclass'); //jul
                        $('#tblResultReport td:nth-of-type(17)').addClass('myclass'); //aug
                        $('#tblResultReport td:nth-of-type(18)').addClass('myclass'); //sep
                        $('#tblResultReport td:nth-of-type(19)').addClass('myclass'); //oct
                        $('#tblResultReport td:nth-of-type(20)').addClass('myclass'); //nov
                        $('#tblResultReport td:nth-of-type(21)').addClass('myclass'); //dec
                        //$("#loaderDivStrategic").hide();
                    }
                });


            }

            function loadPDF() {
                var rpt_id = 'resultreportmktr2';
                var zoneid = $('#selectzoneid').val();
                var zonename = $('#selectzoneid option:selected').text();
                var empcode = $('#selectsalesname').val();
                var empname = $('#selectsalesname option:selected').text();
                var docudate = $('#datepickerstart').val();
                var search = $('#txtsearch').val();
                pdfReportRender(rpt_id, zoneid, zonename, empcode, empname, docudate, search);
            }

            function pdfReportRender(rpt_id, zoneid, zonename, empcode, empname, docudate, search) {
                //document.location = "report-render.aspx?id=" + a;
               
                window.open('report-render.aspx?id=' + rpt_id + '&zoneid=' + zoneid + '&zonename=' + zonename+ '&empcode=' + empcode+ '&empname=' + empname+ '&docudate=' + docudate+ '&search=' + search, '_blank');
            }

            function loadExcel() {
                var rpt_id = 'resultreportmktexcelr2';
                var zoneid = $('#selectzoneid').val();
                var zonename = $('#selectzoneid option:selected').text();
                var empcode = $('#selectsalesname').val();
                var empname = $('#selectsalesname option:selected').text();
                var docudate = $('#datepickerstart').val();
                var search = $('#txtsearch').val();
                //pdfReportRender(rpt_id, zoneid, zonename, empcode, empname, docudate, search);

                window.open('report-render.aspx?id=' + rpt_id + '&zoneid=' + zoneid + '&zonename=' + zonename+ '&empcode=' + empcode+ '&empname=' + empname+ '&docudate=' + docudate+ '&search=' + search, '_blank');
            }

            function exportTableToExcel(tableID, filename = '') {
                var downloadLink;
                var dataType = 'application/vnd.ms-excel';
                var tableSelect = document.getElementById(tableID);
                var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

                // Specify file name
                filename = filename ? filename + '.xls' : 'excel_data.xls';

                // Create download link element
                downloadLink = document.createElement("a");

                document.body.appendChild(downloadLink);

                if (navigator.msSaveOrOpenBlob) {
                    var blob = new Blob(['\ufeff', tableHTML], {
                        type: dataType
                    });
                    navigator.msSaveOrOpenBlob(blob, filename);
                } else {
                    // Create a link to the file
                    downloadLink.href = 'data:' + dataType + ', ' + tableHTML;

                    // Setting the file name
                    downloadLink.download = filename;

                    //triggering the function
                    downloadLink.click();
                }
            }

        </script>

        <h1>Marketing Sales Report (MKT) <%--step 1 check pages content name--%>
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner" style="padding-right: 300px;">
                <span class="spinner"></span>
                <div style="position: absolute; padding-top: 80px; color: coral;"><span class="text-white">โปรดรอสักครู่ระบบกำลังประมวลผล....</span></div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary" style="height: 100%;">
                    <div class="box-header">
                        <div class="box-body">

                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Marketing Sales Report (MKT)</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Screen" onclick="window.print()"><i class="fa fa-credit-card"></i></button>
                                                <button id="btnExportExcel" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                            </span>
                                        </span>

                                    </span>
                                    <span class="description">Year To Date Reports</span>
                                </div>
                            </div>
                        </div>
                    </div>


                    <%-- <%--step 2 design user interface ui below--%>
                    <div class="box-body">

                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="txtLabel">Sale Team :</label>
                                <div class="txtLabel">
                                    <span>
                                        <select id="selectzoneid" name="selectzoneid" class="form-control input-sm" style="width: 100%">
                                            
                                        </select>
                                    </span>

                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="txtLabel">Sales Name :</label>
                                <div class="txtLabel">
                                    <span>
                                        <select id="selectsalesname" name="selectsalesname" class="form-control input-sm" style="width: 100%">
                                        </select>
                                    </span>
                                </div>
                                <%--<div class="input-group">
                                    <input type="text" id="txtRefDoc" name="txtRefDoc" readonly class="form-control  input ">
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-info btn-flat" id="btnRefInv" name="btnRefInv">Go!</button>
                                    </span>
                                </div>--%>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Report Date:</label>
                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right" id="datepickerstart" name="datepickerstart" autocomplete="off" value="">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Keyword:</label>
                                <div class="">
                                    <input type="text" class="form-control pull-right" id="txtsearch" name="txtsearch" autocomplete="off" value="">                                    
                                </div>
                            </div>
                        </div>
                       

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">View Report</label>
                                <div class="input-group date">
                                    <input type="button" id="btnViewReport" name="btnViewReport" class="btn btn-info btn-flat btn-block btn-sm" value="Show Report Here" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


          
            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-primary"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdfResultReport" onclick="loadPDF()" class="btn btn-default  btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcelResultReport" onclick="loadExcel()" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">Marketing Sales Report</label>
                        </div>
                        <div class="box-body">
                            <table id="tblResultReport" class="table table-striped table-bordered table-hover " style="width: 100%">
                                <thead>
                                    <tr>
                                        <th colspan="3" style="text-align: center;vertical-align: central;">Customers</th>                                       
                                       
                                        <th rowspan="2" style="text-align: center; vertical-align: middle;">Type</th>
                                        <th colspan="2" style="text-align: center;vertical-align: central;">TOTAL</th>
                                        
                                        <th colspan="2" style="text-align: center;vertical-align: central;">YTD</th>
                                        
                                        <th rowspan="2" style="text-align: center; vertical-align: middle;">Variance</th>
                                        <th colspan="12" style="text-align: center; vertical-align: middle;">Details Of Year <label id="lbldetailofyear"></label></th>
                                        
                                        <%--<th class="hidden">ZoneId</th>
                                        <th class="hidden">ZoneName</th>
                                        <th class="hidden">EmpCode</th>
                                        <th class="hidden">EmpName</th>
                                        <th class="hidden">DocuDate</th>--%>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;vertical-align: central;">No</th>
                                        <th style="text-align: center;vertical-align: central;">Customer</th>
                                        <th style="text-align: center;vertical-align: central;">Province</th>
                                       
                                        <th style="text-align: center;vertical-align: central;"><label id="lblTotalTreeYear"></label></th>
                                        <th style="text-align: center;vertical-align: central;"><label id="lblTotalTwoYear"></label></th>
                                        <th style="text-align: center;vertical-align: central;"><label id="lblTotalOneYear"></label></th>
                                        <th style="text-align: center;vertical-align: central;"><label id="lblTotalYearToDate"></label></th>
                                        
                                        <th style="text-align: center;vertical-align: central;">Jan</th>
                                        <th style="text-align: center;vertical-align: central;">Feb</th>
                                        <th style="text-align: center;vertical-align: central;">Mar</th>
                                        <th style="text-align: center;vertical-align: central;">Apr</th>
                                        <th style="text-align: center;vertical-align: central;">May</th>
                                        <th style="text-align: center;vertical-align: central;">Jun</th>
                                        <th style="text-align: center;vertical-align: central;">Jul</th>
                                        <th style="text-align: center;vertical-align: central;">Aug</th>
                                        <th style="text-align: center;vertical-align: central;">Sep</th>
                                        <th style="text-align: center;vertical-align: central;">Oct</th>
                                        <th style="text-align: center;vertical-align: central;">Nov</th>
                                        <th style="text-align: center;vertical-align: central;">Dec</th>
                                        <%--<th class="hidden">ZoneId</th>
                                        <th class="hidden">ZoneName</th>
                                        <th class="hidden">EmpCode</th>
                                        <th class="hidden">EmpName</th>
                                        <th class="hidden">DocuDate</th>--%>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

            <div class="modal modal-default fade" id="modal-refinvoice">
                <div class="modal-dialog" style="width: 60%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Sales team member</h4>
                        </div>
                        <div class="modal-body">
                            <!-- Post -->
                            <div class="post">
                                <table id="tblsalecode" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th>EmpCode</th>
                                            <th>Salename</th>
                                            <th>Position</th>
                                            <th>Description</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>

                                <div id="loademployee">
                                    <div class="cv-spinner">
                                        <span class="spinner"></span>
                                    </div>
                                </div>

                                <p>
                                    <button type="button" id="btnuncheck" name="btnuncheck" class="btn btn-warning btn-sm btn-flat">Clear All</button>
                                    <button type="button" id="btncheckedall" name="btncheckedall" class="btn btn-primary btn-sm btn-flat">Selected All</button>
                                    <button type="button" id="btncheck" name="btncheck" class="btn btn-success btn-sm btn-flat pull-right">Confirmed</button>
                                </p>
                                <p id="example-result"></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>


        </div>
    </section>
</asp:Content>
