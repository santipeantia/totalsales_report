<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="report-frp-bkk-lastthreeyear.aspx.cs" Inherits="totalsale_report.xreporting.report_frp_bkk_lastthreeyear" %>

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

                $('#loaderDiv1001').hide();
                $('#loaderDiv1002').hide();
                $('#loaderDiv1003').hide();
                $('#loaderDiv1004').hide();
                $('#loaderDiv1005').hide();
                $('#loaderDiv1006').hide();
                $('#loaderDiv1007').hide();

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var ddd = String(today.getDate() - 1).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var firstdate = yyyy + '-' + mm + '-' + '01';
                var nowdate = yyyy + '-' + mm + '-' + ddd;

                var fulldate = yyyy + '-' + mm + '-' + dd;

               
                $('#datepickerstart').val(fulldate);

                var ssdate = firstdate;
                var eedate = nowdate;

                var cmonth;

                if (mm == '01') {
                    cmonth = 'มกราคม';
                } else if (mm == '02') {
                    cmonth = 'กุมภาพันธ์';
                }
                else if (mm == '03') {
                    cmonth = 'มีนาคม';
                }
                else if (mm == '04') {
                    cmonth = 'เมษายน';
                }
                else if (mm == '05') {
                    cmonth = 'พฤษภาคม';
                }
                else if (mm == '06') {
                    cmonth = 'มิถุนายน';
                }
                else if (mm == '07') {
                    cmonth = 'กรกฏาคม';
                }
                else if (mm == '08') {
                    cmonth = 'สิงหาคม';
                }
                else if (mm == '09') {
                    cmonth = 'กันยายน';
                }
                else if (mm == '10') {
                    cmonth = 'ตุลาคม';
                }
                else if (mm == '11') {
                    cmonth = 'พฤศจิกายน';
                }
                else if (mm == '12') {
                    cmonth = 'ธันวาคม';
                }
                else {
                    cmonth = '';
                }

                $('#lblmonth01').text(cmonth);
                $('#lblmonth02').text(cmonth);
                $('#lblmonth03').text(cmonth);
                $('#lblmonth04').text(cmonth);
                $('#lblmonth05').text(cmonth);
                $('#lblmonth06').text(cmonth);
                $('#lblmonth07').text(cmonth);
                                             
                //$('#datepickerstart').val(ssdate);
                //$('#datepickerend').val(eedate);

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var ddd = String(today.getDate() - 1).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();

                    var fulldate = yyyy + '-' + mm + '-' + dd;



                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    localStorage.setItem('sdate', sdate);
                    localStorage.setItem('edate', edate);

                    //var ssdate = localStorage.getItem('sdate');
                    //var eedate = localStorage.getItem('edate');                 

                    getReportFrpBkkThreeYear01();
                    getReportFrpBkkThreeYear02();
                    getReportFrpBkkThreeYear03();
                    getReportFrpBkkThreeYear04();
                    getReportFrpBkkThreeYear05();
                    getReportFrpBkkThreeYear06();
                    getReportFrpBkkThreeYear07();

                });

                var btnDownload = $('#btnDownload')
                btnDownload.click(function () {

                    var rpt_id = 'totalampelite';
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();

                    pdfReportRender('frpbkk', null, null);


                });

                var kittisakfrpbkk = $('#kittisakfrpbkk');
                kittisakfrpbkk.click(function () {
                    //alert('ทีมคุณกิตติศักดิ์\nยอดขาย FRP (กรุงเทพ)');
                    document.getElementById('<%= btnkittisakfrpbkk.ClientID %>').click();
                })     

                var kittisakscrewbkk = $('#kittisakscrewbkk');
                kittisakscrewbkk.click(function () {
                    //alert('ทีมคุณกิตติศักดิ์\nยอดขาย FRP (กรุงเทพ)');
                    document.getElementById('<%= btnkittisakscrewbkk.ClientID %>').click();
                })  

                
                var sirusfrpNorthIsanMidwestSouth = $('#sirusfrpNorthIsanMidwestSouth');
                sirusfrpNorthIsanMidwestSouth.click(function () {
                    //alert('ทีมคุณศิรัส\nยอดขาย FRP (เหนือ,อีสาน,กลางตก,ใต้)');
                    document.getElementById('<%= btnsirusfrpNorthIsanMidwestSouth.ClientID %>').click();
                })

                var sirusScrewNorthIsanMidwestSouth = $('#sirusScrewNorthIsanMidwestSouth');
                sirusScrewNorthIsanMidwestSouth.click(function () {
                    //alert('ทีมคุณศิรัส\nยอดขาย FRP (เหนือ,อีสาน,กลางตก,ใต้)');
                    document.getElementById('<%= btnsirusScrewNorthIsanMidwestSouth.ClientID %>').click();
                })  

                
                var sirusDliteNorthIsanMidwestSouth = $('#sirusDliteNorthIsanMidwestSouth');
                sirusDliteNorthIsanMidwestSouth.click(function () {
                    //alert('ทีมคุณศิรัส\nยอดขาย D-Lite (เหนือ,อีสาน,กลางตก,ใต้)');
                    document.getElementById('<%= btnsirusDliteNorthIsanMidwestSouth.ClientID %>').click();
                })  

                
                var kittisakscrewplusfrp = $('#kittisakscrewplusfrp');
                kittisakscrewplusfrp.click(function () {
                    //alert('กำลังดำเนินการ... \nทีมคุณกิตติศักดิ์\nยอดขาย SCREW + FRP (ต่างจังหวัด)');
                    document.getElementById('<%= btnkittisakscrewplusfrp.ClientID %>').click();
                }) 

                
                var pakpoomdlitebkk = $('#pakpoomdlitebkk');
                pakpoomdlitebkk.click(function () {
                    //alert('ทีมคุณภาคภูมิ\nยอดขาย D-LITE (กรุงเทพ/ตะวันออก/กลาง ตก)');
                    document.getElementById('<%= btnpakpoomdlitebkk.ClientID %>').click();
                }) 

                var pakpoomscrewbkk = $('#pakpoomscrewbkk');
                pakpoomscrewbkk.click(function () {
                    alert('กำลังดำเนินการ... \nทีมคุณภาคภูมิ\nยอดขาย SCREW (กรุงเทพ/ตะวันออก)');
                    //document.getElementById('<%= btnpakpoomscrewbkk.ClientID %>').click();
                })

                var channarongfrpbkk = $('#channarongfrpbkk');
                channarongfrpbkk.click(function () {
                    //alert('กำลังดำเนินการ... \nทีมคุณภาคภูมิ\nยอดขาย SCREW (กรุงเทพ/ตะวันออก)');
                    document.getElementById('<%= btnchannarongfrpbkk.ClientID %>').click();
                })

                
                
                

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

            function getReportFrpBkkThreeYear01() {
                //FRPBKK02	พิมพ์ศิริ  วรรณโรจน์
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleFRPBKK02',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear01 tr td").remove();
                        $("#loaderDiv1001").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear01').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear01 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1001").hide();
                    }
                });
            }

            function getReportFrpBkkThreeYear02() {
                //FRPBKK05	ภคมณ  สว่างวรรณ์
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleFRPBKK05',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear02 tr td").remove();
                        $("#loaderDiv1002").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear02').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear02 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1002").hide();
                    }
                });
            }

            function getReportFrpBkkThreeYear03() {
                //FRPBKK04	สุจิตรา  คงเมือง
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleFRPBKK04',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear03 tr td").remove();
                        $("#loaderDiv1003").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear03').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear03 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1003").hide();
                    }
                });
            }

            function getReportFrpBkkThreeYear04() {
                //FRPBKK06	นฤมล  ทัศนา
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleFRPBKK06',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear04 tr td").remove();
                        $("#loaderDiv1004").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear04').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear04 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1004").hide();
                    }
                });
            }

            function getReportFrpBkkThreeYear05() {
                //FRPBKK03	สมหญิง  ดอกไม้พุ่ม
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleFRPBKK03',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear05 tr td").remove();
                        $("#loaderDiv1005").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear05').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear05 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1005").hide();
                    }
                });
            }

            function getReportFrpBkkThreeYear06() {
                //FRPBKK03	สมหญิง  ดอกไม้พุ่ม
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleFRP113054',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear06 tr td").remove();
                        $("#loaderDiv1006").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear06').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear06 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1006").hide();
                    }
                });
            }

            function getReportFrpBkkThreeYear07() {
                //spTotalReportBySaleTotalFRPBKK
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/getTotalReportBySaleTotalFRPBKK',
                    method: 'post',
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblFrpBkkThreeYear07 tr td").remove();
                        $("#loaderDiv1007").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblFrpBkkThreeYear07').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].xYear, data[i].EmpCode, data[i].EmpName, data[i].Jan, data[i].Feb, data[i].Mar, data[i].Apr
                                    , data[i].May, data[i].Jun, data[i].Jul, data[i].Aug, data[i].Sep, data[i].Oct, data[i].Nov, data[i].Dec
                                    , data[i].TotalYearTodate, data[i].TotalAllYear]);
                            });
                        }
                        table.draw();
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(3)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(4)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(5)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(6)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(7)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(8)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(9)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(10)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(11)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(12)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(13)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(14)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(15)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(16)').addClass('myclass');
                        $('#tblFrpBkkThreeYear07 td:nth-of-type(17)').addClass('myclass');
                        $("#loaderDiv1007").hide();
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
                                        <a href="#">ยอดขายเปรียบเทียบย้อนหลัง 3 ปี</a>
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
                        <div class="row">
                            <div class="col-md-2" style="margin-left: 10px;">
                                    <div class="form-group">
                                        <label class="txtLabel">วันที่รายงาน :</label>
                                        <div class="input-group date">
                                            <input type="text" class="form-control pull-right" id="datepickerstart" name="datepickerstart" autocomplete="off" >
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                         </div>

                        <div class="row">
                            <div class="col-md-2">
                                <a class="btn btn-app" id="sirusfrpNorthIsanMidwestSouth" style="width: 100%; height: 90px">
                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณศิรัส</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย FRP (เหนือ,อีสาน,กลางตก,ใต้)</span>
                                </a>                                
                                <input class="hidden" type="button" id="btnsirusfrpNorthIsanMidwestSouth" name="btnsirusfrpNorthIsanMidwestSouth" 
                                    value="btnsirusfrpNorthIsanMidwestSouth" runat="server" onserverclick="rptReportLasteThreeYearSirusFrpNorthIsanMidwestSouth" />
                            </div>                            
                            <div class="col-md-2">
                                <a class="btn btn-app" id="sirusScrewNorthIsanMidwestSouth"  style="width: 100%; height: 90px">
                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณศิรัส</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย Screw (เหนือ,อีสาน,กลางตก,ใต้)</span>
                                </a>
                                <input class="hidden" type="button" id="btnsirusScrewNorthIsanMidwestSouth" name="btnsirusScrewNorthIsanMidwestSouth" 
                                    value="btnsirusScrewNorthIsanMidwestSouth" runat="server" onserverclick="rptReportLasteThreeYearSirusScrewNorthIsanMidwestSouth" />
                            </div>
                            <div class="col-md-2">
                                <a class="btn btn-app" id="sirusDliteNorthIsanMidwestSouth" style="width: 100%; height: 90px">
                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณศิรัส</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย D-LITE (เหนือ,อีสาน,กลางตก,ใต้)</span>
                                </a>
                                <input class="hidden" type="button" id="btnsirusDliteNorthIsanMidwestSouth" name="btnsirusDliteNorthIsanMidwestSouth" 
                                    value="btnsirusDliteNorthIsanMidwestSouth" runat="server" onserverclick="rptReportLasteThreeYearDLiteUPC" />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 20px;">
                            <div class="col-md-2">
                                <a class="btn btn-app" id="kittisakfrpbkk" style="width: 100%; height: 90px">

                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณกิตติศักดิ์</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย FRP (กรุงเทพ)</span>
                                </a>
                                <input class="hidden" type="button" id="btnkittisakfrpbkk" name="kittisakfrpbkk" value="btnkittisakfrpbkk" runat="server" onserverclick="rptReportLasteThreeYearFrpBkk" />
                            </div>
                            <div class="col-md-2">
                                <a class="btn btn-app" id="kittisakscrewbkk" style="width: 100%; height: 90px">

                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณกิตติศักดิ์</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย Screw (กรุงเทพ)</span>
                                </a>
                                <input class="hidden" type="button" id="btnkittisakscrewbkk" name="btnkittisakscrewbkk" value="btnkittisakscrewbkk" runat="server" onserverclick="rptReportLasteThreeYearScrewBkk" />
                                
                            </div>
                            <div class="col-md-2">
                                <a class="btn btn-app" id="kittisakscrewplusfrp" style="width: 100%; height: 90px;">

                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณกิตติศักดิ์</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย Screw + FRP (ต่างจังหวัด)</span>
                                </a>
                                <input class="hidden" type="button" id="btnkittisakscrewplusfrp" name="btnkittisakscrewplusfrp" 
                                    value="btnkittisakscrewplusfrp" runat="server" onserverclick="rptReportLasteThreeYearKittisakScrewFRP" />
                            </div>
                        </div>                      

                        <div class="row" style="margin-top: 20px;">
                            <div class="col-md-2">
                                <a class="btn btn-app" id="pakpoomdlitebkk"  style="width: 100%; height: 90px;">
                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณภาคภูมิ</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย D-LITE (กรุงเทพ)</span>
                                </a>
                                <input class="hidden" type="button" id="btnpakpoomdlitebkk" name="btnpakpoomdlitebkk" value="btnpakpoomdlitebkk" 
                                        runat="server" onserverclick="rptReportLasteThreeYearPakpoomDliteBkk" />
                                
                            </div>

                            <div class="col-md-2" >
                                <a class="btn btn-app" id="pakpoomscrewbkk"  style="width: 100%; height: 90px; border: 1px solid red;">
                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณภาคภูมิ</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย Screw (กรุงเทพ/ตะวันออก)</span>
                                </a>
                                <input class="hidden" type="button" id="btnpakpoomscrewbkk" name="btnpakpoomscrewbkk" value="btnpakpoomscrewbkk" 
                                        runat="server" onserverclick="rptReportLasteThreeYearPakpoomDliteBkk" />
                            </div>
                        </div>

                        <div class="row" style="margin-top: 20px;">
                            <div class="col-md-2">
                                <a class="btn btn-app" id="channarongfrpbkk" style="width: 100%; height: 90px">
                                    <i class="fa fa-file-pdf-o text-red"></i>
                                    <span class="txtLabel">ทีมคุณชาญณรงค์</span>
                                    <br />
                                    <span class="txtLabel">ยอดขาย FRP (กรุงเทพ)</span>
                                </a>
                                <input class="hidden" type="button" id="btnchannarongfrpbkk" name="btnchannarongfrpbkk" value="btnchannarongfrpbkk" 
                                        runat="server" onserverclick="rptReportLasteThreeYearChannarongFrpBkk" />
                            </div>
                        </div>
                </div>
            </div>
        </div>

           

        </div>
    </section>
</asp:Content>
