using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using CrystalDecisions.CrystalReports.Engine;
using System.Security.Cryptography;
using CrystalDecisions.Shared;


namespace totalsale_report.xreporting
{
    public partial class report_render : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        ReportDocument rpt = new ReportDocument();

        public string strMsgAlert = "";
        public string strUser = "sa";
        public string strPassword = "AmpelitE88";
        public string strServer = "192.168.1.13";
        public string strSource = "DB_TotalSalesReport";
        string ssql;

        protected void Page_Load(object sender, EventArgs e)
        {
            string rpt_id = Request.Params["id"];
            string sdate = Request.Params["sdate"];
            string edate = Request.Params["edate"];

            if (Session["emp_id"] != null) 
            {
                if (rpt_id == "1031" && sdate != null && edate != null) { rpt1031(sdate, edate); }
                else if (rpt_id == "1032" && sdate != null && edate != null) { rpt1032(sdate, edate); }
                else if (rpt_id == "1033" && sdate != null && edate != null) { rpt1033(sdate, edate); }
                else if (rpt_id == "1034" && sdate != null && edate != null) { rpt1034(sdate, edate); }
                else if (rpt_id == "1035" && sdate != null && edate != null) { rpt1035(sdate, edate); }
                else if (rpt_id == "1036" && sdate != null && edate != null) { rpt1036(sdate, edate); }
                else if (rpt_id == "1014" && sdate != null && edate != null) { rpt1014(sdate, edate); }
                else if (rpt_id == "totalsale" && sdate != null && edate != null) { rptTotalSales(sdate, edate); }

                else if (rpt_id == "1011" && sdate != null && edate != null) { rpt1011(sdate, edate); }
                else if (rpt_id == "1012" && sdate != null && edate != null) { rpt1012(sdate, edate); }
                else if (rpt_id == "1013" && sdate != null && edate != null) { rpt1013(sdate, edate); }
                else if (rpt_id == "totalampelite" && sdate != null && edate != null) { rptTotalAmpelite(sdate, edate); }

                else if (rpt_id == "1015" && sdate != null && edate != null) { rpt1015(sdate, edate); }
                else if (rpt_id == "1038" && sdate != null && edate != null) { rpt1038(sdate, edate); }
                else if (rpt_id == "1016" && sdate != null && edate != null) { rpt1016(sdate, edate); }
                else if (rpt_id == "1039" && sdate != null && edate != null) { rpt1039(sdate, edate); }
                else if (rpt_id == "totalscrew" && sdate != null && edate != null) { rpttotalscrew(sdate, edate); }

                else if (rpt_id == "1017" && sdate != null && edate != null) { rpt1017(sdate, edate); }
                else if (rpt_id == "1018" && sdate != null && edate != null) { rpt1018(sdate, edate); }
                else if (rpt_id == "1040" && sdate != null && edate != null) { rpt1040(sdate, edate); }
                else if (rpt_id == "1041" && sdate != null && edate != null) { rpt1041(sdate, edate); }
                else if (rpt_id == "screwreport" && sdate != null && edate != null) { rptscrewreport(sdate, edate); }

                else if (rpt_id == "1019" && sdate != null && edate != null) { rpt1019(sdate, edate); }
                else if (rpt_id == "1020" && sdate != null && edate != null) { rpt1020(sdate, edate); }
                else if (rpt_id == "amperamampelflowreport" && sdate != null && edate != null) { rptamperamampelflowreport(sdate, edate); }

                else if (rpt_id == "1021" && sdate != null && edate != null) { rpt1021(sdate, edate); }
                else if (rpt_id == "1042" && sdate != null && edate != null) { rpt1042(sdate, edate); }
                else if (rpt_id == "1022" && sdate != null && edate != null) { rpt1022(sdate, edate); }
                else if (rpt_id == "1023" && sdate != null && edate != null) { rpt1023(sdate, edate); }
                else if (rpt_id == "1024" && sdate != null && edate != null) { rpt1024(sdate, edate); }
                else if (rpt_id == "1025" && sdate != null && edate != null) { rpt1025(sdate, edate); }
                else if (rpt_id == "managerdlite" && sdate != null && edate != null) { rptmanagerdlitereport(sdate, edate); }

                else if (rpt_id == "1029" && sdate != null && edate != null) { rpt1029(sdate, edate); }
                else if (rpt_id == "1030" && sdate != null && edate != null) { rpt1030(sdate, edate); }
                else if (rpt_id == "managerdlitedetail" && sdate != null && edate != null) { rptmanagerdlitedetailreport(sdate, edate); }

                else if (rpt_id == "1026" && sdate != null && edate != null) { rpt1026(sdate, edate); }
                else if (rpt_id == "1027" && sdate != null && edate != null) { rpt1027(sdate, edate); }
                else if (rpt_id == "1028" && sdate != null && edate != null) { rpt1028(sdate, edate); }
                else if (rpt_id == "otherreport" && sdate != null && edate != null) { rptotherreport(sdate, edate); }

                else if (rpt_id == "1043" && sdate != null && edate != null) { rpt1043(sdate, edate); }

                else if (rpt_id == "strategic" && sdate != null && edate != null) { rptStrategic(sdate, edate); }

                
                else if (rpt_id == "resultreportmkt") { rptResultReportMkt(rpt_id); }

                else if (rpt_id == "resultreportmktr2") { rptResultReportMktR2(rpt_id); }

                else if (rpt_id == "resultreportmktexcel") { rptResultReportMktExcel(rpt_id); }

                else if (rpt_id == "resultreportmktexcelr2") { rptResultReportMktExcelR2(rpt_id); }

                else if (rpt_id == "resultreportmkttop") { rptResultReportMktTop(rpt_id); }

                else if (rpt_id == "resultreportmkttopr2") { rptResultReportMktTopR2(rpt_id); }

                else if (rpt_id == "resultreportmkttopexcel") { rptResultReportMktTopExcel(rpt_id); }

                else if (rpt_id == "resultreportmkttopexcelr2") { rptResultReportMktTopExcelR2(rpt_id); }

                else if (rpt_id == "resultreportyeartodatepdf") { rptReportYeartodateProductPdf(rpt_id); }
                else if (rpt_id == "resultreportyeartodateexcel") { rptReportYeartodateProductExcel(rpt_id); }                

                else { Response.Write("<script>alert('Error..!, Report find not found.');</script>"); }

                
            }
            else
            {
                Response.Redirect("../signin.aspx");
            }
        }

        protected void rpt1031(string sdate, string edate)
        {           
            try
            {
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1031_TotalSales_crs";

                //Conn = dbConn.OpenConn();
                //Comm = new SqlCommand(ssql);
                //Comm.Connection = Conn;                
                //Comm.CommandType = CommandType.StoredProcedure;
                //Comm.Parameters.AddWithValue("@sdate", sdate);
                //Comm.Parameters.AddWithValue("@edate", edate);

                //da = new SqlDataAdapter(Comm);

                //dt = new DataTable();
                //da.Fill(dt);

                //if (dt.Rows.Count != 0)
                //{
                //    rpt.Load(Server.MapPath("../Reports/rpt1031_TotalSales.rpt"));

                //    Reports.ds1031TotalSales ds1031TotalSales = new Reports.ds1031TotalSales();
                //    ds1031TotalSales.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1031_TotalSales" + strDate);
                //}
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1031_TotalSales_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1031_TotalSales" + strDate);


            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1032(string sdate, string edate)
        {
            try
            {
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1032_TotalSales_crs";

                //Conn = dbConn.OpenConn();
                //Comm = new SqlCommand(ssql);
                //Comm.Connection = Conn;
                //Comm.CommandType = CommandType.StoredProcedure;
                //Comm.Parameters.AddWithValue("@sdate", sdate);
                //Comm.Parameters.AddWithValue("@edate", edate);

                //da = new SqlDataAdapter(Comm);

                //dt = new DataTable();
                //da.Fill(dt);

                //if (dt.Rows.Count != 0)
                //{
                //    rpt.Load(Server.MapPath("../Reports/rpt1032_TotalSales.rpt"));

                //    Reports.ds1032TotalSales ds1032TotalSales = new Reports.ds1032TotalSales();
                //    ds1032TotalSales.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1032_TotalSales" + strDate);
                //}

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1032_TotalSales_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1032_TotalSales" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1033(string sdate, string edate)
        {
            try
            {
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1033_TotalSales_crs";

                //Conn = dbConn.OpenConn();
                //Comm = new SqlCommand(ssql);
                //Comm.Connection = Conn;
                //Comm.CommandType = CommandType.StoredProcedure;
                //Comm.Parameters.AddWithValue("@sdate", sdate);
                //Comm.Parameters.AddWithValue("@edate", edate);

                //da = new SqlDataAdapter(Comm);

                //dt = new DataTable();
                //da.Fill(dt);

                //if (dt.Rows.Count != 0)
                //{
                //    rpt.Load(Server.MapPath("../Reports/rpt1033_TotalSales.rpt"));

                //    Reports.ds1033TotalSales ds1033TotalSales = new Reports.ds1033TotalSales();
                //    ds1033TotalSales.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1033_TotalSales" + strDate);
                //}

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1033_TotalSales_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1033_TotalSales" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1034(string sdate, string edate)
        {
            try
            {
               
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1034_TotalSales_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1034_TotalSales" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1035(string sdate, string edate)
        {
            try
            {
           
            string strDate = DateTime.Now.ToString("yyyy-MM-dd");
            rpt = new ReportDocument();            
            rpt.Load(Server.MapPath("../Reports/rpt1035_TotalSales_r2.rpt"));
            rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
            rpt.SetParameterValue("@sdate", sdate);
            rpt.SetParameterValue("@edate", edate);
            rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1035_TotalSales" + strDate);

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1036(string sdate, string edate)
        {
            try
            {
                
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1036_TotalSales_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1036_TotalSales" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1014(string sdate, string edate)
        {
            try
            {
                
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1014_AmpeliteProjects_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1014_AmpeliteProjects" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptTotalSales(string sdate, string edate)
        {
            try
            {
                
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "ReportTotalSales" + strDate);
                Response.End();        

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1011(string sdate, string edate)
        {
            try
            {            
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();               
                rpt.Load(Server.MapPath("../Reports/rpt1011_AmpeliteBKK_r2.rpt"));
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1011_AmpeliteBKK" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1012(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1012_AmpeliteUPC_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1012_AmpeliteUPC" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1013(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1013_AmpeliteUPCEast_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1013_AmpeliteUPCEast" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptTotalAmpelite(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalAmpelite.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "ReportTotalAmpelite" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1015(string sdate, string edate)
        {
            try
            {
               
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1015_ScrewFerrex_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1015_ScrewFerrex" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1038(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();

                rpt.Load(Server.MapPath("../Reports/rpt1038_ScrewFerrex_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1038_ScrewFerrex" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1016(string sdate, string edate)
        {
            try
            {

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1016_ScrewArrex_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1016_ScrewArrex" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1039(string sdate, string edate)
        {
            try
            {

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1039_ScrewArrex_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1039_ScrewArrex" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpttotalscrew(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalScrew.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "ReportTotalScrew" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1017(string sdate, string edate)
        {
            try
            {

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1017_TotalScrew_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1017_TotalScrew" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1018(string sdate, string edate)
        {
            try
            {

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1018_TotalScrew_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1018_TotalScrew" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1040(string sdate, string edate)
        {
            try
            {

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1040_TotalScrew_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1040_TotalScrew" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1041(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1041_TotalScrew_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1041_TotalScrew" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }
        
        protected void rptscrewreport(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalScrewReport.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "Report_TotalScrew" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1019(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1019_Amperam_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1019_Amperam" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1020(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1020_AmpelFlow_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1020_AmpelFlow" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptamperamampelflowreport(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptAmperamAmpelflowReport.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "rptAmperamAmpelflowReport" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1021(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1021_DLiteBkk_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1021_DLiteBkk" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1022(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1022_DLiteUPC_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1022_DLiteUPC" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1042(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1042_ScrewAccessories_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1042_ScrewAccessories" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1023(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1023_ScrewAccessories_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1023_ScrewAccessories" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1024(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1024_ManagerDLite_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1024_ManagerDLite" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1025(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1025_ManagerScrew_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1025_ManagerScrew" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptmanagerdlitereport(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptManagerDLiteReport.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "rptManagerDLiteReport" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1029(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1029_ManagerDLiteDetail_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1029_ManagerDLiteDetail" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1030(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1030_ManagerDLiteDetail_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1030_ManagerDLiteDetail_r2" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptmanagerdlitedetailreport(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptManagerDLiteDetailReport.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "rptManagerDLiteDetailReport" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1026(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1026_SalesNoComm_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1026_SalesNoComm" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1027(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1027_KansadCenter_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1027_KansadCenter" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1028(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1028_SalesOutlet_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1028_SalesOutlet" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rpt1043(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1043_ProjectsReport_r2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1043_ProjectsReport" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptotherreport(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptOtherReport.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("sdate", sdate);
                rpt.SetParameterValue("edate", edate);

                Response.Buffer = false;
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                rpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "rptOtherReport" + strDate);
                Response.End();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptStrategic(string sdate, string edate)
        {
            try
            {
                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptStrategic.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@sdate", sdate);
                rpt.SetParameterValue("@edate", edate);
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "rptStrategic" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMkt(string rptid)
        {
            try
            {
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcode = Request.QueryString["empcode"];
                string empname = Request.QueryString["empname"];
                string docudate = Request.QueryString["docudate"];
                string search = Request.QueryString["search"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptResultReportMkt.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@zoneid", zoneid);
                rpt.SetParameterValue("@zonename", zonename);
                rpt.SetParameterValue("@empcode", empcode);
                rpt.SetParameterValue("@empname", empname);
                rpt.SetParameterValue("@docudate", docudate);
                rpt.SetParameterValue("@search", search);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ResultReport" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktR2(string rptid)
        {
            try
            {
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcode = Request.QueryString["empcode"];
                string empname = Request.QueryString["empname"];
                string docudate = Request.QueryString["docudate"];
                string search = Request.QueryString["search"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptResultReportMktR2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@zoneid", zoneid);
                rpt.SetParameterValue("@zonename", zonename);
                rpt.SetParameterValue("@empcode", empcode);
                rpt.SetParameterValue("@empname", empname);
                rpt.SetParameterValue("@docudate", docudate);
                rpt.SetParameterValue("@search", search);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ResultReport" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktExcel(string rptid)
        {
            try
            {
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcode = Request.QueryString["empcode"];
                string empname = Request.QueryString["empname"];
                string docudate = Request.QueryString["docudate"];
                string search = Request.QueryString["search"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("ProCReportTotalSale_excel", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@zoneid", zoneid);
                Comm.Parameters.AddWithValue("@zonename", zonename);
                Comm.Parameters.AddWithValue("@empcode", empcode);
                Comm.Parameters.AddWithValue("@empname", empname);
                Comm.Parameters.AddWithValue("@docudate", docudate);
                Comm.Parameters.AddWithValue("@search", search);

                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);           

                GridView GridviewExport = new GridView();

            if (dt.Rows.Count != 0)
            {

                GridviewExport.DataSource = dt;
                GridviewExport.DataBind();

                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=รายงานยอดขายทีม " + zonename + "ของ"+ empname + ".xls");
                Response.ContentType = "application/ms-excel";
                Response.ContentEncoding = System.Text.Encoding.Unicode;
                Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

                GridviewExport.RenderControl(hw);
                string style = @"<style> td { mso-number-format:\@;} </style>";
                Response.Write(style);
                Response.Write(sw.ToString());
                Response.End();

            }
        }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktExcelR2(string rptid)
        {
            try
            {
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcode = Request.QueryString["empcode"];
                string empname = Request.QueryString["empname"];
                string docudate = Request.QueryString["docudate"];
                string search = Request.QueryString["search"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("ProCReportTotalSale_excelR2", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@zoneid", zoneid);
                Comm.Parameters.AddWithValue("@zonename", zonename);
                Comm.Parameters.AddWithValue("@empcode", empcode);
                Comm.Parameters.AddWithValue("@empname", empname);
                Comm.Parameters.AddWithValue("@docudate", docudate);
                Comm.Parameters.AddWithValue("@search", search);

                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=รายงานยอดขายทีม " + zonename + "ของ" + empname + ".xls");
                    Response.ContentType = "application/ms-excel";
                    Response.ContentEncoding = System.Text.Encoding.Unicode;
                    Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                    System.IO.StringWriter sw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

                    GridviewExport.RenderControl(hw);
                    string style = @"<style> td { mso-number-format:\@;} </style>";
                    Response.Write(style);
                    Response.Write(sw.ToString());
                    Response.End();

                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktTop(string rptid)
        {
            try
            {
               
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcodelist = Request.QueryString["empcodelist"];
                string docudate = Request.QueryString["docudate"];
                string toprange = Request.QueryString["toprange"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptResultReportMktSumTop.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@zoneid", zoneid);
                rpt.SetParameterValue("@zonename", zonename);
                rpt.SetParameterValue("@empcodelist", empcodelist);
                rpt.SetParameterValue("@docudate", docudate);
                rpt.SetParameterValue("@toprange", toprange);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ResultReportTop" + toprange + "_" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktTopR2(string rptid)
        {
            try
            {

                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcodelist = Request.QueryString["empcodelist"];
                string docudate = Request.QueryString["docudate"];
                string toprange = Request.QueryString["toprange"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptResultReportMktSumTopR2.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@zoneid", zoneid);
                rpt.SetParameterValue("@zonename", zonename);
                rpt.SetParameterValue("@empcodelist", empcodelist);
                rpt.SetParameterValue("@docudate", docudate);
                rpt.SetParameterValue("@toprange", toprange);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "ResultReportTop" + toprange + "_" + strDate);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktTopExcel(string rptid)
        {
            try
            {
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcodelist = Request.QueryString["empcodelist"];
                string docudate = Request.QueryString["docudate"];
                string toprange = Request.QueryString["toprange"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("ProCReportTotalSale_toprange_excel", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@zoneid", zoneid);
                Comm.Parameters.AddWithValue("@zonename", zonename);
                Comm.Parameters.AddWithValue("@empcodelist", empcodelist);
                Comm.Parameters.AddWithValue("@docudate", docudate);
                Comm.Parameters.AddWithValue("@toprange", toprange);

                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=รายงานยอดขายทีม " + zonename + "ของ" + empcodelist.Replace(",","") + ".xls");
                    Response.ContentType = "application/ms-excel";
                    Response.ContentEncoding = System.Text.Encoding.Unicode;
                    Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                    System.IO.StringWriter sw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

                    GridviewExport.RenderControl(hw);
                    string style = @"<style> td { mso-number-format:\@;} </style>";
                    Response.Write(style);
                    Response.Write(sw.ToString());
                    Response.End();

                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptResultReportMktTopExcelR2(string rptid)
        {
            try
            {
                string zoneid = Request.QueryString["zoneid"];
                string zonename = Request.QueryString["zonename"];
                string empcodelist = Request.QueryString["empcodelist"];
                string docudate = Request.QueryString["docudate"];
                string toprange = Request.QueryString["toprange"];

                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("ProCReportTotalSale_toprange_excelR2", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.Parameters.AddWithValue("@zoneid", zoneid);
                Comm.Parameters.AddWithValue("@zonename", zonename);
                Comm.Parameters.AddWithValue("@empcodelist", empcodelist);
                Comm.Parameters.AddWithValue("@docudate", docudate);
                Comm.Parameters.AddWithValue("@toprange", toprange);

                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = Comm;
                dt = new DataTable();
                adapter.Fill(dt);

                GridView GridviewExport = new GridView();

                if (dt.Rows.Count != 0)
                {

                    GridviewExport.DataSource = dt;
                    GridviewExport.DataBind();

                    Response.Clear();
                    Response.AddHeader("content-disposition", "attachment;filename=รายงานยอดขายทีม " + zonename + "ของ" + empcodelist.Replace(",", "") + ".xls");
                    Response.ContentType = "application/ms-excel";
                    Response.ContentEncoding = System.Text.Encoding.Unicode;
                    Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                    System.IO.StringWriter sw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

                    GridviewExport.RenderControl(hw);
                    string style = @"<style> td { mso-number-format:\@;} </style>";
                    Response.Write(style);
                    Response.Write(sw.ToString());
                    Response.End();

                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptReportYeartodateProductPdf(string rptid)
        {
            try
            {

                string yearstart = Request.QueryString["yearstart"];
                string yearend = Request.QueryString["yearend"];
                string monthstart = Request.QueryString["monthstart"];
                string monthend = Request.QueryString["monthend"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSalesYearTodateByProd.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@yearstart", yearstart);
                rpt.SetParameterValue("@yearend", yearend);
                rpt.SetParameterValue("@monthstart", monthstart);
                rpt.SetParameterValue("@monthend", monthend);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "รายงานยอดแยกประเภทสินค้า" + yearend + "-" + monthend );
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }


        protected void rptReportYeartodateProductExcel(string rptid)
        {
            //try
            //{
            //    string yearstart = Request.QueryString["yearstart"];
            //    string yearend = Request.QueryString["yearend"];
            //    string monthstart = Request.QueryString["monthstart"];
            //    string monthend = Request.QueryString["monthend"];

            //    Conn = new SqlConnection();
            //    Conn = dbConn.OpenConn();

            //    Comm = new SqlCommand("spReportTotalSalesYearTodateByProd", Conn);
            //    Comm.CommandType = CommandType.StoredProcedure;
            //    Comm.Parameters.AddWithValue("@yearstart", yearstart);
            //    Comm.Parameters.AddWithValue("@yearend", yearend);
            //    Comm.Parameters.AddWithValue("@monthstart", monthstart);
            //    Comm.Parameters.AddWithValue("@monthend", monthend);

            //    SqlDataAdapter adapter = new SqlDataAdapter();
            //    adapter.SelectCommand = Comm;
            //    dt = new DataTable();
            //    adapter.Fill(dt);

            //    GridView GridviewExport = new GridView();

            //    if (dt.Rows.Count != 0)
            //    {

            //        GridviewExport.DataSource = dt;
            //        GridviewExport.DataBind();

            //        Response.Clear();
            //        Response.AddHeader("content-disposition", "attachment;filename=รายงานยอดแยกประเภทสินค้า " + yearend + "-" + monthend + ".xls");
            //        Response.ContentType = "application/ms-excel";
            //        Response.ContentEncoding = System.Text.Encoding.Unicode;
            //        Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

            //        System.IO.StringWriter sw = new System.IO.StringWriter();
            //        System.Web.UI.HtmlTextWriter hw = new HtmlTextWriter(sw);

            //        GridviewExport.RenderControl(hw);
            //        string style = @"<style> td { mso-number-format:\@;} </style>";
            //        Response.Write(style);
            //        Response.Write(sw.ToString());
            //        Response.End();

            //    }
            //}
            //catch (Exception ex)
            //{
            //    Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
            //    return;
            //}

            try
            {

                string yearstart = Request.QueryString["yearstart"];
                string yearend = Request.QueryString["yearend"];
                string monthstart = Request.QueryString["monthstart"];
                string monthend = Request.QueryString["monthend"];

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSalesYearTodateByProd.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                rpt.SetParameterValue("@yearstart", yearstart);
                rpt.SetParameterValue("@yearend", yearend);
                rpt.SetParameterValue("@monthstart", monthstart);
                rpt.SetParameterValue("@monthend", monthend);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.Excel, Response, false, "รายงานยอดแยกประเภทสินค้า" + yearend + "-" + monthend + ".xls");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }
    }
}