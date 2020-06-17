<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="dlite-detail-report.aspx.cs" Inherits="totalsale_report.xreporting.dlite_detail_report" %>
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
                $('#loaderDiv1029').hide();
                $('#loaderDiv1030').hide();
                //todo something here

                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1029(sdate, edate);
                    getReprot1030(sdate, edate);
                

                });
            });

            function getReprot1029(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1029',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1029 tr td").remove();
                        $("#loaderDiv1029").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1029').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].dLiteWave, data[i].dLiteSmooth, data[i].ddPro, data[i].dLite4R
                                    , data[i].Ferrex, data[i].Arrex, data[i].Correx, data[i].louvreAX, data[i].Accessories, data[i].saleTotal, data[i].cutCN, data[i].cutTrans
                                    , data[i].netSales, data[i].cutNetSales, data[i].grandTotal]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1029 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1029 td:nth-of-type(18)').addClass('myclass');
                        $("#loaderDiv1029").hide();
                    }
                });
            }

            function getReprot1030(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1030',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1030 tr td").remove();
                        $("#loaderDiv1030").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1030').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].No, data[i].EmpCode, data[i].EmpName, data[i].dLiteWave, data[i].dLiteSmooth, data[i].ddPro, data[i].dLite4R
                                    , data[i].Ferrex, data[i].Arrex, data[i].Correx, data[i].louvreAX, data[i].Accessories, data[i].saleTotal, data[i].cutCN, data[i].cutTrans
                                    , data[i].netSales, data[i].cutNetSales, data[i].grandTotal]);
                            });
                        }
                        table.draw();
                        $('#tblReprot1030 td:nth-of-type(1)').addClass('mycenter');
                        //$('#tblReprot1019 td:nth-of-type(2)').addClass('myclass');
                        //$('#tblReprot1019 td:nth-of-type(3)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(4)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(5)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(6)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1030 td:nth-of-type(18)').addClass('myclass');
                        $("#loaderDiv1030").hide();
                    }
                });
            }

        </script>

        <h1>D-Lite Detail Reports <%--step 1 check pages content name--%>
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
                                        <a href="#">D-Lite Detail Report</a>
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
                            <i class="fa fa-flag-checkered text-green"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1029" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1029" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1029] รายละเอียดยอดขาย D-Lite (กรุงเทพฯ+ปริมณฑล+ตะวันออก)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1029">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1029" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">D-Lite ลอนคลื่น</th>
                                        <th class="">D-Lite ลอนเรียบ</th>
                                        <th class="">DD Pro</th>
                                        <th class="">D-Lite 4R</th>
                                        <th class="">Ferrex</th>
                                        <th class="">Arrex</th>
                                        <th class="">Correx</th>
                                        <th class="">Louvre Strap AX</th>
                                        <th class="">Accessories</th>
                                        <th class="">Sale Total</th>
                                        <th class="">หักส่วนลด</th>
                                        <th class="">หักค่าขนส่ง</th>
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
                            <i class="fa fa-flag-checkered text-red"></i>
                            <span class="btn-group pull-right">
                                <button type="button" id="btnPdf1030" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1030" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1030] รายละเอียดยอดขาย D-Lite (ตะวันออก+อีสาน กลาง เหนือ ตก ใต้)</label>
                        </div>
                        <div class="box-body">
                            <div class="cv-spinner" id="loaderDiv1030">
                                <span class="spinner"></span>
                            </div>
                            <table id="tblReprot1030" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">No</th>
                                        <th class="">EmpCode</th>
                                        <th class="">EmpName</th>
                                        <th class="">D-Lite ลอนคลื่น</th>
                                        <th class="">D-Lite ลอนเรียบ</th>
                                        <th class="">DD Pro</th>
                                        <th class="">D-Lite 4R</th>
                                        <th class="">Ferrex</th>
                                        <th class="">Arrex</th>
                                        <th class="">Correx</th>
                                        <th class="">Louvre Strap AX</th>
                                        <th class="">Accessories</th>
                                        <th class="">Sale Total</th>
                                        <th class="">หักส่วนลด</th>
                                        <th class="">หักค่าขนส่ง</th>
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

               
            </div>
            


        </div>

    </section>
</asp:Content>
