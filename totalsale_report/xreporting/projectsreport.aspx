<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="projectsreport.aspx.cs" Inherits="totalsale_report.xreporting.projectsreport" %>
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

            #tblReprot1043 i:hover {
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

                $('#loaderDiv1043').hide();
               
                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    getReprot1043(sdate, edate);
                    
                });

                var btnExcel1043 = $('#btnExcel1043')
                btnExcel1043.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1043] Projects Report' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReprot1043', filefulname)
                });

                var btnPdf1043 = $('#btnPdf1043')
                btnPdf1043.click(function () {

                    var rpt_id = '1043';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                 var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'projectsreport';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();
                    alert('test');
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
            
            function getReprot1043(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReport1043',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReprot1043 tr td").remove(); 
                        $("#loaderDiv1043").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReprot1043').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].CustCode, data[i].CustName, data[i].EmpCode,
                                    data[i].SaleName, data[i].DocuNo, data[i].DocuDate, data[i].SaleTotal, data[i].cutTransport, data[i].cutComm,
                                    data[i].cutCN, data[i].cutDiscount, data[i].NetSale, data[i].cutNetSale, data[i].GrandTotal, data[i].NetRF_B]);                               
                            });
                        }
                        table.draw();                        
                        $('#tblReprot1043 td:nth-of-type(7)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(8)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(9)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(10)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(11)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(12)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(13)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(14)').addClass('myclass');
                        $('#tblReprot1043 td:nth-of-type(15)').addClass('myclass');
                        $("#loaderDiv1043").hide();
                    }
                });
            }

        </script>

        <h1>Projects Report <%--step 1 check pages content name--%>
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
                                        <a href="#">Projects Report</a>
                                        <span class="pull-right">
                                            <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                            <span class="btn-group">
                                                <button id="btnDownload"  type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-download"></i></button>
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
                                <button type="button" id="btnPdf1043" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                <button type="button" id="btnExcel1043" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                            </span>

                            <label class="txtLabel">[1043] Projects Report</label>
                        </div>
                        <div class="box-body" >
                            <div class="cv-spinner" id="loaderDiv1043">
                                <span class="spinner"></span>
                            </div>

                            <table id="tblReprot1043" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>                                        
                                        <th class="hidden">CustCode</th>
                                        <th class="">CustName</th>
                                        <th class="hidden">EmpCode</th>
                                        <th class="">SaleName</th>
                                        <th class="">DocuNo</th>
                                        <th class="">DocuDate</th>
                                        <th class="">SaleTotal</th>
                                        <th class="">หักค่าขนส่ง</th>
                                        <th class="">หักค่านายหน้า</th>
                                        <th class="">หักCN</th>
                                        <th class="">ส่วนลดจ่าย</th>
                                        <th class="">NetSale</th>
                                        <th class="">หักยอดขาย</th>
                                        <th class="">GrandTotal</th>
                                        <th class="">NetRF_B</th>                                       
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
