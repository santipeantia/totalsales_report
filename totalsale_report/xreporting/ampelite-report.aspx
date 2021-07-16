<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="ampelite-report.aspx.cs" Inherits="totalsale_report.xreporting.ampelite_report" %>
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

            .myclassblue {
                text-align: right;
                color: blue;
            }

        </style>

        <script>
            $(document).ready(function () {

                $('#loaderDiv1011').hide();
                $('#loaderDiv1012').hide();
                $('#loaderDiv1013').hide();

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var ddd = String(today.getDate() - 1).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var firstdate = yyyy + '-' + mm + '-' + '01';
                var nowdate = yyyy + '-' + mm + '-' + ddd;
                
                var ssdate = firstdate;
                var eedate = nowdate;

                $('#datepickerstart').val(ssdate);
                $('#datepickerend').val(eedate);

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {
                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    localStorage.setItem('sdate', sdate);
                    localStorage.setItem('edate', edate);

                    //var ssdate = localStorage.getItem('sdate');
                    //var eedate = localStorage.getItem('edate');                 

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

                var btnprintdetail1011 = $('#btnprintdetail1011');
                btnprintdetail1011.click(function () {
                    var today = new Date();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1011] Ampelite BKK' + '_from_' + datepickerstart + '_to_' + datepickerend + '_' + tt;
                    exportTableToExcel('tableReportDetails1011', filefulname)
                });

                var btnprintdetail1012 = $('#btnprintdetail1012');
                btnprintdetail1012.click(function () {
                    var today = new Date();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = '[1012] Ampelite UPC' + '_from_' + datepickerstart + '_to_' + datepickerend + '_' + tt;
                    exportTableToExcel('tableReportDetails1012', filefulname)
                });

                var btnprintdetail1013 = $('#btnprintdetail1013');
                btnprintdetail1013.click(function () {
                    var today = new Date();
                    var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

                    var datepickerstart = $('#datepickerstart').val();
                    var datepickerend = $('#datepickerend').val();
                    var filefulname = ' [1013] Ampelite UPC (ภาคตะวันออก, กลาง, ตก, ใต้)' + '_from_' + datepickerstart + '_to_' + datepickerend + '_' + tt;
                    exportTableToExcel('tableReportDetails1013', filefulname)
                });     

                var btnPdf1011 = $('#btnPdf1011')
                btnPdf1011.click(function () {

                    var rpt_id = '1011';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1012 = $('#btnPdf1012')
                btnPdf1012.click(function () {

                    var rpt_id = '1012';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnPdf1013 = $('#btnPdf1013')
                btnPdf1013.click(function () {

                    var rpt_id = '1013';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                 var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'totalampelite';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender(rpt_id, sdate, edate);
                });

                var btnSyncData = $('#btnSyncData')
                btnSyncData.click(function () {
                                        
                     $('#overlay').show();
                    getSyncData();

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

            function getSyncData() {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetSyncData',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $('#overlay').show();
                    },
                    success: function (data) {
                        $('#overlay').hide();
                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Your work has been data sync..',
                            showConfirmButton: false,
                            timer: 1500
                        })
                    },
                    error: function (jqXHR, exception) {
                        var msg = '';
                        if (jqXHR.status === 0) {
                            msg = 'Not connect.\n Verify Network.';
                        } else if (jqXHR.status == 404) {
                            msg = 'Requested page not found. [404]';
                        } else if (jqXHR.status == 500) {
                            msg = 'Internal Server Error [500].';
                        } else if (exception === 'parsererror') {
                            msg = 'Requested JSON parse failed.';
                        } else if (exception === 'timeout') {
                            msg = 'Time out error.';
                        } else if (exception === 'abort') {
                            msg = 'Ajax request aborted.';
                        } else {
                            msg = 'Uncaught Error.\n' + jqXHR.responseText;
                        }

                        alert('Error, ' + msg);
                    }
                });
            }
            
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
                                    , data[i].tSunnyNeo, data[i].OEM, data[i].dLite, data[i].PolySky, data[i].Amperam, data[i].chemBlok, data[i].sumTotal, data[i].sharedSale, data[i].cutModel
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
                        $('#tblReprot1011 td:nth-of-type(14)').addClass('myclassblue');
                        $('#tblReprot1011 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(17)').addClass('myclassblue');
                        $('#tblReprot1011 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(20)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(21)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(22)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(23)').addClass('myclassblue');
                        $('#tblReprot1011 td:nth-of-type(24)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(25)').addClass('myclass');
                        $('#tblReprot1011 td:nth-of-type(26)').addClass('myclass');
                        $("#loaderDiv1011").hide();


                        $('#tblReprot1011 td').hover(function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            if ((rIndex != 0 & cIndex == 13 || cIndex == 16 || cIndex == 22)) {
                                $(this).css('cursor', 'pointer');
                                $(this).css('color', 'red');
                                $(this).css('font-weight', 'bold');
                            }
                        }, function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            if ((rIndex != 0 & cIndex == 13 || cIndex == 16 || cIndex == 22)) {
                                $(this).css("color", "blue");
                                $(this).css('font-weight', 'normal');
                            }
                        });

                        $('#tblReprot1011 td').click(function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            //alert(rIndex);

                            if (rIndex != 0 & cIndex == 14) {
                                var strempcode = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1011_Sumtotal(sdate, edate, '1011', '[1011] Ampelite BKK', strempcode.text(), strempname.text());
                                }
                            } else if (rIndex != 0 & cIndex == 16) {
                                var strempcode = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1011_netCutComm(sdate, edate, '1011', '[1011] Ampelite BKK', strempcode.text(), strempname.text());
                                }
                            } else if (rIndex != 0 & cIndex == 22) {
                                var strempcode = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1011").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1011(sdate, edate, '1011', '[1011] Ampelite BKK', strempcode.text(), strempname.text());
                                }
                            }

                        });
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
                                    , data[i].tRooflite, data[i].tSunnyNeo, data[i].OEM, data[i].dLite, data[i].PolySky, data[i].Amperam, data[i].chemBlok, data[i].sumTotal, data[i].shareSale
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
                        $('#tblReprot1012 td:nth-of-type(14)').addClass('myclassblue');
                        $('#tblReprot1012 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(16)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(17)').addClass('myclassblue');
                        $('#tblReprot1012 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(20)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(21)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(22)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(23)').addClass('myclassblue');
                        $('#tblReprot1012 td:nth-of-type(24)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(25)').addClass('myclass');
                        $('#tblReprot1012 td:nth-of-type(26)').addClass('myclass');
                        $("#loaderDiv1012").hide();

                        $('#tblReprot1012 td').hover(function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            if ((rIndex != 0 & cIndex == 13 || cIndex == 16 || cIndex == 22)) {
                                $(this).css('cursor', 'pointer');
                                $(this).css('color', 'red');
                                $(this).css('font-weight', 'bold');
                            }
                        }, function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            if ((rIndex != 0 & cIndex == 13 || cIndex == 16 || cIndex == 22)) {
                                $(this).css("color", "blue");
                                $(this).css('font-weight', 'normal');
                            }
                        });

                        $('#tblReprot1012 td').click(function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            //alert(rIndex);

                            if (rIndex != 0 & cIndex == 11) {
                                var strempcode = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1012_Sumtotal(sdate, edate, '1012', '[1012] Ampelite UPC (ภาคเหนือ/อีสาน)', strempcode.text(), strempname.text());
                                }
                            } else if (rIndex != 0 & cIndex == 14) {
                                var strempcode = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                   getReportDetails1012_netCutComm(sdate, edate, '1012', '[1012] Ampelite UPC (ภาคเหนือ/อีสาน)', strempcode.text(), strempname.text());
                                }
                            }if (rIndex != 0 & cIndex == 20) {
                                var strempcode = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1012").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1012(sdate, edate, '1012', '[1012] Ampelite UPC (ภาคเหนือ/อีสาน)', strempcode.text(), strempname.text());
                                }
                            }
                        });
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
                                    , data[i].tRooflite, data[i].tSunnyNeo, data[i].OEM, data[i].dLite, data[i].PolySky, data[i].Amperam, data[i].chemBlok, data[i].sumTotal, data[i].shareSale
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
                        $('#tblReprot1013 td:nth-of-type(14)').addClass('myclassblue');
                        $('#tblReprot1013 td:nth-of-type(15)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(16)').addClass('myclassblue');
                        $('#tblReprot1013 td:nth-of-type(17)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(18)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(19)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(20)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(21)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(22)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(23)').addClass('myclassblue');
                        $('#tblReprot1013 td:nth-of-type(24)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(25)').addClass('myclass');
                        $('#tblReprot1013 td:nth-of-type(26)').addClass('myclass');
                        $("#loaderDiv1013").hide();

                         $('#tblReprot1013 td').hover(function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            if ((rIndex != 0 & cIndex == 13 || cIndex == 16 || cIndex == 22)) {
                                $(this).css('cursor', 'pointer');
                                $(this).css('color', 'red');
                                $(this).css('font-weight', 'bold');
                            }
                        }, function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;
                            if ((rIndex != 0 & cIndex == 13 || cIndex == 16 || cIndex == 22)) {
                                $(this).css("color", "blue");
                                $(this).css('font-weight', 'normal');
                            }
                        });

                        $('#tblReprot1013 td').click(function () {
                            rIndex = this.parentElement.rowIndex;
                            cIndex = this.cellIndex;

                            //alert(rIndex);

                            if (rIndex != 0 & cIndex == 11) {
                                var strempcode = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1013_Sumtotal(sdate, edate, '1013', '[1013] Ampelite UPC (ภาคตะวันออก, กลาง, ตก, ใต้)', strempcode.text(), strempname.text());
                                }
                            } else if (rIndex != 0 & cIndex == 14) {
                                var strempcode = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                   getReportDetails1013_netCutComm(sdate, edate, '1013', '[1013] Ampelite UPC (ภาคตะวันออก, กลาง, ตก, ใต้)', strempcode.text(), strempname.text());
                                }
                            }if (rIndex != 0 & cIndex == 20) {
                                var strempcode = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(1)');
                                var strempname = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(2)');
                                var strVal1 = $("#tblReprot1013").find('tr:eq(' + rIndex + ')').find('td:eq(20)');

                                if (strempcode.text() != "") {
                                    console.log('row :' + rIndex + ', cols : ' + cIndex + '\n' +
                                        ', sdate : ' + sdate +
                                        ', edate : ' + edate + '\n' +
                                        ', strempcode : ' + strempcode.text() + '\n' +
                                        ', strempname : ' + strempname.text() + '\n ' +
                                        ', comm : ' + strVal1.text());

                                    //window.open('https://support.wwf.org.uk', '_blank');

                                    getReportDetails1013(sdate, edate, '1013', '[1013] Ampelite UPC (ภาคตะวันออก, กลาง, ตก, ใต้)', strempcode.text(), strempname.text());
                                }
                            }
                        });
                    }
                });
            }

            function getReportDetails1011_Sumtotal(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1011_sumtotal',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1011 tr td").remove(); 
                        $("#loaderDetail1011").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1011').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1011").hide();
                    }
                });
                
                $("#empcode").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1011").modal({ backdrop: false });
                $("#modal-reportdetail-1011").modal("show");
            }

            function getReportDetails1011_netCutComm(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1011_netCutComm',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1011 tr td").remove(); 
                        $("#loaderDetail1011").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1011').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1011").hide();
                    }
                });
                
                $("#empcode").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1011").modal({ backdrop: false });
                $("#modal-reportdetail-1011").modal("show");
            }

            function getReportDetails1011(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1011',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1011 tr td").remove(); 
                        $("#loaderDetail1011").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1011').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1011").hide();
                    }
                });
                
                $("#empcode").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1011").modal({ backdrop: false });
                $("#modal-reportdetail-1011").modal("show");
            }

            function getReportDetails1012_Sumtotal(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1012_sumtotal',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1012 tr td").remove(); 
                        $("#loaderDetail1011").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1012').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1012").hide();
                    }
                });
                
                $("#empcode1012").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1012").modal({ backdrop: false });
                $("#modal-reportdetail-1012").modal("show");
            }

            function getReportDetails1012_netCutComm(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1012_netCutComm',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1012 tr td").remove(); 
                        $("#loaderDetail1012").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1012').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1012").hide();
                    }
                });
                
                $("#empcode1012").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1012").modal({ backdrop: false });
                $("#modal-reportdetail-1012").modal("show");
            }

            function getReportDetails1012(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1012',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1012 tr td").remove(); 
                        $("#loaderDetail1012").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1012').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1012").hide();
                    }
                });
                
                $("#empcode1012").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1012").modal({ backdrop: false });
                $("#modal-reportdetail-1012").modal("show");
            }
            
            function getReportDetails1013_Sumtotal(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1013_sumtotal',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1013 tr td").remove(); 
                        $("#loaderDetail1013").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1013').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1013").hide();
                    }
                });
                
                $("#empcode1013").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1013").modal({ backdrop: false });
                $("#modal-reportdetail-1013").modal("show");
            }

            function getReportDetails1013_netCutComm(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1013_netCutComm',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1013 tr td").remove(); 
                        $("#loaderDetail1013").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1013').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1013").hide();
                    }
                });
                
                $("#empcode1013").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1013").modal({ backdrop: false });
                $("#modal-reportdetail-1013").modal("show");
            }

            function getReportDetails1013(sdate, edate, zoneid, rptname, empcode, empname) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportDetail1013',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        zoneid: zoneid,
                        empcode: empcode
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tableReportDetails1013 tr td").remove(); 
                        $("#loaderDetail1012").show();
                    },
                    success: function (data) {
                        var table = $('#tableReportDetails1013').DataTable();
                        table.clear();
                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].ProductCode, data[i].NetCutSale
                                    , data[i].EmpCode, data[i].SaleName]);
                            });
                        }
                        table.draw();
                        $("#loaderDetail1013").hide();
                    }
                });
                
                $("#empcode1012").text(rptname + ' : ' + empcode + ' : ' + empname);
                $("#modal-reportdetail-1013").modal({ backdrop: false });
                $("#modal-reportdetail-1013").modal("show");
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

                        <div class="">
                            <div class="form-group col-md-2">
                                <label class="txtLabel">View Report</label>
                                <div class="">
                                    <input type="button" id="btnViewReport" name="btnViewReport" class="btn btn-info btn-flat btn-block" value="Show Report Here" />
                                </div>
                            </div>
                        </div>

                        <div class="">
                            <div class="form-group col-md-2">
                                <label class="txtLabel">อัฟเดทข้อมูลรายงาน</label>
                                <div class="">
                                    <input type="button" id="btnSyncData" name="btnSyncData" class="btn btn-success btn-flat btn-block" value="อัฟเดทข้อมูล (Winspeed)" />
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
                                        <th class="">PolySky</th>
                                        <th class="">Amperam</th>
                                        <th class="">ChemBlok</th>
                                        <th class="">SumTotal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่าโมล/ค่าขนส่ง</th>
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
                        <div class="box-body" style="overflow: scroll">
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
                                        <th class="">PolySky</th>
                                        <th class="">Amperam</th>
                                        <th class="">ChemBlok</th>
                                        <th class="">SumTotal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่าโมล/ค่าขนส่ง</th>
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
                                        <th class="">PolySky</th>
                                        <th class="">Amperam</th>
                                        <th class="">ChemBlok</th>
                                        <th class="">SumTotal</th>
                                        <th class="">แบ่งยอดขาย</th>
                                        <th class="">หักค่าโมล/ค่าขนส่ง</th>
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

        <div class="modal fade" id="modal-reportdetail-1011">
            <div class="modal-dialog" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Report of
                            <label class="txtLabel" id="empcode"></label>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDetail1011">
                                <span class="spinner"></span>
                            </div>
                            <table id="tableReportDetails1011" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">DocuDate</th>
                                        <th class="">InvNo</th>
                                        <th class="">ProductCode</th>
                                        <th class="">TotalPrice</th>                                        
                                        <th class="">EmpCode</th>
                                        <th class="">SaleName</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnprintdetail1011" name="btnprintdetail1011" class="btn btn-primary">Print Details</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-reportdetail-1012">
            <div class="modal-dialog" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Report of
                            <label class="txtLabel" id="empcode1012"></label>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDetail1012">
                                <span class="spinner"></span>
                            </div>
                            <table id="tableReportDetails1012" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">DocuDate</th>
                                        <th class="">InvNo</th>
                                        <th class="">ProductCode</th>
                                        <th class="">TotalPrice</th>                                        
                                        <th class="">EmpCode</th>
                                        <th class="">SaleName</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnprintdetail1012" name="btnprintdetail1012" class="btn btn-primary">Print Details</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modal-reportdetail-1013">
            <div class="modal-dialog" style="width: 1000px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Report of
                            <label class="txtLabel" id="empcode1013"></label>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="box-body" style="overflow: scroll">
                            <div class="cv-spinner" id="loaderDetail1013">
                                <span class="spinner"></span>
                            </div>
                            <table id="tableReportDetails1013" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">DocuDate</th>
                                        <th class="">InvNo</th>
                                        <th class="">ProductCode</th>
                                        <th class="">TotalPrice</th>                                        
                                        <th class="">EmpCode</th>
                                        <th class="">SaleName</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                        <button type="button" id="btnprintdetail1013" name="btnprintdetail1013" class="btn btn-primary">Print Details</button>
                    </div>
                </div>
            </div>
        </div>
        
    </section>
</asp:Content>
