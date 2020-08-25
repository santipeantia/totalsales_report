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

namespace totalsale_report.xtransaction
{
    /// <summary>
    /// Summary description for trn_salesconsignee_srv
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class trn_salesconsignee_srv : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void GetSalesConsignee()
        {
            List<cGetSalesConsignee> datas = new List<cGetSalesConsignee>();
            SqlCommand comm = new SqlCommand("spGetSalesConsignee", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetSalesConsignee data = new cGetSalesConsignee();
                data.ConID = rdr["ConID"].ToString();
                data.DocuNo = rdr["DocuNo"].ToString();
                data.DocuDate = rdr["DocuDate"].ToString();
                data.DocuDateDue = rdr["DocuDateDue"].ToString();
                data.EmpCode = rdr["EmpCode"].ToString();
                data.EmpName = rdr["EmpName"].ToString();
                data.CustCode = rdr["CustCode"].ToString();
                data.CustName = rdr["CustName"].ToString();
                data.created_by = rdr["created_by"].ToString();
                data.create_date = rdr["create_date"].ToString();
                data.update_by = rdr["update_by"].ToString();
                data.update_date = rdr["update_date"].ToString();
                data.urlmember = rdr["urlmember"].ToString();
                data.urltrash = rdr["urltrash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetTransactionMasterWithoutConsignee()
        {
            try
            {
                List<cGetTransactionMasterWithoutConsignee> datas = new List<cGetTransactionMasterWithoutConsignee>();
                SqlCommand comm = new SqlCommand("spGetTransactionMasterWithoutConsignee", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandTimeout = 600;

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    cGetTransactionMasterWithoutConsignee data = new cGetTransactionMasterWithoutConsignee();
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
                js.MaxJsonLength = Int32.MaxValue;
                Context.Response.Write(js.Serialize(datas));
                Context.Response.ContentType = "application/json";
                conn.CloseConn();
            }
            catch (Exception ex)
            {

            }           
        }

        [WebMethod]
        public void GetSavechangeSalesConsignee(string DocuNo, string DocuDate, string DocuDateDue, string EmpCode, string EmpName, string CustCode, string CustName, string created_by, string create_date, string update_by, string update_date)
        {
            SqlCommand comm = new SqlCommand("spSalesConsigneeSavechange", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@DocuNo", DocuNo);
            comm.Parameters.AddWithValue("@DocuDate", DocuDate);
            comm.Parameters.AddWithValue("@DocuDateDue", DocuDateDue);
            comm.Parameters.AddWithValue("@EmpCode", EmpCode);
            comm.Parameters.AddWithValue("@EmpName", EmpName);
            comm.Parameters.AddWithValue("@CustCode", CustCode);
            comm.Parameters.AddWithValue("@CustName", CustName);
            comm.Parameters.AddWithValue("@created_by", created_by);
            comm.Parameters.AddWithValue("@create_date", create_date);
            comm.Parameters.AddWithValue("@update_by", update_by);
            comm.Parameters.AddWithValue("@update_date", update_date);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetInvoiceDetails(string docuno) {
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
            js.MaxJsonLength = Int32.MaxValue;
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDeleteSalesConsignee(string docuno)
        {
            SqlCommand comm = new SqlCommand("spGetDeleteSalesConsignee", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@docuno", docuno);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
    }
}
