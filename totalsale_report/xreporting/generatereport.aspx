<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="generatereport.aspx.cs" Inherits="totalsale_report.xreporting.generatereport" %>
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
                $('#overlay').hide();

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    $("#overlay").show();
                    //getReportStrategic(sdate, edate);
                    document.getElementById("<%= btnReport.ClientID %>").click();
                    //$('#loaderDivStrategic').hide();
                });

                var btnExcelStrategic = $('#btnExcelStrategic')
                btnExcelStrategic.click(function () {
                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = 'strategic' + '_from_' + datepickerstart + '_to_' + datepickerend;
                    exportTableToExcel('tblReportStrategic', filefulname)
                });


                var btnPdfStrategic = $('#btnPdfStrategic')
                btnPdfStrategic.click(function () {

                    var rpt_id = 'strategic';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });


                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'strategic';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

            });

            function load() {
                $("#loaderDivStrategic").show();
            }

            function unload() {
                $("#loaderDivStrategic").hide();
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

            function getReportStrategic(sdate, edate) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportStrategic',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblReportStrategic tr td").remove();
                        $("#loaderDivStrategic").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblReportStrategic').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].id, data[i].No, data[i].EmpName, data[i].TeamGroup, data[i].TeamName, data[i].ferrexScrew
                                    , data[i].arrexScrew, data[i].GrandTotal, data[i].Traget, data[i].Diff, data[i].perCent]);
                            });
                        }
                        table.draw();
                        $('#tblReportStrategic td:nth-of-type(2)').addClass('mycenter');
                        $('#tblReportStrategic td:nth-of-type(7)').addClass('myclass');
                        $('#tblReportStrategic td:nth-of-type(8)').addClass('myclass');
                        $('#tblReportStrategic td:nth-of-type(9)').addClass('myclass');
                        $('#tblReportStrategic td:nth-of-type(10)').addClass('myclass');
                        $('#tblReportStrategic td:nth-of-type(11)').addClass('myclass');
                        $('#tblReportStrategic td:nth-of-type(12)').addClass('myclass');
                        $("#loaderDivStrategic").hide();
                    }
                });
            }


        </script>

        <h1>Generate Report Of Year <%--step 1 check pages content name--%>
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
        <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeOut= "360000" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>                

                <div class="row">
                    <div class="col-xs-12">
                        <div class="box box-primary" style="height: 100%;">
                            <div class="box-header">
                                <div class="box-body">

                                    <div id="divOption">
                                        <div class="user-block">
                                            <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                            <span class="username">
                                                <a href="#">Generate Report Of Year</a>
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

                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="txtLabel">Date Start:</label>
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" id="datepickerstart" name="datepickerstart" autocomplete="off" value="<%= ssdate %>">
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
                                            <input type="text" class="form-control pull-right" id="datepickerend" name="datepickerend" autocomplete="off" value="<%= eedate %>">
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


                    <button type="button" class="btn btn-success btn-flat btn-block btn-sm hidden" id="btnReport" runat="server"
                        onserverclick="btnReport_click" data-toggle="tooltip" title="Report">
                    </button>
                    <div class="col-md-12">
                        <div class="">
                            <div class="box box-solid">
                                <div class="box-header with-border">
                                    <i class="fa fa-flag-checkered text-primary"></i>
                                    <span class="btn-group pull-right">
                                        <button type="button" id="btnPdfStrategic" class="btn btn-default btn-sm" data-toggle="tooltip" title="PDF"><i class="fa fa-file-pdf-o text-orange"></i></button>
                                        <button type="button" id="btnExcelStrategic" class="btn btn-default btn-sm" data-toggle="tooltip" title="Excel"><i class="fa fa-table text-green"></i></button>
                                    </span>

                                    <label class="txtLabel">Strategic Marketing Report</label>
                                </div>
                                <div class="box-body">

                                    <%--<i class="fa fa-caret-up fa-2x text-green" aria-hidden="true"></i>

                            <i class="fa fa-caret-down fa-2x text-red" aria-hidden="true"></i>--%>


                                    <table id="tblReportStrategic" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <td class="font-weight-bold "><b>No.</b></td>
                                                <td class="font-weight-bold"><b>BusGroup</b></td>
                                                <td class="font-weight-bold"><b>SBUs</b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>Target-<%=current_name_year %></b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>YTD Sales <%= current_name_year %></b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>YTD Sales <%= previouse_name_year %></b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>YrCompr(%)</b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>YTD/Target(%)</b></td>
                                                <td class="font-weight-bold" hidden><b>target_month</b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>Target/<%= current_name_month %></b></td>
                                                <td class="font-weight-bold hidden"><b>current_montd</b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b><%= current_name_month %></b></td>
                                                <td class="font-weight-bold hidden"><b>previous_montd</b> </td>
                                                <td class="font-weight-bold" style="text-align: center"><b><%= previouse_name_month %></b></td>
                                                <td class="font-weight-bold" style="text-align: center"><b>Growth(%)</b></td>
                                                <td class="font-weight-bold hidden"><b>xsdate</b> </td>
                                                <td class="font-weight-bold hidden"><b>xedate</b> </td>
                                                <td class="font-weight-bold" style="text-align: center"><b>Summary</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%= strTblDetail %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </section>
</asp:Content>
