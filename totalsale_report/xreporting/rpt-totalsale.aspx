<%@ Page Title="Total Sales" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="rpt-totalsale.aspx.cs" Inherits="totalsale_report.xreporting.rpt_totalsale" %>

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
                $('#loaderDiv1031').hide();
                $('#loaderDiv1032').hide();
                $('#loaderDiv1033').hide();
                $('#loaderDiv1034').hide();
                $('#loaderDiv1035').hide();
                $('#loaderDiv1036').hide();
                $('#loaderDiv1014').hide();

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1031(sdate, edate);
                    getReprot1032(sdate, edate);
                    getReprot1033(sdate, edate);
                    getReprot1034(sdate, edate);
                    getReprot1035(sdate, edate);
                    getReprot1036(sdate, edate);
                    getReprot1014(sdate, edate);
                });


                var btnExcel1031 = $('#btnExcel1031')
                btnExcel1031.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1031] สรุปยอดขายเซลล์ กรุงเทพ (ทีม คุณกิตติศักดิ์)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1031', filefulname)
                });

                var btnExcel1032 = $('#btnExcel1032')
                btnExcel1032.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1032] สรุปยอดขายเซลล์ กรุงเทพ (ทีม คุณชาญณรงค์)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1032', filefulname)
                });
                
                var btnExcel1033 = $('#btnExcel1033')
                btnExcel1033.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1033] สรุปยอดขายเซลล์ ต่างจังหวัด(ทีม คุณศิรัส)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1033', filefulname)
                });
                
                var btnExcel1034 = $('#btnExcel1034')
                btnExcel1034.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1034] สรุปยอดขายเซลล์ ต่างจังหวัด(ทีม คุณกิตติศักดิ์)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1034', filefulname)
                });
                
                var btnExcel1035 = $('#btnExcel1035')
                btnExcel1035.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1035] สรุปยอดขายเซลล์ D - Lite(ทีม คุณภาคภูมิ)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1035', filefulname)
                });

                var btnExcel1036 = $('#btnExcel1036')
                btnExcel1036.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1036] สรุปยอดขายเซลล์ Screw (คุณพิมพ์ศิริ)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1036', filefulname)
                });
                
                var btnExcel1014 = $('#btnExcel1014')
                btnExcel1014.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1014] Ampelite FRP(งานโครงการ / Projects)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1014', filefulname)
                });


                 var btnPdf1031 = $('#btnPdf1031')
                btnPdf1031.click(function () {

                    var rpt_id = '1031';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1032 = $('#btnPdf1032')
                btnPdf1032.click(function () {

                    var rpt_id = '1032';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1033 = $('#btnPdf1033')
                btnPdf1033.click(function () {

                    var rpt_id = '1033';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1034 = $('#btnPdf1034')
                btnPdf1034.click(function () {

                    var rpt_id = '1034';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1035 = $('#btnPdf1035')
                btnPdf1035.click(function () {

                    var rpt_id = '1035';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });
                
                var btnPdf1036 = $('#btnPdf1036')
                btnPdf1036.click(function () {

                    var rpt_id = '1036';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1014 = $('#btnPdf1014')
                btnPdf1014.click(function () {

                    var rpt_id = '1014';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'totalsale';
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

            function getReprot1031(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1031',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1031 tr td").remove(); 
                        $("#loaderDiv1031").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1031').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].FRP, data[i].Screw, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        //$('#tblReprot1031 td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReprot1031 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1031 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1031 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1031 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1031 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1031 td:nth-of-type(8)').addClass('myclass');
                        $("#loaderDiv1031").hide();
                    }
                });
            }

            function getReprot1032(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1032',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1032 tr td").remove(); 
                        $("#loaderDiv1032").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1032').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].FRP, data[i].Screw, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1032 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1032 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1032 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1032 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1032 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1032 td:nth-of-type(8)').addClass('myclass');
                        $("#loaderDiv1032").hide();
                    }
                });
            }

            function getReprot1033(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1033',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1033 tr td").remove(); 
                        $("#loaderDiv1033").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1033').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].FRP, data[i].Screw, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1033 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1033 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1033 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1033 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1033 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1033 td:nth-of-type(8)').addClass('myclass');
                        $("#loaderDiv1033").hide();
                    }
                });
            }

            function getReprot1034(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1034',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1034 tr td").remove(); 
                        $("#loaderDiv1034").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1034').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].FRP, data[i].Screw, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1034 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1034 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1034 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1034 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1034 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1034 td:nth-of-type(8)').addClass('myclass');
                        $("#loaderDiv1034").hide();
                    }
                });
            }

            function getReprot1035(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1035',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1035 tr td").remove(); 
                        $("#loaderDiv1035").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1035').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].BKK, data[i].UPC, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1035 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1035 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1035 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1035 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1035 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1035 td:nth-of-type(8)').addClass('myclass');
                        $("#loaderDiv1035").hide();
                    }
                });
            }

            function getReprot1036(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1036',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1036 tr td").remove(); 
                        $("#loaderDiv1036").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1036').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].FerrexScrew, data[i].ArrexScrew, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].Percent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1036 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1036 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1036 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1036 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1036 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1036 td:nth-of-type(8)').addClass('myclass');
                        $("#loaderDiv1036").hide();
                    }
                });
            }
            
            function getReprot1014(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1014',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1014 tr td").remove(); 
                        $("#loaderDiv1014").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1014').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].EmpCode, data[i].EmpName, data[i].ProjectDesc, data[i].SaleTotal, data[i].CNBill, data[i].CutComm, data[i].CutTrn, data[i].NetSales, data[i].CutSale, data[i].GrandTotal]);
                            });
                        }
                        table.draw();
                        
                        $('#tblReprot1014 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1014 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1014 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1014 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1014 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1014 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1014 td:nth-of-type(10)').addClass('myclass');
                        $("#loaderDiv1014").hide();
                    }
                });
            }

        </script>

        <h1>Total Sales Pages  <%--step 1 check pages content name--%>
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
                                        <a href="#">Total Sales Report</a>
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
                            <i class="fa fa-flag-checkered text-orange"></i>
                            <span class="btn-group pull-right">                              
                                <button type="button" id="btnPdf1031" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1031" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1031] สรุปยอดขายเซลล์ กรุงเทพ (ทีม คุณกิตติศักดิ์)</label>
                        </div>
                        <div class="box-body">
                            <%--<div id="loaderDiv1031" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1031">
                                <span class="spinner"></span>
                            </div>                                                      

                            <table id="tblReprot1031" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">FRP</th>
                                        <th class="">Screw</th>
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

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-green"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1032" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1032" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1032] สรุปยอดขายเซลล์ กรุงเทพ (ทีม คุณชาญณรงค์)</label>
                        </div>
                        <div class="box-body">

                           <%-- <div id="loaderDiv1032" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1032">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1032" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">FRP</th>
                                        <th class="">Screw</th>
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

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-pink"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1033" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1033" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1033] สรุปยอดขายเซลล์ ต่างจังหวัด (ทีม คุณศิรัส)</label>
                        </div>

                        <div class="box-body">
                            <%--<div id="loaderDiv1033" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1033">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1033" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">FRP</th>
                                        <th class="">Screw</th>
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

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-blue"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1034" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1034" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1034] สรุปยอดขายเซลล์ ต่างจังหวัด (ทีม คุณกิตติศักดิ์)</label>
                        </div>

                        <div class="box-body">
                            <%--<div id="loaderDiv1034" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1034">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1034" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">FRP</th>
                                        <th class="">Screw</th>
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

            <div class="col-md-6">
                
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-purple"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1035" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1035" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1035] สรุปยอดขายเซลล์ D-Lite (ทีม คุณภาคภูมิ)</label>
                        </div>

                        <div class="box-body">
                            <%--<div id="loaderDiv1035" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1035">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1035" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">BKK</th>
                                        <th class="">UPC</th>
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

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-yellow"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1036" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1036" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1036] สรุปยอดขายเซลล์ Screw (คุณพิมพ์ศิริ)</label>
                        </div>

                        <div class="box-body">
                            <%--<div id="loaderDiv1036" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1036">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1036" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">Ferrex Screw</th>
                                        <th class="">Arrex Screw</th>
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

                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-blue"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1014" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1014" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1014] Ampelite FRP (งานโครงการ / Projects)</label>
                        </div>
                        <div class="box-body">
                            <%--<div id="loaderDiv1014" style="text-align: center">
                                <img src="../../dist/img/loader3.gif" alt="Loading..." />
                            </div>--%>

                            <div class="cv-spinner" id="loaderDiv1014">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1014" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">ProjectDesc</th>
                                        <th class="">SaleTotal</th>
                                        <th class="">CNBill</th>
                                        <th class="">CutComm</th>
                                        <th class="">CutTrn</th>
                                        <th class="">NetSales</th>
                                        <th class="">CutSale</th>
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
