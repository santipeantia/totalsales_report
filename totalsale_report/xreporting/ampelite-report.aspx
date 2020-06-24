﻿<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="ampelite-report.aspx.cs" Inherits="totalsale_report.xreporting.ampelite_report" %>
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
        </style>

        <script>
            $(document).ready(function () {

                $('#loaderDiv1011').hide();
                $('#loaderDiv1012').hide();
                $('#loaderDiv1013').hide();

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1011(sdate, edate);
                    getReprot1012(sdate, edate);
                    getReprot1013(sdate, edate);

                });

                var btnExcel1011 = $('#btnExcel1011')
                btnExcel1011.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1011] Ampelite BKK' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1011', filefulname)
                });

                var btnExcel1012 = $('#btnExcel1012')
                btnExcel1012.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1012] Ampelite UPC (ภาคเหนือ/อีสาน)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1012', filefulname)
                });

                var btnExcel1013 = $('#btnExcel1013')
                btnExcel1013.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1013] Ampelite UPC (ภาคตะวันออก, กลาง, ตก, ใต้)' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1013', filefulname)
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
            
            function getReprot1011(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1011',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1011 tr td").remove(); 
                        $("#loaderDiv1011").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1011').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].mAmplite, data[i].mRooflite, data[i].tAmpelite, data[i].tRooflite
                                    , data[i].tSunnyNeo, data[i].OEM, data[i].dLite, data[i].chemBlok, data[i].sumTotal, data[i].sharedSale, data[i].cutModel
                                    , data[i].cutComm, data[i].cutCN, data[i].netSales, data[i].exChemblok, data[i].cutProjects, data[i].overSixtyDay, data[i].cutNetSale
                                    , data[i].cutOEM, data[i].grandTotal, data[i].traGet, data[i].tDiff, data[i].tPercent]);

                               
                            });
                        }
                        table.draw();
                        $('#tblReprot1011 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(20)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(21)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(22)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(23)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(24)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(25)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(26)').addClass('myclass');
                        $("#loaderDiv1011").hide();
                    }
                });
            }

            function getReprot1012(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1012',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1012 tr td").remove();
                        $("#loaderDiv1012").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1012').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].mAmpleite, data[i].mRooflite, data[i].tAmpelite
                                    , data[i].tRooflite, data[i].tSunnyNeo, data[i].OEM, data[i].dLite, data[i].chemBlok, data[i].sumTotal, data[i].shareSale
                                    , data[i].cutModel, data[i].cutComm, data[i].cutCN, data[i].netSales, data[i].exChemblok, data[i].cutProjects
                                    , data[i].overSixtyDay, data[i].cutNetSale, data[i].cutOEM, data[i].grandTotal, data[i].traGet, data[i].tDiff, data[i].tPercent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1012 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(20)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(21)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(22)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(23)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(24)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(25)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(26)').addClass('myclass');
                        $("#loaderDiv1012").hide();
                    }
                });
            }

            function getReprot1013(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1013',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1013 tr td").remove();
                        $("#loaderDiv1013").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1013').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].mAmpleite, data[i].mRooflite, data[i].tAmpelite
                                    , data[i].tRooflite, data[i].tSunnyNeo, data[i].OEM, data[i].dLite, data[i].chemBlok, data[i].sumTotal, data[i].shareSale
                                    , data[i].cutModel, data[i].cutComm, data[i].cutCN, data[i].netSales, data[i].exChemblok, data[i].cutProjects
                                    , data[i].overSixtyDay, data[i].cutNetSale, data[i].cutOEM, data[i].grandTotal, data[i].traGet, data[i].tDiff, data[i].tPercent]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1013 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(20)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(21)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(22)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(23)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(24)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(25)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(26)').addClass('myclass');
                        $("#loaderDiv1013").hide();
                    }
                });
            }

        </script>

        <h1>Ampelite Reports <%--step 1 check pages content name--%>
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
                                        <a href="#">Ampelite Report</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload" runat="server" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
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
                            <i class="fa fa-flag-checkered text-orange"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1011" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1011] Ampelite BKK</label>
                        </div>
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1011">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1011" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">Sales Name</th>
                                        <th class="">M-Amplite</th>
                                        <th class="">M-Rooflite</th>
                                        <th class="">T-Ampelite</th>
                                        <th class="">T-Rooflite</th>
                                        <th class="">T-SunnyNeo</th>
                                        <th class="">OEM</th>
                                        <th class="">D-Lite</th>
                                        <th class="">ChemBlok</th>
                                        <th class="">SumTotal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่าโมล</th>
                                        <th class="">ค่านายหน้า</th>
                                        <th class="">ส่วนลดจ่าย</th>
                                        <th class="">NetSales</th>
                                        <th class="">Chemblok</th>
                                        <th class="">หักProjects</th>
                                        <th class="">ชำระเกิน 60 วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">หัก OEM</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                       	<th class="">%</th>
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
                                <button type="button" id="btnPdf1012" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1012" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1012] Ampelite UPC (ภาคเหนือ/อีสาน)</label>
                        </div>
                        <div class="box-body"  style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1012">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1012" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">Sales Name</th>
                                        <th class="">M-Amplite</th>
                                        <th class="">M-Rooflite</th>
                                        <th class="">T-Ampelite</th>
                                        <th class="">T-Rooflite</th>
                                        <th class="">T-SunnyNeo</th>
                                        <th class="">OEM</th>
                                        <th class="">D-Lite</th>
                                        <th class="">ChemBlok</th>
                                        <th class="">SumTotal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่าโมล</th>
                                        <th class="">ค่านายหน้า</th>
                                        <th class="">ส่วนลดจ่าย</th>
                                        <th class="">NetSales</th>
                                        <th class="">Chemblok</th>
                                        <th class="">หักProjects</th>
                                        <th class="">ชำระเกิน 60 วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">หัก OEM</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                       	<th class="">%</th>
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
                                <button type="button" id="btnPdf1013" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1013" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>
                            <label class="txtLabel">[1013] Ampelite UPC (ภาคตะวันออก, กลาง, ตก, ใต้)</label>
                        </div>

                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDiv1013">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1013" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">Sales Name</th>
                                        <th class="">M-Amplite</th>
                                        <th class="">M-Rooflite</th>
                                        <th class="">T-Ampelite</th>
                                        <th class="">T-Rooflite</th>
                                        <th class="">T-SunnyNeo</th>
                                        <th class="">OEM</th>
                                        <th class="">D-Lite</th>
                                        <th class="">ChemBlok</th>
                                        <th class="">SumTotal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่าโมล</th>
                                        <th class="">ค่านายหน้า</th>
                                        <th class="">ส่วนลดจ่าย</th>
                                        <th class="">NetSales</th>
                                        <th class="">Chemblok</th>
                                        <th class="">หักProjects</th>
                                        <th class="">ชำระเกิน 60 วัน</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">หัก OEM</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">Traget</th>
                                        <th class="">Diff</th>
                                       	<th class="">%</th>
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
