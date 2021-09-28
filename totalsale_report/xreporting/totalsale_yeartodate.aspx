<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="totalsale_yeartodate.aspx.cs" Inherits="totalsale_report.xreporting.totalsale_yeartodate" %>
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
            .myleft {
                text-align: left;
                font-size: medium;
                font-weight: normal;
            }

             .myright {
                text-align: right;
                font-size: medium;
                font-weight: normal;
            }

            .mycenter {
                text-align: center;
                font-size: medium;
                font-weight: bold;
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
                               
                $('#lblTotalTreeYear1').text(yeartree);
                $('#lblTotalTwoYear1').text(yeartwo);
                $('#lblTotalOneYear1').text('Jan-'+monthname+' '+yeartwo);
                $('#lblTotalYearToDate1').text('Jan-' + monthname + ' ' + yyyy);
                $('#lbldetailofyear1').text(yyyy);

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
                    $('#txtRefDoc').val('');
                    $('#example-result').text('');

                    $.ajax({
                        url: 'reporting_srv.asmx/GetDataSalenameWithZoneid',
                        method: 'post',
                        data: {
                            zoneid: selectzoneid
                        },
                        beforeSend: function() {
                            $('#loademployee').show();
                        },
                        datatype: 'json',
                        success: function (data) {
                            //selectsalesname.empty();
                            //selectsalesname.append($('<option/>', { value: -1, text: 'Selected all members..' }));
                            //$(data).each(function (index, item) {
                            //    selectsalesname.append($('<option/>', { value: item.emp_id, text: item.fullname }));
                            //});
                            var table;
                            table = $('#tblsalecode').DataTable();
                            table.clear();

                            if (data != '') {
                                $.each(data, function (i, item) {
                                    table.row.add([data[i].emp_id, data[i].fullname, data[i].position, data[i].zone_desc, data[i].chk]);
                                });
                            }
                            table.draw();
                             $('#loademployee').hide();
                        }
                    });
                });

                var btnviewreport = $('#btnViewReport');
                btnviewreport.click(function () {
                    var rpt_id = 'resultreportyeartodatepdf';
                    var yearstart = $('#datepickerstart').val();
                    var yearend = $('#datepickerend').val();

                    var monthstart = $('#datepickerstart').val();
                    var monthend = $('#datepickerstart').val();

                    var sday = new Date(yearstart);
                    var sdd = String(sday.getDate()).padStart(2, '0');
                    var smm = String(sday.getMonth() + 1).padStart(2, '0');
                    var syyyy = sday.getFullYear();

                    var eday = new Date(yearend);
                    var edd = String(eday.getDate()).padStart(2, '0');
                    var emm = String(eday.getMonth() + 1).padStart(2, '0');
                    var eyyyy = eday.getFullYear();

                    var snamemonth = ''
                    if (smm == '01') { snamemonth = 'Jan'; }
                    else if (smm == '02') { snamemonth = 'Feb'; }
                    else if (smm == '03') { snamemonth = 'Mar'; }
                    else if (smm == '04') { snamemonth = 'Apr'; }
                    else if (smm == '05') { snamemonth = 'May'; }
                    else if (smm == '06') { snamemonth = 'Jun'; }
                    else if (smm == '07') { snamemonth = 'Jul'; }
                    else if (smm == '08') { snamemonth = 'Aug'; }
                    else if (smm == '09') { snamemonth = 'Sep'; }
                    else if (smm == '10') { snamemonth = 'Oct'; }
                    else if (smm == '11') { snamemonth = 'Nov'; }
                    else { snamemonth = 'Dec'; }

                    var sfullnamemonth = snamemonth + '-' + syyyy;

                    var enamemonth = ''
                    if (emm == '01') { enamemonth = 'Jan'; }
                    else if (emm == '02') { enamemonth = 'Feb'; }
                    else if (emm == '03') { enamemonth = 'Mar'; }
                    else if (emm == '04') { enamemonth = 'Apr'; }
                    else if (emm == '05') { enamemonth = 'May'; }
                    else if (emm == '06') { enamemonth = 'Jun'; }
                    else if (emm == '07') { enamemonth = 'Jul'; }
                    else if (emm == '08') { enamemonth = 'Aug'; }
                    else if (emm == '09') { enamemonth = 'Sep'; }
                    else if (emm == '10') { enamemonth = 'Oct'; }
                    else if (emm == '11') { enamemonth = 'Nov'; }
                    else { enamemonth = 'Dec'; }

                    var efullnamemonth = enamemonth + '-' + eyyyy;

                    $('#sfullmonthname').text(sfullnamemonth);
                    $('#efullmonthname').text(efullnamemonth);

                    $('#sfullmonthnamesale').text(sfullnamemonth);
                    $('#efullmonthnamesale').text(efullnamemonth);


                    getResultReportYearToDatebyProduct(syyyy, eyyyy, smm, emm);
                    getResultReportYearToDatebySales(syyyy, eyyyy, smm, emm);


                });

                var btnPdfStrategic = $('#btnPdfStrategicR2')
                btnPdfStrategic.click(function () {

                    var rpt_id = 'strategic';
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

            function getResultReportYearToDatebyProduct(yearstart, yearend, monthstart, monthend) {
               // alert(zoneid + zonename + empcode + empname + docudate);

                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetResultReportYeartodateByProduct',
                    method: 'post',
                    data: {
                        yearstart: yearstart,
                        yearend: yearend,
                        monthstart: monthstart,                       
                        monthend: monthend
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblResultReportByProduct tr td").remove();
                        $("#loaderDivStrategic").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblResultReportByProduct').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].prodname, data[i].totalsales, data[i].netsales, data[i].grandsales]);

                            });
                        }
                        table.draw();
                        $('#tblResultReportByProduct td:nth-of-type(1)').addClass('myleft');
                        $('#tblResultReportByProduct td:nth-of-type(2)').addClass('myleft');
                        $('#tblResultReportByProduct td:nth-of-type(3)').addClass('myright');
                        $('#tblResultReportByProduct td:nth-of-type(4)').addClass('myright');
                        $('#tblResultReportByProduct td:nth-of-type(5)').addClass('myright');

                        //$("#loaderDivStrategic").hide();
                    }
                });


            }

            function getResultReportYearToDatebySales(yearstart, yearend, monthstart, monthend) {
               // alert(zoneid + zonename + empcode + empname + docudate);

                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetResultReportYeartodateBySales',
                    method: 'post',
                    data: {
                        yearstart: yearstart,
                        yearend: yearend,
                        monthstart: monthstart,                       
                        monthend: monthend
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblResultReportBySales tr td").remove();
                        $("#loaderDivStrategic").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblResultReportBySales').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].prodname, data[i].totalsales, data[i].netsales, data[i].grandsales]);

                            });
                        }
                        table.draw();
                        $('#tblResultReportBySales td:nth-of-type(1)').addClass('myleft');
                        $('#tblResultReportBySales td:nth-of-type(2)').addClass('myleft');
                        $('#tblResultReportBySales td:nth-of-type(3)').addClass('myright');
                        $('#tblResultReportBySales td:nth-of-type(4)').addClass('myright');
                        $('#tblResultReportBySales td:nth-of-type(5)').addClass('myright');

                        //$("#loaderDivStrategic").hide();
                    }
                });


            }

            function loadPDF() {               

                var rpt_id = 'resultreportyeartodatepdf';
                var yearstart = $('#datepickerstart').val();
                var yearend = $('#datepickerend').val();

                var monthstart = $('#datepickerstart').val();
                var monthend = $('#datepickerstart').val();

                var sday = new Date(yearstart);
                var sdd = String(sday.getDate()).padStart(2, '0');
                var smm = String(sday.getMonth() + 1).padStart(2, '0');
                var syyyy = sday.getFullYear();

                var eday = new Date(yearend);
                var edd = String(eday.getDate()).padStart(2, '0');
                var emm = String(eday.getMonth() + 1).padStart(2, '0');
                var eyyyy = eday.getFullYear();
  
               window.open('report-render.aspx?id=' + rpt_id + '&yearstart=' + syyyy + '&yearend=' + eyyyy+ '&monthstart=' + smm+'&monthend=' + emm , '_blank');
            }

            function loadExcel() {
                var rpt_id = 'resultreportyeartodateexcel';
                var yearstart = $('#datepickerstart').val();
                var yearend = $('#datepickerend').val();

                var monthstart = $('#datepickerstart').val();
                var monthend = $('#datepickerstart').val();

                var sday = new Date(yearstart);
                var sdd = String(sday.getDate()).padStart(2, '0');
                var smm = String(sday.getMonth() + 1).padStart(2, '0');
                var syyyy = sday.getFullYear();

                var eday = new Date(yearend);
                var edd = String(eday.getDate()).padStart(2, '0');
                var emm = String(eday.getMonth() + 1).padStart(2, '0');
                var eyyyy = eday.getFullYear();
  
               window.open('report-render.aspx?id=' + rpt_id + '&yearstart=' + syyyy + '&yearend=' + eyyyy+ '&monthstart=' + smm+'&monthend=' + emm , '_blank');
            }


        </script>

        <h1>Total Sales Year to Date <%--step 1 check pages content name--%>
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
                                        <a href="#">Total Sales Year to Date</a>
                                        

                                    </span>
                                    <span class="description">Year To Date Reports</span>
                                </div>
                            </div>
                        </div>
                    </div>


                    <%-- <%--step 2 design user interface ui below--%>
                    <div class="box-body">


                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Start Date:</label>
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
                                <label class="txtLabel">End Date:</label>
                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right" id="datepickerend" name="datepickerend" autocomplete="off" value="">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
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


          
            <div class="col-md-6">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-primary"></i>

                            <label class="txtLabel">สรุปยอดขายแยกประเภทสินค้าตั้งแต่ <span id="sfullmonthname"></span> to <span id="efullmonthname"></span></label>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdfResultReportSum" onclick="loadPDF()" class="btn btn-default  btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcelResultReportSum" onclick="loadExcel()" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                        </div>
                        <div class="box-body">
                            <table id="tblResultReportByProduct" class="table table-striped table-bordered table-hover " style="width: 100%">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; vertical-align: central;">ID</th>
                                        <th style="text-align: center; vertical-align: central;">Products</th>
                                        <th style="text-align: center; vertical-align: central;">Total Sales</th>
                                        <th style="text-align: center; vertical-align: central;">Net Sales</th>
                                        <th style="text-align: center; vertical-align: central;">Grand Sales</th>                                        
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-md-6">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-hand-o-right text-warning"></i>

                            <label class="txtLabel">สรุปยอดขายแยกประเภททีมขายตั้งแต่ <span id="sfullmonthnamesale"></span> to <span id="efullmonthnamesale"></span></label>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdfResultReportSumSale" onclick="loadPDFSale()" class="btn btn-default  btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcelResultReportSumSale" onclick="loadExcelSale()" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                        </div>
                        <div class="box-body">
                            <table id="tblResultReportBySales" class="table table-striped table-bordered table-hover " style="width: 100%">
                                <thead>
                                    <tr>
                                        <th style="text-align: center; vertical-align: central;">ID</th>
                                        <th style="text-align: center; vertical-align: central;">Products</th>
                                        <th style="text-align: center; vertical-align: central;">Total Sales</th>
                                        <th style="text-align: center; vertical-align: central;">Net Sales</th>
                                        <th style="text-align: center; vertical-align: central;">Grand Sales</th>                                        
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
    </section>
</asp:Content>
