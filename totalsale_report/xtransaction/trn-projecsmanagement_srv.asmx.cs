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


namespace totalsale_report.xtransaction
{
    /// <summary>
    /// Summary description for trn_projecsmanagement_srv
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class trn_projecsmanagement_srv : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void GetProjectLists()
        {
            List<cGetPrjectLists> datas = new List<cGetPrjectLists>();
            SqlCommand comm = new SqlCommand("spGetProjectLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 600;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetPrjectLists data = new cGetPrjectLists();
                data.ID = rdr["ID"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.ProjectDesc = rdr["ProjectDesc"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();               
                data.urlmember = rdr["urlmember"].ToString();
                data.urltrash = rdr["urltrash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetTransactionMasterWithProjects() {
            try
            {
                List<cGetTransactionMasterWithProjects> datas = new List<cGetTransactionMasterWithProjects>();
                SqlCommand comm = new SqlCommand("spGetProjectsWithTransactionMaster", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandTimeout = 600;

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    cGetTransactionMasterWithProjects data = new cGetTransactionMasterWithProjects();
                    data.DocuNo = rdr["DocuNo"].ToString();
                    data.DocuDate = rdr["DocuDate"].ToString();
                    data.DocuDateDue = rdr["DocuDateDue"].ToString();
                    data.CustCode = rdr["CustCode"].ToString();
                    data.CustName = rdr["CustName"].ToString();
                    data.EmpCode = rdr["EmpCode"].ToString();
                    data.SaleName = rdr["SaleName"].ToString();
                    data.TotalPrice = rdr["TotalPrice"].ToString();
                    data.urlmember = rdr["urlmember"].ToString();
                    datas.Add(data);
                }
                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(datas));
                Context.Response.ContentType = "application/json";
                conn.CloseConn();
            }
            catch (Exception ex)
            {

            }
        }

        [WebMethod]
        public void GetSavechangeProjects(string DocuNo, string DocuDate, string EmpCode, string ProjectDesc, string created_by, string create_date, string update_by, string update_date)
        {
            SqlCommand comm = new SqlCommand("spGetProjectsSavechange", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@DocuNo", DocuNo);
            comm.Parameters.AddWithValue("@DocuDate", DocuDate);            
            comm.Parameters.AddWithValue("@EmpCode", EmpCode);
            comm.Parameters.AddWithValue("@ProjectDesc", ProjectDesc);
            comm.Parameters.AddWithValue("@created_by", created_by);
            comm.Parameters.AddWithValue("@create_date", create_date);
            comm.Parameters.AddWithValue("@update_by", update_by);
            comm.Parameters.AddWithValue("@update_date", update_date);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSavechangeProjectsDesc(string DocuNo, string ProjectDesc, string update_by, string update_date)
        {
            SqlCommand comm = new SqlCommand("spSavechangeProjectsDesc", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@DocuNo", DocuNo);
            comm.Parameters.AddWithValue("@ProjectDesc", ProjectDesc);
            comm.Parameters.AddWithValue("@update_by", update_by);
            comm.Parameters.AddWithValue("@update_date", update_date);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetInvoiceDetails(string docuno)
        {
            List<cGetInvoiceDetails> datas = new List<cGetInvoiceDetails>();
            SqlCommand comm = new SqlCommand("spGetInvoiceDetails", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandTimeout = 600;
            comm.Parameters.AddWithValue("@docuno", docuno);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetInvoiceDetails data = new cGetInvoiceDetails();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.Product = rdr["Product"].ToString();
                data.GoodCode = rdr["GoodCode"].ToString();
                data.Model = rdr["Model"].ToString();
                data.Amount = rdr["Amount"].ToString();
                data.RentAmount = rdr["RentAmount"].ToString();
                data.TotalPrice = rdr["TotalPrice"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDeleteProjects(string docuno)
        {
            SqlCommand comm = new SqlCommand("spGetProjectsDelete", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
    }
}