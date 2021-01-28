<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="screw-report.aspx.cs" Inherits="totalsale_report.xreporting.screw_report" %>
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
                $('#loaderDiv1015').hide();
                $('#loaderDiv1038').hide();
                $('#loaderDiv1016').hide();
                $('#loaderDiv1039').hide();

                var ssdate = localStorage.getItem('sdate');
                var eedate = localStorage.getItem('edate');

                $('#datepickerstart').val(ssdate);
                $('#datepickerend').val(eedate);

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031                   

                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1015(sdate, edate);
                    getReprot1038(sdate, edate);
                    getReprot1016(sdate, edate);
                    getReprot1039(sdate, edate);

                });

                var btnExcel1015 = $('#btnExcel1015')
                btnExcel1015.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1015] Screw Ferrex (ส่วนกลาง)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1015', filefulname)
                });

                var btnExcel1038 = $('#btnExcel1038')
                btnExcel1038.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1038] Screw Ferrex (ส่วนภูมิภาค)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1038', filefulname)
                });

                var btnExcel1016 = $('#btnExcel1016')
                btnExcel1016.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1016] Screw Arrex (ส่วนกลาง)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1016', filefulname)
                });

                var btnExcel1039 = $('#btnExcel1039')
                btnExcel1039.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1039] Screw Arrex (ส่วนภูมิภาค)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1039', filefulname)
                });

                var btnPdf1015 = $('#btnPdf1015')
                btnPdf1015.click(function () {

                    var rpt_id = '1015';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1038 = $('#btnPdf1038')
                btnPdf1038.click(function () {

                    var rpt_id = '1038';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1016 = $('#btnPdf1016')
                btnPdf1016.click(function () {

                    var rpt_id = '1016';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1039 = $('#btnPdf1039')
                btnPdf1039.click(function () {

                    var rpt_id = '1039';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'totalscrew';
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

            function pdfReportRender(rpt_id, sdate, edate) {
                //document.location = "report-render.aspx?id=" + a;
                window.open('report-render.aspx?id=' + rpt_id + '&sdate=' + sdate + '&edate=' + edate, '_blank');
            }

            function getReprot1015(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1015',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1015 tr td").remove(); 
                        $("#loaderDiv1015").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1015').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].ferrexScrew, data[i].ferrexWasher, data[i].louvreFX, data[i].exColor
                                    , data[i].saleTotal, data[i].shareSales, data[i].exReserve, data[i].cutCN, data[i].cutDN, data[i].cutComm, data[i].cutTrans, data[i].netSales
                                    , data[i].overSixtyDay, data[i].cutNetSales, data[i].grandTotal, data[i].exAccessories]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1015 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1015 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1015 td:nth-of-type(20)').addClass('myclass');
                        $("#loaderDiv1015").hide();
                    }
                });
            }

            function getReprot1038(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1038',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1038 tr td").remove(); 
                        $("#loaderDiv1038").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1038').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].ferrexScrew, data[i].ferrexWasher, data[i].louvreFX, data[i].exColor
                                    , data[i].saleTotal, data[i].shareSales, data[i].exReserve, data[i].cutCN, data[i].cutDN, data[i].cutComm, data[i].cutTrans, data[i].netSales
                                    , data[i].overSixtyDay, data[i].cutNetSales, data[i].grandTotal, data[i].exAccessories]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1038 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1038 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1038 td:nth-of-type(20)').addClass('myclass');
                        $("#loaderDiv1038").hide();
                    }
                });
            }

            function getReprot1016(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1016',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1016 tr td").remove(); 
                        $("#loaderDiv1016").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1016').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].correxScrew, data[i].arrexScrew, data[i].terrexScrew, data[i].louvreAX
                                    , data[i].saleTotal, data[i].shareSales, data[i].exReserve, data[i].cutCN, data[i].cutDN, data[i].cutComm, data[i].cutTrans, data[i].netSales
                                    , data[i].overSixtyDay, data[i].cutNetSales, data[i].grandTotal, data[i].exAccessories]);                               
                            });
                        }
                        table.draw();
                        $('#tblReprot1016 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1016 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1016 td:nth-of-type(20)').addClass('myclass');
                        $("#loaderDiv1016").hide();
                    }
                });
            }

            function getReprot1039(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1039',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1039 tr td").remove(); 
                        $("#loaderDiv1039").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1039').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].emp_id, data[i].EmpName, data[i].correxScrew, data[i].arrexScrew, data[i].terrexScrew, data[i].louvreAX
                                    , data[i].saleTotal, data[i].shareSales, data[i].exReserve, data[i].cutCN, data[i].cutDN, data[i].cutComm, data[i].cutTrans, data[i].netSales
                                    , data[i].overSixtyDay, data[i].cutNetSales, data[i].grandTotal, data[i].exAccessories]);                               
                            });
                        }
                        table.draw();
                        $('#tblReprot1039 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1039 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1039 td:nth-of-type(20)').addClass('myclass');
                        $("#loaderDiv1039").hide();
                    }
                });
            }

        </script>

        <h1>Screw Reports <%--step 1 check pages content name--%>
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
                                        <a href="#">Screw Report</a>
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
                            <i class="fa fa-flag-checkered text-orange"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1015" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1015" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1015] Screw Ferrex (ส่วนกลาง)</label>
                        </div>
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1015">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1015" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">Ferrex Screw</th>
                                        <th class="">Ferrex Washer</th>
                                        <th class="">Louvre FX</th>
                                        <th class="">ค่าทำหัวสี</th>
                                        <th class="">SaleToal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">จ่ายแทน</th>
                                        <th class="">หักส่วนลดจ่าย</th>
                                        <th class="">รับคืน/ลดหนี้</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักค่าขนส่ง</th>
                                        <th class="">Net Sales</th>
                                        <th class="">หักชำระเกิน 60วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Accessories</th>
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
                            <i class="fa fa-flag-checkered text-green"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1038" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1038" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1038] Screw Ferrex (ส่วนภูมิภาค)</label>
                        </div>
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1038">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1038" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">Ferrex Screw</th>
                                        <th class="">Ferrex Washer</th>
                                        <th class="">Louvre FX</th>
                                        <th class="">ค่าทำหัวสี</th>
                                        <th class="">SaleToal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">จ่ายแทน</th>
                                        <th class="">หักส่วนลดจ่าย</th>
                                        <th class="">รับคืน/ลดหนี้</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักค่าขนส่ง</th>
                                        <th class="">Net Sales</th>
                                        <th class="">หักชำระเกิน 60วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Accessories</th>
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
                                <button type="button" id="btnPdf1016" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1016" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1016] Screw Arrex (ส่วนกลาง)</label>
                        </div>

                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1016">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1016" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">Correx Screw</th>
                                        <th class="">Arrex Screw</th>
                                        <th class="">Terrex Screw</th>
                                        <th class="">Louvre Strap AX</th>
                                        <th class="">SaleToal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">จ่ายแทน</th>
                                        <th class="">หักส่วนลดจ่าย</th>
                                        <th class="">รับคืน/ลดหนี้</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักค่าขนส่ง</th>
                                        <th class="">Net Sales</th>
                                        <th class="">หักชำระเกิน 60วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Accessories</th>
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
                                <button type="button" id="btnPdf1039" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1039" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1039] Screw Arrex (ส่วนภูมิภาค)</label>
                        </div>

                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1039">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1039" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">id</th>
                                        <th class="">No</th>
                                        <th class="">emp_id</th>
                                        <th class="">EmpName</th>
                                        <th class="">Correx Screw</th>
                                        <th class="">Arrex Screw</th>
                                        <th class="">Terrex Screw</th>
                                        <th class="">Louvre Strap AX</th>
                                        <th class="">SaleToal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">จ่ายแทน</th>
                                        <th class="">หักส่วนลดจ่าย</th>
                                        <th class="">รับคืน/ลดหนี้</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักค่าขนส่ง</th>
                                        <th class="">Net Sales</th>
                                        <th class="">หักชำระเกิน 60วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Accessories</th>
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
