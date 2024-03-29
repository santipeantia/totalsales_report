﻿<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="other-report.aspx.cs" Inherits="totalsale_report.xreporting.other_report" %>

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
                $('#loaderDiv1026').hide();
                $('#loaderDiv1027').hide();
                $('#loaderDiv1028').hide();
                
                var ssdate = localStorage.getItem('sdate');
                var eedate = localStorage.getItem('edate');

                $('#datepickerstart').val(ssdate);
                $('#datepickerend').val(eedate);

                //todo something here

                 var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1026(sdate, edate);
                    getReprot1027(sdate, edate);    
                    getReprot1028(sdate, edate); 

                });

                var btnExcel1026 = $('#btnExcel1026')
                btnExcel1026.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1026] SalesNoComm' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1026', filefulname)
                });

                var btnExcel1027 = $('#btnExcel1027')
                btnExcel1027.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1027] KansadCenter' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1027', filefulname)
                });

                var btnExcel1028 = $('#btnExcel1028')
                btnExcel1028.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1028] Outlet' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1028', filefulname)
                });

                var btnPdf1026 = $('#btnPdf1026')
                btnPdf1026.click(function () {

                    var rpt_id = '1026';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1027 = $('#btnPdf1027')
                btnPdf1027.click(function () {

                    var rpt_id = '1027';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1028 = $('#btnPdf1028')
                btnPdf1028.click(function () {

                    var rpt_id = '1028';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'otherreport';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });
            });


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
                window.open('report-render.aspx?id=' + rpt_id + '&sdate=' + sdate + '&edate=' + edate, '_blank');
            }

            function getReprot1026(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1026',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1026 tr td").remove();
                        $("#loaderDiv1026").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1026').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].MAmpelite, data[i].MRooflite, data[i].TAmpelite, data[i].TRooflite,
                                    data[i].MTSunnyNeo, data[i].MtOem, data[i].DLite, data[i].Amperam, data[i].FerrexScrew, data[i].ArrexScrew,
                                    data[i].CorrexScrew, data[i].Accessories, data[i].SaleTotal, data[i].cutNetCN, data[i].cutNetComm, data[i].GrandTotal]);
                            });
                        }
                        table.draw();
                        //$('#tblReprot1026 td:nth-of-type(1)').addClass('mycenter');
                        $('#tblReprot1026 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1026 td:nth-of-type(18)').addClass('myclass');
                        $("#loaderDiv1026").hide();
                    }
                });
            }

            function getReprot1027(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1027',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1027 tr td").remove();
                        $("#loaderDiv1027").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1027').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].Amperam, data[i].AmperamService, data[i].kansadOther,
                                    data[i].dliteWave, data[i].dliteSmooth, data[i].dliteWaveService, data[i].dliteSmoothService, data[i].Flashing,
                                    data[i].all_equipment, data[i].construction, data[i].xservice, data[i].Ferrex, data[i].Arrex, data[i].Accessories,
                                    data[i].SaleTotal, data[i].cutCN, data[i].NetSales, data[i].cutNetSales, data[i].GrandTotal]);
                            });
                        }
                        table.draw();
                        //$('#tblReprot1026 td:nth-of-type(1)').addClass('mycenter');
                        $('#tblReprot1027 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1027 td:nth-of-type(20)').addClass('myclass');
                        $("#loaderDiv1027").hide();
                    }
                });
            }

            function getReprot1028(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1028',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1028 tr td").remove();
                        $("#loaderDiv1028").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1028').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].DLiteWave, data[i].DLiteSmooth, data[i].DLiteB, data[i].DLite4R,
                                    data[i].Frp, data[i].FrpB, data[i].Ferrex, data[i].FerrexWasher, data[i].Arrex, data[i].Silicone, data[i].Accessories,
                                    data[i].SaleTotal, data[i].cutCN, data[i].NetSales, data[i].cutNetSales, data[i].GrandTotal]);
                            });
                        }
                        table.draw();
                        //$('#tblReprot1026 td:nth-of-type(1)').addClass('mycenter');
                        $('#tblReprot1028 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1028 td:nth-of-type(18)').addClass('myclass');
                        $("#loaderDiv1028").hide();
                    }
                });
            }

        </script>

        <h1>Other Reports <%--step 1 check pages content name--%>
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
                                        <a href="#">Other Report</a>
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
                                    <input type="text" class="form-control pull-right" disabled id="datepickerstart">
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
                                    <input type="text" class="form-control pull-right" disabled id="datepickerend">
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

            <div class="col-md-12">

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-red"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1026" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1026" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1026] Sales No Comm</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1026">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1026" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>                                    
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">M-Ampelite</th>
                                        <th class="">M-Rooflite</th>
                                        <th class="">T-Ampelite</th>
                                        <th class="">T-Rooflite</th>
                                        <th class="">M/T Sunny Neo</th>
                                        <th class="">Oem</th>                                        
                                        <th class="">D-Lite</th>
                                        <th class="">Amperam</th>
                                        <th class="">Ferrex</th>
                                        <th class="">Arrex</th>
                                        <th class="">Correx</th>
                                        <th class="">Accessories</th>
                                        <th class="">SaleTotal</th>
                                        <th class="">หักCN/ส่วนลดบิล</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">Grand Total</th>
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
                                <button type="button" id="btnPdf1027" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1027" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1027] KANSAD CENTER</label>
                        </div>
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1027">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1027" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">Amperam</th>
                                        <th class="">Amperam/ติดตั้ง</th>
                                        <th class="">กันสาดอื่นๆ</th>
                                        <th class="">D-Lite ลอนคลื่น</th>
                                        <th class="">D-Lite ลอนเรียบ</th>
                                        <th class="">D-Lite ลอนคลื่นติดตั้ง</th>
                                        <th class="">D-Lite ลอนเรียบติดตั้ง</th>
                                        <th class="">Flashing</th>
                                        <th class="">อุปกรณ์อื่นๆ</th>
                                        <th class="">ค่าโครงสร้าง</th>
                                        <th class="">ค่าแรงบริการ</th>
                                        <th class="">Ferrex</th>
                                        <th class="">Arrex</th>
                                        <th class="">Accessories</th>
                                        <th class="">Sale Total</th>
                                        <th class="">หักCN/ส่วนลดบิล</th>
                                        <th class="">Net Sales</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">Grand Total</th>                                       
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
                            <i class="fa fa-flag-checkered text-blue"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1028" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1028" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1028] OUTLET</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1028">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1028" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>                                    
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">DLiteWave</th>
                                        <th class="">DLiteSmooth</th>
                                        <th class="">DLiteB</th>
                                        <th class="">DLite4R</th>
                                        <th class="">Frp</th>
                                        <th class="">FrpB</th>
                                        <th class="">Ferrex</th>
                                        <th class="">FerrexWasher</th>
                                        <th class="">Arrex</th>
                                        <th class="">Silicone</th>
                                        <th class="">Accessories</th>
                                        <th class="">SaleTotal</th>
                                        <th class="">cutCN</th>
                                        <th class="">NetSales</th>
                                        <th class="">cutNetSales</th>
                                        <th class="">GrandTotal</th>
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
