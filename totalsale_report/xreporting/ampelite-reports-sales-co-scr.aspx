<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="ampelite-reports-sales-co-scr.aspx.cs" Inherits="totalsale_report.xreporting.ampelite_reports_sales_co_scr" %>
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

                $('#divloader').hide();

                var today = new Date();
                var dd = String(today.getDate()).padStart(2, '0');
                var ddd = String(today.getDate() - 1).padStart(2, '0');
                var mm = String(today.getMonth() + 1).padStart(2, '0');
                var yyyy = today.getFullYear();
                var tt = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var firstdate = '2013' + '-' + '01' + '-' + '01';
                var nowdate = yyyy + '-' + mm + '-' + ddd;

                var ssdate = firstdate;
                var eedate = nowdate;

                $('#datepickerstart').val(ssdate);
                $('#datepickerend').val(eedate);

                //todo something here
                var btnViewReport = $('#btnViewReport')
                btnViewReport.click(function () {

                    $('#btnViewReport').prop('disabled', true);

                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var ddd = String(today.getDate() - 1).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();

                    var fulldate = yyyy + '-' + mm + '-' + dd;


                    //get report_1031
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();;
                    var soption = $('#chkselectall').is(":checked");
                    var stype = $("input[name='optionsRadios']:checked").val();
                    var search = $('#txtsearch').val();

                    console.log(sdate, edate, soption, stype, search);


                    getReportSalesCoReport(sdate, edate, soption, stype, search);


                });

                var btnExportExcel = $('#btnExportExcel');
                btnExportExcel.click(function () {
                    var sdate = $('#datepickerstart').val();
                    var edate = $('#datepickerend').val();;
                    var soption = $('#chkselectall').is(":checked");
                    var stype = $("input[name='optionsRadios']:checked").val();
                    var search = $('#txtsearch').val();

                    $("#divloader").show();

                    $('#hidsdate').val(sdate);
                    $('#hidedate').val(edate);
                    $('#hidoption').val(soption);
                    $('#hidtype').val(stype);
                    $('#hidsearch').val(search);

                    document.getElementById('<%= btnDownloadExcel.ClientID %>').click();

                    $("#divloader").hide();

                });



                var chkselectall = $('#chkselectall');

                chkselectall.click(function () {
                    var chkdocuno = $('#chkdocuno');
                    //chkdocuno.checked = 'true';
                    var soption = ''

                    var scheck = $("input[name='optionsRadios']:checked").val();
                    //alert(scheck);

                    if ($('#chkselectall').is(":checked")) {
                        soption = '0';
                        //alert('checked');
                        //$('#chkdocuno').prop('checked', true);
                        $('#chkdocuno').prop('disabled', true);

                        // $('#chkrefpono').prop('checked', false);
                        $('#chkrefpono').prop('disabled', true);

                        //$('#chkcustomername').prop('checked', false);
                        $('#chkcustomername').prop('disabled', true);

                        //$('#chkproducttype').prop('checked', false);
                        $('#chkproducttype').prop('disabled', true);

                        //$('#chkproductgroup').prop('checked', false);
                        $('#chkproductgroup').prop('disabled', true);

                        //$('#chkproductname').prop('checked', false);
                        $('#chkproductname').prop('disabled', true);

                        // $('#chksalesname').prop('checked', false);
                        $('#chksalesname').prop('disabled', true);

                        // $('#chkprojectname').prop('checked', false);
                        $('#chkprojectname').prop('disabled', true);


                    } else {
                        soption = '1';
                        //alert('unchecked');
                        //$('#chkdocuno').prop('checked', true);
                        $('#chkdocuno').prop('disabled', false);

                        //$('#chkrefpono').prop('checked', false);
                        $('#chkrefpono').prop('disabled', false);

                        //$('#chkcustomername').prop('checked', false);
                        $('#chkcustomername').prop('disabled', false);

                        //$('#chkproducttype').prop('checked', false);
                        $('#chkproducttype').prop('disabled', false);

                        //$('#chkproductgroup').prop('checked', false);
                        $('#chkproductgroup').prop('disabled', false);

                        //$('#chkproductname').prop('checked', false);
                        $('#chkproductname').prop('disabled', false);

                        //$('#chksalesname').prop('checked', false);
                        $('#chksalesname').prop('disabled', false);

                        //$('#chkprojectname').prop('checked', false);
                        $('#chkprojectname').prop('disabled', false);
                    }






                })


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
                    url: '../../xreporting/reporting_srv.asmx/GetSyncDataSaleCoScr',
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

            function getReportSalesCoReport(sdate, edate, soption, stype, search) {
                $.ajax({
                    url: '../../xreporting/reporting_srv.asmx/GetReportSalesCoReportScr',
                    method: 'post',
                    data: {
                        sdate: sdate,
                        edate: edate,
                        soption: soption,
                        stype: stype,
                        ssearch: search
                    },
                    datatype: 'json',
                    beforeSend: function () {
                        $("#tblSalesCoReportScr tr td").remove();
                        $("#divloader").show();
                    },
                    success: function (data) {
                        var table;
                        table = $('#tblSalesCoReportScr').DataTable();
                        table.clear();

                        if (data != '') {
                            $.each(data, function (i, item) {
                                table.row.add([data[i].DocuDate, data[i].InvNo, data[i].CustPONo, data[i].CustCode, data[i].CustName, data[i].ProductCode, data[i].Product
                                    , data[i].GoodGroupCode, data[i].GoodGroupName, data[i].GoodCode, data[i].Model, data[i].GoodName, data[i].Amount, data[i].RF
                                    , data[i].RentAmount, data[i].TotalPrice, data[i].RentCom, data[i].NetCom, data[i].RentOther, data[i].NetPrice, data[i].NetRF_B
                                    , data[i].NetRF_P, data[i].NetCutSale, data[i].NetItems, data[i].GoodPattnCode, data[i].GoodPattnName, data[i].GoodColorCode
                                    , data[i].GoodColorName, data[i].CustTypeCode, data[i].CustTypeName, data[i].sRemark, data[i].GoodClassCode, data[i].GoodClassName
                                    , data[i].EmpCode, data[i].SaleName, data[i].Trs_P, data[i].JobsCode, data[i].JobsName, data[i].ID, data[i].Remark]);
                            });
                        }
                        table.draw();
                        $("#divloader").hide();
                        $('#btnViewReport').prop('disabled', false);


                    }
                });
            }




        </script>

        <h1>Ampelite Reports Sales-Co <%--step 1 check pages content name--%>
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">


        <div class="row">
            <div class="col-xs-12">
                <div class="box box-primary" style="height: 100%;">
                    <div class="box-header" style="margin-bottom: -50px">
                        <div class="box-body">
                            <div id="divOption">
                                <div class="user-block">
                                    <img class="img-circle img-bordered-sm" src="../../dist/img/handshake.png" alt="User Image">
                                    <span class="username">
                                        <a href="#">Ampelite Report Sales-Co</a>
                                    </span>
                                    <span class="description">Monitoring progression of projects</span>
                                    <hr />
                                </div>
                            </div>
                        </div>
                    </div>



                    <%-- <%--step 2 design user interface ui below--%>
                    <div class="">


                        <div class="col-md-12">




                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkdocuno" value="optdocno" checked>
                                        <%--<input type="checkbox" id="chkdocuno">--%>
                                        เลขที่ InvNo                   
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkrefpono" value="optpono">
                                        <%--<input type="checkbox" id="chkrefpono">--%>
                                        อ้างอิง (PO)                     
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkcustomername" value="optcustname">
                                        <%--<input type="checkbox" id="chkcustomername">--%>
                                        ชื่อลูกค้า                     
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkproducttype" value="optproducttype">
                                        <%--<input type="checkbox" id="chkproducttype">--%>
                                        ประเภท                 
                                    </label>
                                </div>
                            </div>
                            <%-- </div>

                        <div class="col-md-12">--%>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkproductgroup" value="optproductgroup">
                                        <%--<input type="checkbox" id="chkproductgroup">--%>
                                        กลุ่มสินค้า                 
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkproductname" value="optproductname">
                                        <%--<input type="checkbox" id="chkproductname">--%>
                                        ชื่อสินค้า                 
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chksalesname" value="optsalesname">
                                        <%--<input type="checkbox" id="chksalesname">--%>
                                        พนักงานขาย                
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-1">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="chkprojectname" value="optprojectname">
                                        <%--<input type="checkbox" id="chkprojectname">--%>
                                        ชื่อโครงการ               
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <label class="txtLabel"></label>
                                <div class="checkbox txtLabel">
                                    <label>
                                        <input type="checkbox" id="chkselectall">
                                        Show data all..                     
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="container-fluid">
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
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="txtLabel">Enter key :</label>
                                    <input type="text" class="form-control pull-right" id="txtsearch">
                                </div>
                            </div>

                            <div class="form-group col-md-2">
                                <label class="txtLabel">View Report</label>

                                <div class="">
                                    <input type="button" id="btnViewReport" name="btnViewReport" class="btn btn-info btn-block" value="Show Report" />
                                </div>

                            </div>

                            <%--<div class="form-group col-md-2">
                                <label class="txtLabel">อัฟเดทข้อมูลรายงาน</label>
                                <div class="">
                                    <input type="button" id="btnSyncData" name="btnSyncData" class="btn btn-success btn-flat btn-block" value="อัฟเดทข้อมูล (Winspeed)" />
                                </div>
                            </div>--%>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-md-12">
                <div class="">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <i class="fa fa-flag-checkered text-orange"></i>
                            <span class="pull-right">
                               <%-- <button type="button" class="btn btn-default btn-sm checkbox-toggle" onclick="openModal()" data-toggle="tooltip" title="New Entry!">
                                    <i class="fa fa-plus"></i>
                                </button>--%>
                                <span class="btn-group">
                                    <%--<button id="btnDownload" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print PDF"><i class="fa fa-file-pdf-o"></i></button>--%>
                                    <%--                                 <button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Screen" onclick="window.print()"><i class="fa fa-credit-card"></i></button>--%>
                                    <button id="btnExportExcel" type="button" class="btn btn-default btn-sm" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                    <button id="btnDownloadExcel" runat="server" type="button" class="btn btn-default btn-sm hidden" onserverclick="btnExportExcel_Click" data-toggle="tooltip" title="Print Excel"><i class="fa fa-table"></i></button>
                                    
                                
                                </span>
                            </span>

                            <label class="txtLabel">Ampel Report Sales-Co</label>
                        </div>
                        <div class="box-body">

                            <%--<div id="overlay">--%>
                            <%--</div>--%>
                            <div class="cv-spinner" id="divloader">

                                <span class="spinner"></span>
                                please wait a few minute...
                                    
                            </div>


                            <table id="tblSalesCoReportScr" class="table table-striped table-bordered table-hover table-condensed" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th class="">DocuDate</th>
                                        <th class="">InvNo</th>
                                        <th class="">CustPONo</th>
                                        <th class="">CustCode</th>
                                        <th class="">CustName</th>
                                        <th class="">ProductCode</th>
                                        <th class="">Product</th>
                                        <th class="">GoodGroupCode</th>
                                        <th class="">GoodGroupName</th>
                                        <th class="">GoodCode</th>
                                        <th class="">Model</th>
                                        <th class="">GoodName</th>
                                        <th class="">Amount</th>
                                        <th class="">RF</th>
                                        <th class="">RentAmount</th>
                                        <th class="">TotalPrice</th>
                                        <th class="">RentCom</th>
                                        <th class="">NetCom</th>
                                        <th class="">RentOther</th>
                                        <th class="">NetPrice</th>
                                        <th class="">NetRF_B</th>
                                        <th class="">NetRF_P</th>
                                        <th class="">NetCutSale</th>
                                        <th class="">NetItems</th>
                                        <th class="">GoodPattnCode</th>
                                        <th class="">GoodPattnName</th>
                                        <th class="">GoodColorCode</th>
                                        <th class="">GoodColorName</th>
                                        <th class="">CustTypeCode</th>
                                        <th class="">CustTypeName</th>
                                        <th class="">sRemark</th>
                                        <th class="">GoodClassCode</th>
                                        <th class="">GoodClassName</th>
                                        <th class="">EmpCode</th>
                                        <th class="">SaleName</th>
                                        <th class="">Trs_P</th>
                                        <th class="">JobsCode</th>
                                        <th class="">JobsName</th>
                                        <th class="">ID</th>
                                        <th class="">Remark</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>



            </div>


            <input type="hidden" id="hidsdate" name="hidsdate" value="" />
            <input type="hidden" id="hidedate" name="hidedate" value="" />
            <input type="hidden" id="hidoption" name="hidoption" value="" />
            <input type="hidden" id="hidtype" name="hidtype" value="" />
            <input type="hidden" id="hidsearch" name="hidsearch" value="" />

        </div>
    </section>
</asp:Content>
