﻿using System;
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
                data.SumTotal = rdr["SumTotal"].ToString();
                data.SharedSale = rdr["SharedSale"].ToString();
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
        public void GetReport1044(string sdate, string edate)
        {
            List<cGetReport1044> datas = new List<cGetReport1044>();
            SqlCommand comm = new SqlCommand("spRpt1044_ProjectWithoutComm_vw", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1044 data = new cGetReport1044();
                data.id = rdr["id"].ToString();
                data.ProjectName = rdr["ProjectName"].ToString();
                data.ProjectDate = rdr["ProjectDate"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.TotalTraget = rdr["TotalTraget"].ToString();
                data.SubTraget = rdr["SubTraget"].ToString();
                data.TotalPrice = rdr["TotalPrice"].ToString();
                data.RemarkDesc = rdr["RemarkDesc"].ToString();
                data.LastUpdate = rdr["LastUpdate"].ToString();
                datas.Add(data);

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetUpdateProjectCommission(string trn, string id, string projname, string projdate, string empcode, string empname, string custcode
                                                , string custname, string target, string pertarget, string totalprice, string remark, string currentdate, string createby)
        {
            //try
            //{
            SqlCommand comm = new SqlCommand("spProjectCommissionGetUpdate", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@trn", trn);
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@projname", projname);
            comm.Parameters.AddWithValue("@projdate", projdate);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.Parameters.AddWithValue("@empname", empname);
            comm.Parameters.AddWithValue("@custcode", custcode);
            comm.Parameters.AddWithValue("@custname", custname);
            comm.Parameters.AddWithValue("@target", target);
            comm.Parameters.AddWithValue("@pertarget", pertarget);
            comm.Parameters.AddWithValue("@totalprice", totalprice);
            comm.Parameters.AddWithValue("@remark", remark);
            comm.Parameters.AddWithValue("@currentdate", currentdate);
            comm.Parameters.AddWithValue("@createby", createby);
            comm.ExecuteNonQuery();
            conn.CloseConn();
            //}
            //catch (Exception ex)
            //{

            //}
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
                data.PolySky = rdr["PolySky"].ToString();
                data.Amperam = rdr["Amperam"].ToString();
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
                data.PolySky = rdr["PolySky"].ToString();
                data.Amperam = rdr["Amperam"].ToString();
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
                data.PolySky = rdr["PolySky"].ToString();
                data.Amperam = rdr["Amperam"].ToString();
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
                data.PolySky = rdr["PolySky"].ToString();
                data.FRP = rdr["FRP"].ToString();
                data.exAmperam = rdr["exAmperam"].ToString();
                data.exFlashing = rdr["exFlashing"].ToString();
                data.exService = rdr["exService"].ToString();
                data.saleTotal = rdr["saleTotal"].ToString();
                data.ShareSale = rdr["ShareSale"].ToString();
                data.cutCNc = rdr["cutCNc"].ToString();
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
                data.frp = rdr["frp"].ToString();
                data.PolySky = rdr["PolySky"].ToString();
                data.Amperam = rdr["Amperam"].ToString();
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
                data.accPolySky = rdr["accPolySky"].ToString();
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
                data.accPolySky = rdr["accPolySky"].ToString();
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

        [WebMethod]
        public void GetReport1026(string sdate, string edate)
        {
            List<cGetReport1026> datas = new List<cGetReport1026>();
            SqlCommand comm = new SqlCommand("spRpt1026_SalesNoComm", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1026 data = new cGetReport1026();               
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.MAmpelite = rdr["MAmpelite"].ToString();
                data.MRooflite = rdr["MRooflite"].ToString();
                data.TAmpelite = rdr["TAmpelite"].ToString();
                data.TRooflite = rdr["TRooflite"].ToString();
                data.MTSunnyNeo = rdr["MTSunnyNeo"].ToString();
                data.MtOem = rdr["MtOem"].ToString();
                data.DLite = rdr["DLite"].ToString();
                data.Amperam = rdr["Amperam"].ToString();
                data.FerrexScrew = rdr["FerrexScrew"].ToString();
                data.ArrexScrew = rdr["ArrexScrew"].ToString();
                data.CorrexScrew = rdr["CorrexScrew"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.SaleTotal = rdr["SaleTotal"].ToString();
                data.cutNetCN = rdr["cutNetCN"].ToString();
                data.cutNetComm = rdr["cutNetComm"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1027(string sdate, string edate)
        {
            List<cGetReport1027> datas = new List<cGetReport1027>();
            SqlCommand comm = new SqlCommand("spRpt1027_KansadCenter", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1027 data = new cGetReport1027();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Amperam = rdr["Amperam"].ToString();
                data.AmperamService = rdr["AmperamService"].ToString();
                data.kansadOther = rdr["kansadOther"].ToString();
                data.dliteWave = rdr["dliteWave"].ToString();
                data.dliteSmooth = rdr["dliteSmooth"].ToString();
                data.dliteWaveService = rdr["dliteWaveService"].ToString();
                data.dliteSmoothService = rdr["dliteSmoothService"].ToString();
                data.Flashing = rdr["Flashing"].ToString();
                data.all_equipment = rdr["all_equipment"].ToString();
                data.construction = rdr["construction"].ToString();
                data.xservice = rdr["xservice"].ToString();
                data.Ferrex = rdr["Ferrex"].ToString();
                data.Arrex = rdr["Arrex"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.SaleTotal = rdr["SaleTotal"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.NetSales = rdr["NetSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1028(string sdate, string edate)
        {
            List<cGetReport1028> datas = new List<cGetReport1028>();
            SqlCommand comm = new SqlCommand("spRpt1028_SalesOutlet", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1028 data = new cGetReport1028();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.DLiteWave = rdr["DLiteWave"].ToString();
                data.DLiteSmooth = rdr["DLiteSmooth"].ToString();
                data.DLiteB = rdr["DLiteB"].ToString();
                data.DLite4R = rdr["DLite4R"].ToString();
                data.Frp = rdr["Frp"].ToString();
                data.FrpB = rdr["FrpB"].ToString();
                data.Ferrex = rdr["Ferrex"].ToString();
                data.FerrexWasher = rdr["FerrexWasher"].ToString();
                data.Arrex = rdr["Arrex"].ToString();
                data.Silicone = rdr["Silicone"].ToString();
                data.Accessories = rdr["Accessories"].ToString();
                data.SaleTotal = rdr["SaleTotal"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.NetSales = rdr["NetSales"].ToString();
                data.cutNetSales = rdr["cutNetSales"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReport1043(string sdate, string edate)
        {
            List<cGetReport1043> datas = new List<cGetReport1043>();
            SqlCommand comm = new SqlCommand("spRpt1043_ProjectsReport", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReport1043 data = new cGetReport1043();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.SaleTotal = rdr["SaleTotal"].ToString();
                data.cutTransport = rdr["cutTransport"].ToString();
                data.cutComm = rdr["cutComm"].ToString();
                data.cutCN = rdr["cutCN"].ToString();
                data.cutDiscount = rdr["cutDiscount"].ToString();
                data.NetSale = rdr["NetSale"].ToString();
                data.cutNetSale = rdr["cutNetSale"].ToString();
                data.GrandTotal = rdr["GrandTotal"].ToString();
                data.NetRF_B = rdr["NetRF_B"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportDetail1011_sumtotal(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1011> datas = new List<cGetReportDetail1011>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1011_Sumtotal", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1011 data = new cGetReportDetail1011();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetReportDetail1011_netCutComm(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1011> datas = new List<cGetReportDetail1011>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1011_netCutComm", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1011 data = new cGetReportDetail1011();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportDetail1011(string sdate, string edate, string zoneid, string empcode) {
            List<cGetReportDetail1011> datas = new List<cGetReportDetail1011>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1011_cutNetSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1011 data = new cGetReportDetail1011();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetReportDetail1012_sumtotal(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1012> datas = new List<cGetReportDetail1012>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1012_Sumtotal", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1012 data = new cGetReportDetail1012();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportDetail1012_netCutComm(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1012> datas = new List<cGetReportDetail1012>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1012_netCutComm", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1012 data = new cGetReportDetail1012();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportDetail1012(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1012> datas = new List<cGetReportDetail1012>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1012_cutNetSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1012 data = new cGetReportDetail1012();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
        
        [WebMethod]
        public void GetReportDetail1013_sumtotal(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1012> datas = new List<cGetReportDetail1012>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1013_Sumtotal", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1012 data = new cGetReportDetail1012();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportDetail1013_netCutComm(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1012> datas = new List<cGetReportDetail1012>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1013_netCutComm", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1012 data = new cGetReportDetail1012();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportDetail1013(string sdate, string edate, string zoneid, string empcode)
        {
            List<cGetReportDetail1012> datas = new List<cGetReportDetail1012>();
            SqlCommand comm = new SqlCommand("spGetReportDetail_1013_cutNetSales", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetReportDetail1012 data = new cGetReportDetail1012();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSyncData() {
            SqlCommand comm = new SqlCommand("sp_autosynchronize", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 48000;

            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataZoneListsMKT() {
            List<cGetZoneLists> datas = new List<cGetZoneLists>();
            SqlCommand comm = new SqlCommand("spGetZoneListsMKT", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetZoneLists data = new cGetZoneLists();
                data.zone_id = rdr["zone_id"].ToString();
                data.zone_desc = rdr["zone_desc"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataSalenameWithZoneid(string zoneid) {
            List<cGetZoneMemberLists> datas = new List<cGetZoneMemberLists>();
            SqlCommand comm = new SqlCommand("spZoneMemberListsMKT", conn.OpenConn());
            comm.Parameters.AddWithValue("@zone_id", zoneid);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetZoneMemberLists data = new cGetZoneMemberLists();
                data.emp_id = rdr["emp_id"].ToString();
                data.fullname = rdr["fullname"].ToString();
                data.position = rdr["position"].ToString();
                data.zone_desc = rdr["zone_desc"].ToString();
                data.chk = rdr["chk"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportMKT(string zoneid, string zonename, string empcode, string empname, string docudate, string search) {
            List<cGetResultReportMKT> datas = new List<cGetResultReportMKT>();
            SqlCommand comm = new SqlCommand("ProCReportTotalSale", conn.OpenConn());
            comm.Parameters.AddWithValue("@zoneid", zoneid);
            comm.Parameters.AddWithValue("@zonename", zonename);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.Parameters.AddWithValue("@empname", empname);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@search", search);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportMKT data = new cGetResultReportMKT();
                
                data.seqno = rdr["seqno"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.CustProvince = rdr["CustProvince"].ToString();
                data.CusType = rdr["CusType"].ToString();
                data.totaltreeyear = rdr["totaltreeyear"].ToString();
                data.totaltwoyear = rdr["totaltwoyear"].ToString();
                data.totalytdlast = rdr["totalytdlast"].ToString();
                data.totalytdnow = rdr["totalytdnow"].ToString();
                data.variance = rdr["variance"].ToString();
                data.mjan = rdr["mjan"].ToString();
                data.mfeb = rdr["mfeb"].ToString();
                data.mmar = rdr["mmar"].ToString();
                data.mapr = rdr["mapr"].ToString();
                data.mmay = rdr["mmay"].ToString();
                data.mjun = rdr["mjun"].ToString();
                data.mjul = rdr["mjul"].ToString();
                data.maug = rdr["maug"].ToString();
                data.msep = rdr["msep"].ToString();
                data.moct = rdr["moct"].ToString();
                data.mnov = rdr["mnov"].ToString();
                data.mdec = rdr["mdec"].ToString();
                data.ZoneId = rdr["ZoneId"].ToString();
                data.ZoneName = rdr["ZoneName"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportMKTR2(string zoneid, string zonename, string empcode, string empname, string docudate, string search)
        {
            List<cGetResultReportMKT> datas = new List<cGetResultReportMKT>();
            SqlCommand comm = new SqlCommand("ProCReportTotalSaleR2", conn.OpenConn());
            comm.Parameters.AddWithValue("@zoneid", zoneid);
            comm.Parameters.AddWithValue("@zonename", zonename);
            comm.Parameters.AddWithValue("@empcode", empcode);
            comm.Parameters.AddWithValue("@empname", empname);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@search", search);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportMKT data = new cGetResultReportMKT();

                data.seqno = rdr["seqno"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.CustProvince = rdr["CustProvince"].ToString();
                data.CusType = rdr["CusType"].ToString();
                data.totaltreeyear = rdr["totaltreeyear"].ToString();
                data.totaltwoyear = rdr["totaltwoyear"].ToString();
                data.totalytdlast = rdr["totalytdlast"].ToString();
                data.totalytdnow = rdr["totalytdnow"].ToString();
                data.variance = rdr["variance"].ToString();
                data.mjan = rdr["mjan"].ToString();
                data.mfeb = rdr["mfeb"].ToString();
                data.mmar = rdr["mmar"].ToString();
                data.mapr = rdr["mapr"].ToString();
                data.mmay = rdr["mmay"].ToString();
                data.mjun = rdr["mjun"].ToString();
                data.mjul = rdr["mjul"].ToString();
                data.maug = rdr["maug"].ToString();
                data.msep = rdr["msep"].ToString();
                data.moct = rdr["moct"].ToString();
                data.mnov = rdr["mnov"].ToString();
                data.mdec = rdr["mdec"].ToString();
                data.ZoneId = rdr["ZoneId"].ToString();
                data.ZoneName = rdr["ZoneName"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportMktTopRange(string zoneid, string zonename, string empcodelist, string docudate, string toprange)
        {
            List<cGetResultReportMKT> datas = new List<cGetResultReportMKT>();
            SqlCommand comm = new SqlCommand("ProCReportTotalSale_TopRange", conn.OpenConn());
            comm.Parameters.AddWithValue("@zoneid", zoneid);
            comm.Parameters.AddWithValue("@zonename", zonename);
            comm.Parameters.AddWithValue("@empcodelist", empcodelist);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@toprange", toprange);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportMKT data = new cGetResultReportMKT();

                data.seqno = rdr["seqno"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.CustProvince = rdr["CustProvince"].ToString();
                data.CusType = rdr["CusType"].ToString();
                data.totaltreeyear = rdr["totaltreeyear"].ToString();
                data.totaltwoyear = rdr["totaltwoyear"].ToString();
                data.totalytdlast = rdr["totalytdlast"].ToString();
                data.totalytdnow = rdr["totalytdnow"].ToString();
                data.variance = rdr["variance"].ToString();
                data.mjan = rdr["mjan"].ToString();
                data.mfeb = rdr["mfeb"].ToString();
                data.mmar = rdr["mmar"].ToString();
                data.mapr = rdr["mapr"].ToString();
                data.mmay = rdr["mmay"].ToString();
                data.mjun = rdr["mjun"].ToString();
                data.mjul = rdr["mjul"].ToString();
                data.maug = rdr["maug"].ToString();
                data.msep = rdr["msep"].ToString();
                data.moct = rdr["moct"].ToString();
                data.mnov = rdr["mnov"].ToString();
                data.mdec = rdr["mdec"].ToString();
                data.ZoneId = rdr["ZoneId"].ToString();
                data.ZoneName = rdr["ZoneName"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportMktTopRangeR2(string zoneid, string zonename, string empcodelist, string docudate, string toprange)
        {
            List<cGetResultReportMKT> datas = new List<cGetResultReportMKT>();
            SqlCommand comm = new SqlCommand("ProCReportTotalSale_TopRangeR2", conn.OpenConn());
            comm.Parameters.AddWithValue("@zoneid", zoneid);
            comm.Parameters.AddWithValue("@zonename", zonename);
            comm.Parameters.AddWithValue("@empcodelist", empcodelist);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@toprange", toprange);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportMKT data = new cGetResultReportMKT();

                data.seqno = rdr["seqno"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.CustProvince = rdr["CustProvince"].ToString();
                data.CusType = rdr["CusType"].ToString();
                data.totaltreeyear = rdr["totaltreeyear"].ToString();
                data.totaltwoyear = rdr["totaltwoyear"].ToString();
                data.totalytdlast = rdr["totalytdlast"].ToString();
                data.totalytdnow = rdr["totalytdnow"].ToString();
                data.variance = rdr["variance"].ToString();
                data.mjan = rdr["mjan"].ToString();
                data.mfeb = rdr["mfeb"].ToString();
                data.mmar = rdr["mmar"].ToString();
                data.mapr = rdr["mapr"].ToString();
                data.mmay = rdr["mmay"].ToString();
                data.mjun = rdr["mjun"].ToString();
                data.mjul = rdr["mjul"].ToString();
                data.maug = rdr["maug"].ToString();
                data.msep = rdr["msep"].ToString();
                data.moct = rdr["moct"].ToString();
                data.mnov = rdr["mnov"].ToString();
                data.mdec = rdr["mdec"].ToString();
                data.ZoneId = rdr["ZoneId"].ToString();
                data.ZoneName = rdr["ZoneName"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportMktTopRangeSum(string zoneid, string zonename, string empcodelist, string docudate, string toprange)
        {
            List<cGetResultReportMKTSum> datas = new List<cGetResultReportMKTSum>();
            SqlCommand comm = new SqlCommand("ProCReportTotalSale_TopRangeSum", conn.OpenConn());
            comm.Parameters.AddWithValue("@zoneid", zoneid);
            comm.Parameters.AddWithValue("@zonename", zonename);
            comm.Parameters.AddWithValue("@empcodelist", empcodelist);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@toprange", toprange);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportMKTSum data = new cGetResultReportMKTSum();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.totaltreeyear = rdr["totaltreeyear"].ToString();
                data.totaltwoyear = rdr["totaltwoyear"].ToString();
                data.totalytdlast = rdr["totalytdlast"].ToString();
                data.totalytdnow = rdr["totalytdnow"].ToString();
                data.variance = rdr["variance"].ToString();                
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportMktTopRangeSumR2(string zoneid, string zonename, string empcodelist, string docudate, string toprange)
        {
            List<cGetResultReportMKTSum> datas = new List<cGetResultReportMKTSum>();
            SqlCommand comm = new SqlCommand("ProCReportTotalSale_TopRangeSumR2", conn.OpenConn());
            comm.Parameters.AddWithValue("@zoneid", zoneid);
            comm.Parameters.AddWithValue("@zonename", zonename);
            comm.Parameters.AddWithValue("@empcodelist", empcodelist);
            comm.Parameters.AddWithValue("@docudate", docudate);
            comm.Parameters.AddWithValue("@toprange", toprange);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportMKTSum data = new cGetResultReportMKTSum();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.totaltreeyear = rdr["totaltreeyear"].ToString();
                data.totaltwoyear = rdr["totaltwoyear"].ToString();
                data.totalytdlast = rdr["totalytdlast"].ToString();
                data.totalytdnow = rdr["totalytdnow"].ToString();
                data.variance = rdr["variance"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportYeartodateByProduct(string yearstart, string yearend, string monthstart, string monthend) {
            List<cGetResultReportYeartodateByProduct> datas = new List<cGetResultReportYeartodateByProduct>();
            SqlCommand comm = new SqlCommand("spReportTotalSalesYearTodateByProd", conn.OpenConn());
            comm.Parameters.AddWithValue("@yearstart", yearstart);
            comm.Parameters.AddWithValue("@yearend", yearend);
            comm.Parameters.AddWithValue("@monthstart", monthstart);
            comm.Parameters.AddWithValue("@monthend", monthend);
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportYeartodateByProduct data = new cGetResultReportYeartodateByProduct();
                data.id = rdr["id"].ToString();
                data.prodname = rdr["prodname"].ToString();
                data.totalsales = rdr["totalsales"].ToString();
                data.netsales = rdr["netsales"].ToString();
                data.grandsales = rdr["grandsales"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetResultReportYeartodateBySales(string yearstart, string yearend, string monthstart, string monthend)
        {
            List<cGetResultReportYeartodateBySales> datas = new List<cGetResultReportYeartodateBySales>();
            SqlCommand comm = new SqlCommand("spReportTotalSalesYearTodateBySales", conn.OpenConn());
            comm.Parameters.AddWithValue("@yearstart", yearstart);
            comm.Parameters.AddWithValue("@yearend", yearend);
            comm.Parameters.AddWithValue("@monthstart", monthstart);
            comm.Parameters.AddWithValue("@monthend", monthend);
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cGetResultReportYeartodateBySales data = new cGetResultReportYeartodateBySales();
                data.id = rdr["id"].ToString();
                data.prodname = rdr["prodname"].ToString();
                data.totalsales = rdr["totalsales"].ToString();
                data.netsales = rdr["netsales"].ToString();
                data.grandsales = rdr["grandsales"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportSalesCoReport(string sdate, string edate, string soption, string stype, string ssearch) {
            List<cReportSaleCoReport> datas = new List<cReportSaleCoReport>();
            SqlCommand comm = new SqlCommand("sp_DataGolden_SaleCo_Report", conn.OpenConn());
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@soption", soption);
            comm.Parameters.AddWithValue("@stype", stype);
            comm.Parameters.AddWithValue("@search", ssearch);
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cReportSaleCoReport data = new cReportSaleCoReport();
                
                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.CustPONo = rdr["CustPONo"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.Product = rdr["Product"].ToString();
                data.GoodGroupCode = rdr["GoodGroupCode"].ToString();
                data.GoodGroupName = rdr["GoodGroupName"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.Model = rdr["Model"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.pLength = rdr["pLength"].ToString();
                data.pQuantity = rdr["pQuantity"].ToString();
                data.Amount = rdr["Amount"].ToString();
                data.RF = rdr["RF"].ToString();
                data.RentAmount = rdr["RentAmount"].ToString();
                data.TotalPrice = rdr["TotalPrice"].ToString();
                data.RentCom = rdr["RentCom"].ToString();
                data.NetCom = rdr["NetCom"].ToString();
                data.RentOther = rdr["RentOther"].ToString();
                data.NetPrice = rdr["NetPrice"].ToString();
                data.NetRF_B = rdr["NetRF_B"].ToString();
                data.NetRF_P = rdr["NetRF_P"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.NetItem = rdr["NetItem"].ToString();
                data.GoodPattnCode = rdr["GoodPattnCode"].ToString();
                data.GoodPattnName = rdr["GoodPattnName"].ToString();
                data.GoodColorCode = rdr["GoodColorCode"].ToString();
                data.GoodColorName = rdr["GoodColorName"].ToString();
                data.CustTypeCode = rdr["CustTypeCode"].ToString();
                data.CustTypeName = rdr["CustTypeName"].ToString();
                data.sRemark = rdr["sRemark"].ToString();
                data.GoodClassCode = rdr["GoodClassCode"].ToString();
                data.GoodClassName = rdr["GoodClassName"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                data.Trs_P = rdr["Trs_P"].ToString();
                data.JobsCode = rdr["JobsCode"].ToString();
                data.JobsName = rdr["JobsName"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetReportSalesCoReportScr(string sdate, string edate, string soption, string stype, string ssearch)
        {
            List<cReportSaleCoReportScr> datas = new List<cReportSaleCoReportScr>();
            SqlCommand comm = new SqlCommand("sp_DataGolden_SaleCo_Report_Scr", conn.OpenConn());
            comm.Parameters.AddWithValue("@sdate", sdate);
            comm.Parameters.AddWithValue("@edate", edate);
            comm.Parameters.AddWithValue("@soption", soption);
            comm.Parameters.AddWithValue("@stype", stype);
            comm.Parameters.AddWithValue("@search", ssearch);
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cReportSaleCoReportScr data = new cReportSaleCoReportScr();

                data.DocuDate = rdr["DocuDate"].ToString();
                data.InvNo = rdr["InvNo"].ToString();
                data.CustPONo = rdr["CustPONo"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.ProductCode = rdr["ProductCode"].ToString();
                data.Product = rdr["Product"].ToString();
                data.GoodGroupCode = rdr["GoodGroupCode"].ToString();
                data.GoodGroupName = rdr["GoodGroupName"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.Model = rdr["Model"].ToString();
                data.GoodName = rdr["GoodName"].ToString();
                data.Amount = rdr["Amount"].ToString();
                data.RF = rdr["RF"].ToString();
                data.RentAmount = rdr["RentAmount"].ToString();
                data.TotalPrice = rdr["TotalPrice"].ToString();
                data.RentCom = rdr["RentCom"].ToString();
                data.NetCom = rdr["NetCom"].ToString();
                data.RentOther = rdr["RentOther"].ToString();
                data.NetPrice = rdr["NetPrice"].ToString();
                data.NetRF_B = rdr["NetRF_B"].ToString();
                data.NetRF_P = rdr["NetRF_P"].ToString();
                data.NetCutSale = rdr["NetCutSale"].ToString();
                data.NetItems = rdr["NetItems"].ToString();
                data.GoodPattnCode = rdr["GoodPattnCode"].ToString();
                data.GoodPattnName = rdr["GoodPattnName"].ToString();
                data.GoodColorCode = rdr["GoodColorCode"].ToString();
                data.GoodColorName = rdr["GoodColorName"].ToString();
                data.CustTypeCode = rdr["CustTypeCode"].ToString();
                data.CustTypeName = rdr["CustTypeName"].ToString();
                data.sRemark = rdr["sRemark"].ToString();
                data.GoodClassCode = rdr["GoodClassCode"].ToString();
                data.GoodClassName = rdr["GoodClassName"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.SaleName = rdr["SaleName"].ToString();
                data.Trs_P = rdr["Trs_P"].ToString();
                data.JobsCode = rdr["JobsCode"].ToString();
                data.JobsName = rdr["JobsName"].ToString();
                data.ID = rdr["ID"].ToString();
                data.Remark = rdr["Remark"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTotalReportBySaleFRPBKK02() {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySaleFRPBKK02", conn.OpenConn());           
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTotalReportBySaleFRPBKK03()
        {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySaleFRPBKK03", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTotalReportBySaleFRPBKK04()
        {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySaleFRPBKK04", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTotalReportBySaleFRPBKK05()
        {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySaleFRPBKK05", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void getTotalReportBySaleFRPBKK06()
        {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySaleFRPBKK06", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
                
        [WebMethod]
        public void getTotalReportBySaleFRP113054()
        {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySale113054", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
                
        [WebMethod]
        public void getTotalReportBySaleTotalFRPBKK()
        {
            List<cTotalReportBySaleFRPBKK02> datas = new List<cTotalReportBySaleFRPBKK02>();
            SqlCommand comm = new SqlCommand("spTotalReportBySaleTotalFRPBKK", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 1200;

            SqlDataReader rdr = comm.ExecuteReader();
            //DataTable dt = new DataTable();
            //dt.Load(rdr);

            while (rdr.Read())
            {
                cTotalReportBySaleFRPBKK02 data = new cTotalReportBySaleFRPBKK02();

                data.xYear = rdr["xYear"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.Jan = rdr["Jan"].ToString();
                data.Feb = rdr["Feb"].ToString();
                data.Mar = rdr["Mar"].ToString();
                data.Apr = rdr["Apr"].ToString();
                data.May = rdr["May"].ToString();
                data.Jun = rdr["Jun"].ToString();
                data.Jul = rdr["Jul"].ToString();
                data.Aug = rdr["Aug"].ToString();
                data.Sep = rdr["Sep"].ToString();
                data.Oct = rdr["Oct"].ToString();
                data.Nov = rdr["Nov"].ToString();
                data.Dec = rdr["Dec"].ToString();
                data.TotalYearTodate = rdr["TotalYearTodate"].ToString();
                data.TotalAllYear = rdr["TotalAllYear"].ToString();

                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }
    }
}
