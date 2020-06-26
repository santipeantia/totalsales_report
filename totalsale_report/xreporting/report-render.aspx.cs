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
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1034_TotalSales_crs";

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
                //    rpt.Load(Server.MapPath("../Reports/rpt1034_TotalSales.rpt"));

                //    Reports.ds1034TotalSales ds1034TotalSales = new Reports.ds1034TotalSales();
                //    ds1034TotalSales.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1034_TotalSales" + strDate);
                //}

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1034_TotalSales_r2.rpt"));
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
            //    string strDate = DateTime.Now.ToString("yyyy-MM-dd");
            //    ssql = "spRpt1035_TotalSales_crs";

            //    Conn = dbConn.OpenConn();
            //    Comm = new SqlCommand(ssql);
            //    Comm.Connection = Conn;
            //    Comm.CommandType = CommandType.StoredProcedure;
            //    Comm.Parameters.AddWithValue("@sdate", sdate);
            //    Comm.Parameters.AddWithValue("@edate", edate);

            //    da = new SqlDataAdapter(Comm);

            //    dt = new DataTable();
            //    da.Fill(dt);

            //    if (dt.Rows.Count != 0)
            //    {
            //        rpt.Load(Server.MapPath("../Reports/rpt1035_TotalSales.rpt"));

            //        Reports.ds1035TotalSales ds1035TotalSales = new Reports.ds1035TotalSales();
            //        ds1035TotalSales.Merge(dt);

            //        rpt.SetDataSource(dt);
            //        rpt.SetParameterValue("sdate", sdate);
            //        rpt.SetParameterValue("edate", edate);
            //        rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1035_TotalSales" + strDate);
            //    }

            string strDate = DateTime.Now.ToString("yyyy-MM-dd");
            rpt = new ReportDocument();
            rpt.Load(Server.MapPath("../Reports/rpt1035_TotalSales_r2.rpt"));
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
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1036_TotalSales_crs";

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
                //    rpt.Load(Server.MapPath("../Reports/rpt1036_TotalSales.rpt"));

                //    Reports.ds1036TotalSales ds1036TotalSales = new Reports.ds1036TotalSales();
                //    ds1036TotalSales.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1036_TotalSales" + strDate);
                //}

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1036_TotalSales_r2.rpt"));
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
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1014_AmpeliteProjects_crs";

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
                //    rpt.Load(Server.MapPath("../Reports/rpt1014_AmpeliteProjects.rpt"));

                //    Reports.ds1014AmpelProject ds1014AmpelProject = new Reports.ds1014AmpelProject();
                //    ds1014AmpelProject.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "Report1014_AmpeliteProjects" + strDate);
                //}

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rpt1014_AmpeliteProjects_r2.rpt"));
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
                //string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                //ssql = "spRpt1014_AmpeliteProjects_crs";

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
                //    rpt.Load(Server.MapPath("../Reports/rptTotalSales.rpt"));

                //    Reports.ds1014AmpelProject ds1014AmpelProject = new Reports.ds1014AmpelProject();
                //    ds1014AmpelProject.Merge(dt);

                //    rpt.SetDataSource(dt);
                //    rpt.SetParameterValue("sdate", sdate);
                //    rpt.SetParameterValue("edate", edate);
                //    rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "rptTotalSales" + strDate);
                //}

                string strDate = DateTime.Now.ToString("yyyy-MM-dd");
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales.rpt"));
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
    }
}