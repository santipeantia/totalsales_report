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
    public partial class report_frp_bkk_lastthreeyear : System.Web.UI.Page
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

        }

        protected void rptReportLasteThreeYearFrpBkk(object sender, EventArgs e)
        {
            try
            {                
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearFrpBkk.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);
                
                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณกิตติศักดิ์ ยอดขาย FRP (กรุงเทพ) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptReportLasteThreeYearScrewBkk(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearKittisakScrewBkk.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณกิตติศักดิ์ ยอดขาย Screw (กรุงเทพ) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        

        protected void rptReportLasteThreeYearSirusScrewNorthIsanMidwestSouth(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearScrewFRPUPCTOTAL.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณศิรัส ยอดขาย Screw (เหนืออีสาน กลาง ตก ใต้) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }
               
        protected void rptReportLasteThreeYearSirusFrpNorthIsanMidwestSouth(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearFrpUPC.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณศิรัส ยอดขาย FRP (เหนืออีสาน กลาง ตก ใต้) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptReportLasteThreeYearDLiteUPC(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearDLiteUPC.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณศิรัส ยอดขาย D-Lite (เหนือ อีสาน กลาง ตก ใต้) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }


        protected void rptReportLasteThreeYearKittisakScrewFRP(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearKittisakScrewFRP.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณกิตติศักดิ์ ยอดขาย Screw + FRP (ต่างจังหวัด) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        
        protected void rptReportLasteThreeYearPakpoomDliteBkk(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearPakpoomDliteBkk.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณภาคภูมิ ยอดขาย D-Lite (กรุงเทพ ตะวันออก กลาง ตก) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }

        protected void rptReportLasteThreeYearChannarongFrpBkk(object sender, EventArgs e)
        {
            try
            {
                rpt = new ReportDocument();
                rpt.Load(Server.MapPath("../Reports/rptTotalSales3YearChannarongFrpBkk.rpt"));
                rpt.SetDatabaseLogon(strUser, strPassword, strServer, strSource);

                rpt.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "ทีมคุณชาญณรงค์ ยอดขาย FRP (กรุงเทพ) ย้อนหลัง 3 ปี");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error..!, '" + ex.Message + "');</script>");
                return;
            }
        }



       

    }
}