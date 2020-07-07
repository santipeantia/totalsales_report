<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="totalscrew-report.aspx.cs" Inherits="totalsale_report.xreporting.totalscrew_report" %>

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

            #tblprojectlists i:hover {
                cursor: pointer;
            }

            #tbltranswithoutsalesconsignee i:hover {
                cursor: pointer;
            }

            #overlay {
                position: fixed;
                top: 0;
                z-index: 100;
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
                $('#loaderDiv1017').hide();
                $('#loaderDiv1040').hide();
                $('#loaderDiv1041').hide();
                $('#loaderDiv1018').hide();

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1017(sdate, edate);
                    getReprot1040(sdate, edate);
                    getReprot1041(sdate, edate);
                    getReprot1018(sdate, edate);
                });

                var btnExcel1017 = $('#btnExcel1017')
                btnExcel1017.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1017] Total Screw' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1017', filefulname)
                });

                var btnExcel1018 = $('#btnExcel1018')
                btnExcel1018.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1018] Screw Team (กิตติศักดิ์)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1018', filefulname)
                });
                
                var btnExcel1040 = $('#btnExcel1040')
                btnExcel1040.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1040] Total Screw(ศิรัส)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1040', filefulname)
                });
                
                var btnExcel1041 = $('#btnExcel1041')
                btnExcel1041.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1041] Total Screw(ส่วนภูมิภาค)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1041', filefulname)
                });

                var btnPdf1017 = $('#btnPdf1017')
                btnPdf1017.click(function () {

                    var rpt_id = '1017';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1018 = $('#btnPdf1018')
                btnPdf1018.click(function () {

                    var rpt_id = '1018';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1040 = $('#btnPdf1040')
                btnPdf1040.click(function () {

                    var rpt_id = '1040';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1041 = $('#btnPdf1041')
                btnPdf1041.click(function () {

                    var rpt_id = '1041';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'screwreport';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

            });

            function exportexcel() {
                $('#tblReprot1017').table2excel({
                    name: "tblReprot1017",
                    filename: "myFileName",
                    fileext: ".xls"
                });
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

            function pdfReportRender(rpt_id, sdate, edate) {
                //document.location = "report-render.aspx?id=" + a;
                window.open('report-render.aspx?id=' + rpt_id + '&sdate=' + sdate + '&edate=' + edate, '_blank');
            }

            jQuery(function ($) {
                $(document).ajaxSend(function () {
                    $("#overlay").fadeIn(300);
                });

                $('#btnViewReport').click(function () {
                    $.ajax({
                        type: 'GET',
                        success: function (data) {
                            console.log(data);
                        }
                    }).done(function () {
                        setTimeout(function () {
                            $("#overlay").fadeOut(300);
                        }, 500);
                    });
                });
            });

            function getReprot1017(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1017',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                     beforeSend: function () {
                        $("#tblReprot1017 tr td").remove();
                        $("#loaderDiv1017").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1017').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].TeamGroup, data[i].TeamName, data[i].ferrexScrew
                                    , data[i].arrexScrew, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].perCent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1017 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1017 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1017 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1017 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1017 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1017 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1017 td:nth-of-type(12)').addClass('myclass');
                        $("#loaderDiv1017").hide();
                    }
                });
            }

            function getReprot1040(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1040',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1040 tr td").remove();
                        $("#loaderDiv1040").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1040').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].TeamGroup, data[i].TeamName, data[i].ferrexScrew
                                    , data[i].arrexScrew, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1040 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1040 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1040 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1040 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1040 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1040 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1040 td:nth-of-type(12)').addClass('myclass');
                        $("#loaderDiv1040").hide();
                    }
                });
            }

            function getReprot1041(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1041',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1041 tr td").remove();
                        $("#loaderDiv1041").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1041').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].TeamGroup, data[i].TeamName, data[i].ferrexScrew
                                    , data[i].arrexScrew, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1041 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1041 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1041 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1041 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1041 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1041 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1041 td:nth-of-type(12)').addClass('myclass');
                        $("#loaderDiv1041").hide();
                    }
                });
            }

            function getReprot1018(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1018',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1018 tr td").remove();
                        $("#loaderDiv1018").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1018').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].emp_id, data[i].EmpName, data[i].ferrexScrew, data[i].arrexScrew, data[i].GrandTotal
                                    , data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1018 td:nth-of-type(1)').addClass('mycenter');
                        $('#tblReprot1018 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1018 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1018 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1018 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1018 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1018 td:nth-of-type(9)').addClass('myclass');
                        $("#loaderDiv1018").hide();
                    }
                });
            }

        </script>

        <h1>Total Screw Reports <%--step 1 check pages content name--%>
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
        <div id="overlay">
            <div class="cv-spinner">
                <span class="spinner"></span>
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
                                        <a href="#">Total Screw Report</a>
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
                                    <span class="description">Monitoring progression of projects</span>
                                </div>
                            </div>
                        </div>
                    </div>


                    <%-- <%--step 2 design user interface ui below--%>
                    <div class="box-body">

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Date Start:</label>
                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right" id="datepickerstart">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label class="txtLabel">Date End:</label>
                                <div class="input-group date">
                                    <input type="text" class="form-control pull-right" id="datepickerend">
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
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1017" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1017" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1017] Total Screw (ส่วนกลาง)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1017">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1017" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">EmpName</th>
                                        <th class="">TeamGroup</th>
                                        <th class="">TeamName</th>
                                        <th class="">ferrexScrew</th>
                                        <th class="">arrexScrew</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                        <th class="">perCent</th>

                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-yellow"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1040" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1040" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1040] Total Screw (ศิรัส)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1040">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1040" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">TeamGroup</th>
                                        <th class="">TeamName</th>
                                        <th class="">ferrexScrew</th>
                                        <th class="">arrexScrew</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                        <th class="">perCent</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-red"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1041" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1041" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1041]  Total Screw (ส่วนภูมิภาค)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1041">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1041" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">TeamGroup</th>
                                        <th class="">TeamName</th>
                                        <th class="">ferrexScrew</th>
                                        <th class="">arrexScrew</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                        <th class="">perCent</th>
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
                            <i class="fa fa-flag-checkered text-green"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1018" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1018" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1018] Screw Team (กิตติศักดิ์)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1018">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1018" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">ferrexScrew</th>
                                        <th class="">arrexScrew</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                        <th class="">Percent</th>
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
