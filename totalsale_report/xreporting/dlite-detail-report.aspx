﻿<%@ Page Title="" Language="C#" MasterPageFile="~/total_sale.master" AutoEventWireup="true" CodeBehind="dlite-detail-report.aspx.cs" Inherits="totalsale_report.xreporting.dlite_detail_report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <section class="content-header">
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <%--<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>--%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="../../bower_components/jquery/dist/jquery.min.js"></script>

        <script>
            $(document).ready(function () {

                //todo something here


            });

        </script>

        <h1>D-Lite Detail Reports <%--step 1 check pages content name--%>
            <small>Control panel</small>
        </h1>
    </section>

    <section class="content">
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
                             <p class="text-red"><i class="fa fa-frown-o" aria-hidden="true"></i> <i class="fa fa-frown-o" aria-hidden="true"></i> Sorry, the report is not available. please contact to it department..</p>
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
                            <p class="text-red"><i class="fa fa-frown-o" aria-hidden="true"></i> <i class="fa fa-frown-o" aria-hidden="true"></i> Sorry, the report is not available. please contact to it department..</p>
                        </div>
                    </div>
                </div>

               
            </div>
            


        </div>

    </section>
</asp:Content>