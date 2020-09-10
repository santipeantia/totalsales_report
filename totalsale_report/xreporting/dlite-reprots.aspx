<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="dlite-reprots.aspx.cs" Inherits="totalsale_report.xreporting.dlite_reprots" %>
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
                $('#loaderDiv1021').hide();
                $('#loaderDiv1042').hide();
                $('#loaderDiv1022').hide();
                $('#loaderDiv1023').hide();
                $('#loaderDiv1024').hide();
                $('#loaderDiv1025').hide();

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1021(sdate, edate);
                    getReprot1042(sdate, edate);
                    getReprot1022(sdate, edate);
                    getReprot1023(sdate, edate);
                    getReprot1024(sdate, edate);
                    getReprot1025(sdate, edate);

                });

                var btnExcel1021 = $('#btnExcel1021')
                btnExcel1021.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1021] D-LITE (กทม.+ปริมณฑล+โพลี่ กรุ๊ป 80%)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1021', filefulname)
                });

                var btnExcel1042 = $('#btnExcel1042')
                btnExcel1042.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1042] Screw, Accessories (กทม+ปริมณฑล)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1042', filefulname)
                });

                var btnExcel1022 = $('#btnExcel1022')
                btnExcel1022.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1022] D-LITE (ต่างจังหวัด)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1022', filefulname)
                });

                var btnExcel1023 = $('#btnExcel1023')
                btnExcel1023.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1023] Screw, Accessories (ต่างจังหวัด)' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1023', filefulname)
                });

                var btnExcel1024 = $('#btnExcel1024')
                btnExcel1024.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1024] Manager D-Lite' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1024', filefulname)
                });

                var btnExcel1025 = $('#btnExcel1025')
                btnExcel1025.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1025] Manager Screw, Accessories' + '_from_' + datepickerstart + '_to_' + datepickerend;

                    exportTableToExcel('tblReprot1025', filefulname)
                });


                var btnPdf1021 = $('#btnPdf1021')
                btnPdf1021.click(function () {

                    var rpt_id = '1021';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1042 = $('#btnPdf1042')
                btnPdf1042.click(function () {

                    var rpt_id = '1042';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1022 = $('#btnPdf1022')
                btnPdf1022.click(function () {

                    var rpt_id = '1022';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1023 = $('#btnPdf1023')
                btnPdf1023.click(function () {

                    var rpt_id = '1023';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1024 = $('#btnPdf1024')
                btnPdf1024.click(function () {

                    var rpt_id = '1024';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1025 = $('#btnPdf1025')
                btnPdf1025.click(function () {

                    var rpt_id = '1025';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'managerdlite';
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

            function getReprot1021(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1021',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1021 tr td").remove();
                        $("#loaderDiv1021").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1021').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].dLiteWave, data[i].dLiteSmooth, data[i].ddPro
                                    , data[i].dLite4R, data[i].kansad40, data[i].frp, data[i].saleTotal, data[i].shareSales, data[i].netSales, data[i].cutNetSales
                                    , data[i].grandTotal, data[i].extraGet, data[i].exDiff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1021 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1021 td:nth-of-type(16)').addClass('myclass');
                        $("#loaderDiv1021").hide();
                    }
                });
            }

            function getReprot1042(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1042',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1042 tr td").remove();
                        $("#loaderDiv1042").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1042').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].Ferrex, data[i].Arrex, data[i].Correx, data[i].Accessories
                                    , data[i].accKansad, data[i].netSales, data[i].shareSales, data[i].cutComm, data[i].cutCN, data[i].cutNetSales, data[i].grandTotal]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1042 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1042 td:nth-of-type(14)').addClass('myclass');
                        $("#loaderDiv1042").hide();
                    }
                });
            }

            function getReprot1022(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1022',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1022 tr td").remove();
                        $("#loaderDiv1022").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1022').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].dLiteWave, data[i].dLiteSmooth, data[i].ddPro, data[i].dLite4r
                                    , data[i].kansad40, data[i].saleTotal, data[i].shareSales, data[i].cutService, data[i].cutComm, data[i].cutCN, data[i].netSales
                                    , data[i].cutSales, data[i].granTotal, data[i].traGet, data[i].exDeff, data[i].exPercent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1022 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1022 td:nth-of-type(19)').addClass('myclass');
                        $("#loaderDiv1022").hide();
                    }
                });
            }

            function getReprot1023(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1023',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1023 tr td").remove();
                        $("#loaderDiv1023").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1023').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].Ferrex, data[i].Arrex, data[i].Correx, data[i].Accessories
                                    , data[i].accKansad, data[i].netSales, data[i].shareShales, data[i].cutComm, data[i].cutCN, data[i].cutNetSales, data[i].grandTotal]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1023 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1023 td:nth-of-type(14)').addClass('myclass');
                        $("#loaderDiv1023").hide();
                    }
                });
            }

            function getReprot1024(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1024',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1024 tr td").remove();
                        $("#loaderDiv1024").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1024').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].dLiteBkk, data[i].dLiteUpc, data[i].grandTotal, data[i].traGet, data[i].exDiff, data[i].exPercent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1024 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1024 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1024 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1024 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1024 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1024 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1024 td:nth-of-type(9)').addClass('myclass');
                        $("#loaderDiv1024").hide();
                    }
                });
            }

            function getReprot1025(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1025',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1025 tr td").remove();
                        $("#loaderDiv1025").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1025').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].dLiteBkk, data[i].dLiteUpc, data[i].grandTotal]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1025 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1025 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1025 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1025 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1025 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1025 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1025 td:nth-of-type(9)').addClass('myclass');
                        $("#loaderDiv1025").hide();
                    }
                });
            }

        </script>

        <h1>D-Lite Reports <%--step 1 check pages content name--%>
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
                                        <a href="#">D-Lite Report</a>
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

            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-green"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1021" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1021" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1021] D-LITE (กทม.+ปริมณฑล+โพลี่ กรุ๊ป 80%)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1021">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1021" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">D-Lite ลอนคลื่น</th>
                                        <th class="">D-Lite ลอนเรียบ</th>
                                        <th class="">DD Pro</th>
                                        <th class="">D-Lite4R</th>
                                        <th class="">Kansad 40%</th>
                                        <th class="">FRP</th>
                                        <th class="">Sale Total</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">Net Sales</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">Grand Total</th>
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
                          
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-red"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1042" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1042" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1042] Screw, Accessories (กทม+ปริมณฑล)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1042">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1042" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">Ferrex</th>
                                        <th class="">Arrex</th>
                                        <th class="">Correx</th>
                                        <th class="">Accessories</th>
                                        <th class="">Accessories Kansad</th>
                                        <th class="">Sales Total</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักส่วนลด</th>
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
                                <button type="button" id="btnPdf1022" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1022" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1022] D-LITE (ต่างจังหวัด)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1022">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1022" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>                                      
                                         <th class="">EmpCode</th>
                                         <th class="">EmpName</th>
                                         <th class="">D-Lite ลอนคลื่น</th>
                                         <th class="">D-Lite ลอนเรียบ</th>
                                         <th class="">DD Pro</th>
                                         <th class="">D-Lite 4R</th>
                                         <th class="">Kaansad 40%</th>
                                         <th class="">Sale Total</th>
                                         <th class="">แบ่งยอดขาย</th>
                                         <th class="">หักค่าแรง</th>
                                         <th class="">หักค่านายหน้า</th>
                                         <th class="">หักรับคืน</th>
                                         <th class="">Net Sales</th>
                                         <th class="">หักยอดขาย</th>
                                         <th class="">Gran Total</th>
                                         <th class="">Traget</th>
                                         <th class="">Deff</th>
                                         <th class="">Percent</th>
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
                                <button type="button" id="btnPdf1023" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1023" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1023] Screw, Accessories (ต่างจังหวัด)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1023">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1023" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">Ferrex</th>
                                        <th class="">Arrex</th>
                                        <th class="">Correx</th>
                                        <th class="">Accessories</th>
                                        <th class="">Accessories Kansad</th>
                                        <th class="">Net Sales</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักส่วนลด</th>
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
            </div>

            <div class="col-md-6">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-red"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1024" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1024" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1024] Manager D-Lite</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1024">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1024" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">D-Lite BKK</th>
                                        <th class="">D-Lite UPC</th>
                                        <th class="">Grand Total</th>
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

            <div class="col-md-6">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-green"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1025" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1025" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1025] Manager Screw, Accessories</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1025">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1025" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">D-Lite BKK</th>
                                        <th class="">D-Lite UPC</th>
                                        <th class="">Grand Total</th>
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
