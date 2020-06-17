using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.IO;
using System.Text;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace totalsale_report.xreporting
{
    /// <summary>
    /// Summary description for reporting_srv
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class reporting_srv : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void GetReport1031(string sdate, string edate)
        {
            List<cGetReport1031> datas = new List<cGetReport1031>();
            SqlCommand comm = new SqlCommand("spRpt1031_TotalSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;            
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1031 data = new cGetReport1031();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.FRP = rdr["FRP"].ToString();
                data.Screw = rdr["Screw"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1032(string sdate, string edate)
        {
            List<cGetReport1032> datas = new List<cGetReport1032>();
            SqlCommand comm = new SqlCommand("spRpt1032_TotalSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1032 data = new cGetReport1032();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.FRP = rdr["FRP"].ToString();
                data.Screw = rdr["Screw"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }


        [WebMethod]
        public void GetReport1033(string sdate, string edate)
        {
            List<cGetReport1033> datas = new List<cGetReport1033>();
            SqlCommand comm = new SqlCommand("spRpt1033_TotalSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1033 data = new cGetReport1033();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.FRP = rdr["FRP"].ToString();
                data.Screw = rdr["Screw"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1034(string sdate, string edate)
        {
            List<cGetReport1034> datas = new List<cGetReport1034>();
            SqlCommand comm = new SqlCommand("spRpt1034_TotalSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1034 data = new cGetReport1034();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.FRP = rdr["FRP"].ToString();
                data.Screw = rdr["Screw"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1035(string sdate, string edate)
        {
            List<cGetReport1035> datas = new List<cGetReport1035>();
            SqlCommand comm = new SqlCommand("spRpt1035_TotalSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1035 data = new cGetReport1035();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.BKK = rdr["BKK"].ToString();
                data.UPC = rdr["UPC"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1036(string sdate, string edate)
        {
            List<cGetReport1036> datas = new List<cGetReport1036>();
            SqlCommand comm = new SqlCommand("spRpt1036_TotalSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1036 data = new cGetReport1036();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.FerrexScrew = rdr["FerrexScrew"].ToString();
                data.ArrexScrew = rdr["ArrexScrew"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1014(string sdate, string edate)
        {
            List<cGetReport1014> datas = new List<cGetReport1014>();
            SqlCommand comm = new SqlCommand("spRpt1014_AmpeliteProjects", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1014 data = new cGetReport1014();
                data.CustName = rdr["CustName"].ToString();
                data.ProjectDesc = rdr["ProjectDesc"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.Product = rdr["Product"].ToString();
                data.NetRF = rdr["NetRF"].ToString();
                data.SaleTotal = rdr["SaleTotal"].ToString();
                data.CNBill = rdr["CNBill"].ToString();
                data.CutTrn = rdr["CutTrn"].ToString();
                data.CutComm = rdr["CutComm"].ToString();
                data.DiscPay = rdr["DiscPay"].ToString();
                data.NetSales = rdr["NetSales"].ToString();
                data.CutSale = rdr["CutSale"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1011(string sdate, string edate)
        {
            List<cGetReport1011> datas = new List<cGetReport1011>();
            SqlCommand comm = new SqlCommand("spRpt1011_AmpeliteBKK", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1011 data = new cGetReport1011();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.mAmplite = rdr["mAmplite"].ToString();
                data.mRooflite = rdr["mRooflite"].ToString();
                data.tAmpelite = rdr["tAmpelite"].ToString();
                data.tRooflite = rdr["tRooflite"].ToString();
                data.tSunnyNeo = rdr["tSunnyNeo"].ToString();
                data.OEM = rdr["OEM"].ToString();
                data.dLite = rdr["dLite"].ToString();
                data.chemBlok = rdr["chemBlok"].ToString();
                data.sumTotal = rdr["sumTotal"].ToString();
                data.sharedSale = rdr["sharedSale"].ToString();
                data.cutModel = rdr["cutModel"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.exChemblok = rdr["exChemblok"].ToString();
                data.cutProjects = rdr["cutProjects"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSale = rdr["cutNetSale"].ToString();
                data.cutOEM = rdr["cutOEM"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.traGet = rdr["traGet"].ToString();
                data.tDiff = rdr["tDiff"].ToString();
                data.tPercent = rdr["tPercent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1012(string sdate, string edate)
        {
            List<cGetReport1012> datas = new List<cGetReport1012>();
            SqlCommand comm = new SqlCommand("spRpt1012_AmpeliteUPC", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1012 data = new cGetReport1012();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.mAmpleite = rdr["mAmpleite"].ToString();
                data.mRooflite = rdr["mRooflite"].ToString();
                data.tAmpelite = rdr["tAmpelite"].ToString();
                data.tRooflite = rdr["tRooflite"].ToString();
                data.tSunnyNeo = rdr["tSunnyNeo"].ToString();
                data.OEM = rdr["OEM"].ToString();
                data.dLite = rdr["dLite"].ToString();
                data.chemBlok = rdr["chemBlok"].ToString();
                data.sumTotal = rdr["sumTotal"].ToString();
                data.shareSale = rdr["shareSale"].ToString();
                data.cutModel = rdr["cutModel"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.exChemblok = rdr["exChemblok"].ToString();
                data.cutProjects = rdr["cutProjects"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSale = rdr["cutNetSale"].ToString();
                data.cutOEM = rdr["cutOEM"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.traGet = rdr["traGet"].ToString();
                data.tDiff = rdr["tDiff"].ToString();
                data.tPercent = rdr["tPercent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1013(string sdate, string edate)
        {
            List<cGetReport1013> datas = new List<cGetReport1013>();
            SqlCommand comm = new SqlCommand("spRpt1013_AmpeliteUPCEast", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1013 data = new cGetReport1013();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.mAmpleite = rdr["mAmpleite"].ToString();
                data.mRooflite = rdr["mRooflite"].ToString();
                data.tAmpelite = rdr["tAmpelite"].ToString();
                data.tRooflite = rdr["tRooflite"].ToString();
                data.tSunnyNeo = rdr["tSunnyNeo"].ToString();
                data.OEM = rdr["OEM"].ToString();
                data.dLite = rdr["dLite"].ToString();
                data.chemBlok = rdr["chemBlok"].ToString();
                data.sumTotal = rdr["sumTotal"].ToString();
                data.shareSale = rdr["shareSale"].ToString();
                data.cutModel = rdr["cutModel"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.exChemblok = rdr["exChemblok"].ToString();
                data.cutProjects = rdr["cutProjects"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSale = rdr["cutNetSale"].ToString();
                data.cutOEM = rdr["cutOEM"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.traGet = rdr["traGet"].ToString();
                data.tDiff = rdr["tDiff"].ToString();
                data.tPercent = rdr["tPercent"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1015(string sdate, string edate)
        {
            List<cGetReport1015> datas = new List<cGetReport1015>();
            SqlCommand comm = new SqlCommand("spRpt1015_ScrewFerrex", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1015 data = new cGetReport1015();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.ferrexScrew = rdr["ferrexScrew"].ToString();
                data.ferrexWasher = rdr["ferrexWasher"].ToString();
                data.louvreFX = rdr["louvreFX"].ToString();
                data.exColor = rdr["exColor"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.exReserve = rdr["exReserve"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutDN = rdr["cutDN"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutTrans = rdr["cutTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.exAccessories = rdr["exAccessories"].ToString();
                data.sdate = rdr["sdate"].ToString();
                data.edate = rdr["edate"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1038(string sdate, string edate)
        {
            List<cGetReport1038> datas = new List<cGetReport1038>();
            SqlCommand comm = new SqlCommand("spRpt1038_ScrewFerrex", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1038 data = new cGetReport1038();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.ferrexScrew = rdr["ferrexScrew"].ToString();
                data.ferrexWasher = rdr["ferrexWasher"].ToString();
                data.louvreFX = rdr["louvreFX"].ToString();
                data.exColor = rdr["exColor"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.exReserve = rdr["exReserve"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutDN = rdr["cutDN"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutTrans = rdr["cutTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.exAccessories = rdr["exAccessories"].ToString();
                data.sdate = rdr["sdate"].ToString();
                data.edate = rdr["edate"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1016(string sdate, string edate)
        {
            List<cGetReport1016> datas = new List<cGetReport1016>();
            SqlCommand comm = new SqlCommand("spRpt1016_ScrewArrex", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1016 data = new cGetReport1016();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.correxScrew = rdr["correxScrew"].ToString();
                data.arrexScrew = rdr["arrexScrew"].ToString();
                data.terrexScrew = rdr["terrexScrew"].ToString();
                data.louvreAX = rdr["louvreAX"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.exReserve = rdr["exReserve"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutDN = rdr["cutDN"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutTrans = rdr["cutTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.exAccessories = rdr["exAccessories"].ToString();
                data.sdate = rdr["sdate"].ToString();
                data.edate = rdr["edate"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1039(string sdate, string edate)
        {
            List<cGetReport1039> datas = new List<cGetReport1039>();
            SqlCommand comm = new SqlCommand("spRpt1039_ScrewArrex", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1039 data = new cGetReport1039();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.correxScrew = rdr["correxScrew"].ToString();
                data.arrexScrew = rdr["arrexScrew"].ToString();
                data.terrexScrew = rdr["terrexScrew"].ToString();
                data.louvreAX = rdr["louvreAX"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.exReserve = rdr["exReserve"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutDN = rdr["cutDN"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutTrans = rdr["cutTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.overSixtyDay = rdr["overSixtyDay"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.diffConsignee = rdr["diffConsignee"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.exAccessories = rdr["exAccessories"].ToString();
                data.sdate = rdr["sdate"].ToString();
                data.edate = rdr["edate"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1017(string sdate, string edate)
        {
            List<cGetReport1017> datas = new List<cGetReport1017>();
            SqlCommand comm = new SqlCommand("spRpt1017_TotalScrew", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1017 data = new cGetReport1017();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.TeamGroup = rdr["TeamGroup"].ToString();
                data.TeamName = rdr["TeamName"].ToString();
                data.ferrexScrew = rdr["ferrexScrew"].ToString();
                data.arrexScrew = rdr["arrexScrew"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.perCent = rdr["perCent"].ToString();
                data.sDate = rdr["sDate"].ToString();
                data.eDate = rdr["eDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1040(string sdate, string edate)
        {
            List<cGetReport1040> datas = new List<cGetReport1040>();
            SqlCommand comm = new SqlCommand("spRpt1040_TotalScrew", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1040 data = new cGetReport1040();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.TeamGroup = rdr["TeamGroup"].ToString();
                data.TeamName = rdr["TeamName"].ToString();
                data.ferrexScrew = rdr["ferrexScrew"].ToString();
                data.arrexScrew = rdr["arrexScrew"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                data.sDate = rdr["sDate"].ToString();
                data.eDate = rdr["eDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1041(string sdate, string edate)
        {
            List<cGetReport1041> datas = new List<cGetReport1041>();
            SqlCommand comm = new SqlCommand("spRpt1041_TotalScrew", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1041 data = new cGetReport1041();
                data.id = rdr["id"].ToString();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.TeamGroup = rdr["TeamGroup"].ToString();
                data.TeamName = rdr["TeamName"].ToString();
                data.ferrexScrew = rdr["ferrexScrew"].ToString();
                data.arrexScrew = rdr["arrexScrew"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                data.sDate = rdr["sDate"].ToString();
                data.eDate = rdr["eDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1018(string sdate, string edate)
        {
            List<cGetReport1018> datas = new List<cGetReport1018>();
            SqlCommand comm = new SqlCommand("spRpt1018_ScrewTeam", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1018 data = new cGetReport1018();
                data.No = rdr["No"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.ferrexScrew = rdr["ferrexScrew"].ToString();
                data.arrexScrew = rdr["arrexScrew"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.Traget = rdr["Traget"].ToString();
                data.Diff = rdr["Diff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                data.sdate = rdr["sdate"].ToString();
                data.edate = rdr["edate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetReport1019(string sdate, string edate)
        {
            List<cGetReport1019> datas = new List<cGetReport1019>();
            SqlCommand comm = new SqlCommand("spRpt1019_Amperam_r1", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1019 data = new cGetReport1019();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.kansadCenter = rdr["kansadCenter"].ToString();
                data.dLite = rdr["dLite"].ToString();
                data.FRP = rdr["FRP"].ToString();
                data.exAmperam = rdr["exAmperam"].ToString();
                data.exFlashing = rdr["exFlashing"].ToString();
                data.exService = rdr["exService"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.cutAmperamBill = rdr["cutAmperamBill"].ToString();
                data.cutAmperamMan = rdr["cutAmperamMan"].ToString();
                data.cutAmperamComm = rdr["cutAmperamComm"].ToString();
                data.cutAmperamTrans = rdr["cutAmperamTrans"].ToString();
                data.cutDliteBill = rdr["cutDliteBill"].ToString();
                data.cutDliteMan = rdr["cutDliteMan"].ToString();
                data.cutDliteComm = rdr["cutDliteComm"].ToString();
                data.cutDliteTrans = rdr["cutDliteTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1020(string sdate, string edate)
        {
            List<cGetReport1020> datas = new List<cGetReport1020>();
            SqlCommand comm = new SqlCommand("spRpt1020_AmpelFlow_r1", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1020 data = new cGetReport1020();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.ampelFlow = rdr["ampelFlow"].ToString();
                data.exFlashing = rdr["exFlashing"].ToString();
                data.exEquipment = rdr["exEquipment"].ToString();
                data.exService = rdr["exService"].ToString();
                data.salesTotal = rdr["salesTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.cutBill = rdr["cutBill"].ToString();
                data.cutService = rdr["cutService"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutOther = rdr["cutOther"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        
        [WebMethod]
        public void GetReport1021(string sdate, string edate)
        {
            List<cGetReport1021> datas = new List<cGetReport1021>();
            SqlCommand comm = new SqlCommand("spRpt1021_DLiteBkk", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1021 data = new cGetReport1021();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.dLiteWave = rdr["dLiteWave"].ToString();
                data.dLiteSmooth = rdr["dLiteSmooth"].ToString();
                data.ddPro = rdr["ddPro"].ToString();
                data.dLite4R = rdr["dLite4R"].ToString();
                data.kansad40 = rdr["kansad40"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.extraGet = rdr["extraGet"].ToString();
                data.exDiff = rdr["exDiff"].ToString();
                data.Percent = rdr["Percent"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetReport1042(string sdate, string edate)
        {
            List<cGetReport1042> datas = new List<cGetReport1042>();
            SqlCommand comm = new SqlCommand("spRpt1042_ScrewAccessories", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1042 data = new cGetReport1042();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Ferrex = rdr["Ferrex"].ToString();
                data.Arrex = rdr["Arrex"].ToString();
                data.Correx = rdr["Correx"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.accKansad = rdr["accKansad"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1022(string sdate, string edate)
        {
            List<cGetReport1022> datas = new List<cGetReport1022>();
            SqlCommand comm = new SqlCommand("spRpt1022_DLiteUPC", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1022 data = new cGetReport1022();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.dLiteWave = rdr["dLiteWave"].ToString();
                data.dLiteSmooth = rdr["dLiteSmooth"].ToString();
                data.ddPro = rdr["ddPro"].ToString();
                data.dLite4r = rdr["dLite4r"].ToString();
                data.kansad40 = rdr["kansad40"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.shareSales = rdr["shareSales"].ToString();
                data.cutService = rdr["cutService"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.cutSales = rdr["cutSales"].ToString();
                data.granTotal = rdr["granTotal"].ToString();
                data.traGet = rdr["traGet"].ToString();
                data.exDeff = rdr["exDeff"].ToString();
                data.exPercent = rdr["exPercent"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1023(string sdate, string edate)
        {
            List<cGetReport1023> datas = new List<cGetReport1023>();
            SqlCommand comm = new SqlCommand("spRpt1023_ScrewAccessoriesUPC", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1023 data = new cGetReport1023();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Ferrex = rdr["Ferrex"].ToString();
                data.Arrex = rdr["Arrex"].ToString();
                data.Correx = rdr["Correx"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.accKansad = rdr["accKansad"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.shareShales = rdr["shareShales"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1024(string sdate, string edate)
        {
            List<cGetReport1024> datas = new List<cGetReport1024>();
            SqlCommand comm = new SqlCommand("spRpt1024_ManagerDLite", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1024 data = new cGetReport1024();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.dLiteBkk = rdr["dLiteBkk"].ToString();
                data.dLiteUpc = rdr["dLiteUpc"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.traGet = rdr["traGet"].ToString();
                data.exDiff = rdr["exDiff"].ToString();
                data.exPercent = rdr["exPercent"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1025(string sdate, string edate)
        {
            List<cGetReport1025> datas = new List<cGetReport1025>();
            SqlCommand comm = new SqlCommand("spRpt1025_ManagerScrew", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1025 data = new cGetReport1025();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.dLiteBkk = rdr["dLiteBkk"].ToString();
                data.dLiteUpc = rdr["dLiteUpc"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                data.traGet = rdr["traGet"].ToString();
                data.exDiff = rdr["exDiff"].ToString();
                data.exPercent = rdr["exPercent"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetReport1029(string sdate, string edate)
        {
            List<cGetReport1029> datas = new List<cGetReport1029>();
            SqlCommand comm = new SqlCommand("spRpt1029_DetailsDLite", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1029 data = new cGetReport1029();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.dLiteWave = rdr["dLiteWave"].ToString();
                data.dLiteSmooth = rdr["dLiteSmooth"].ToString();
                data.ddPro = rdr["ddPro"].ToString();
                data.dLite4R = rdr["dLite4R"].ToString();
                data.Ferrex = rdr["Ferrex"].ToString();
                data.Arrex = rdr["Arrex"].ToString();
                data.Correx = rdr["Correx"].ToString();
                data.louvreAX = rdr["louvreAX"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutTrans = rdr["cutTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1030(string sdate, string edate)
        {
            List<cGetReport1030> datas = new List<cGetReport1030>();
            SqlCommand comm = new SqlCommand("spRpt1030_DetailsDLite", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1030 data = new cGetReport1030();
                data.No = rdr["No"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.dLiteWave = rdr["dLiteWave"].ToString();
                data.dLiteSmooth = rdr["dLiteSmooth"].ToString();
                data.ddPro = rdr["ddPro"].ToString();
                data.dLite4R = rdr["dLite4R"].ToString();
                data.Ferrex = rdr["Ferrex"].ToString();
                data.Arrex = rdr["Arrex"].ToString();
                data.Correx = rdr["Correx"].ToString();
                data.louvreAX = rdr["louvreAX"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutTrans = rdr["cutTrans"].ToString();
                data.netSales = rdr["netSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.grandTotal = rdr["grandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
    }
}
