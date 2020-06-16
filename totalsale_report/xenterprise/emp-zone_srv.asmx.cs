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

namespace totalsale_report.xenterprise
{
    /// <summary>
    /// Summary description for emp_zone_srv
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class emp_zone_srv : System.Web.Services.WebService
    {
        dbConnection conn = new dbConnection();

        [WebMethod]
        public void GetZoneLists() {
            List<cGetZoneLists> datas = new List<cGetZoneLists>();
            SqlCommand comm = new SqlCommand("spGetZoneLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read()) {
                cGetZoneLists data = new cGetZoneLists();
                data.zone_id = rdr["zone_id"].ToString();
                data.zone_desc = rdr["zone_desc"].ToString();
                data.isactive = rdr["isactive"].ToString();
                data.status_desc = rdr["status_desc"].ToString();
                data.firstname = rdr["firstname"].ToString();
                data.lastname = rdr["lastname"].ToString();
                data.created_by = rdr["created_by"].ToString();
                data.create_date = rdr["create_date"].ToString();
                data.update_by = rdr["update_by"].ToString();
                data.update_date = rdr["update_date"].ToString();
                data.urlview = rdr["urlview"].ToString();
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
        public void GetSavechangeZone(string trans_id, string zone_id, string zone_desc, string isactive, string head_id, string head_name, string created_by, string create_date, string update_by, string update_date) {

            SqlCommand comm = new SqlCommand("spGetSavechangeZone", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@trans_id", trans_id);
            comm.Parameters.AddWithValue("@zone_id", zone_id);
            comm.Parameters.AddWithValue("@zone_desc", zone_desc);
            comm.Parameters.AddWithValue("@isactive", isactive);
            comm.Parameters.AddWithValue("@head_id", head_id);
            comm.Parameters.AddWithValue("@head_name", head_name);
            comm.Parameters.AddWithValue("@created_by", created_by);
            comm.Parameters.AddWithValue("@create_date", create_date);
            comm.Parameters.AddWithValue("@update_by", update_by);
            comm.Parameters.AddWithValue("@update_date", update_date);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetZoneActivebyId(string zone_id)
        {
            List<cGetZoneActivebyId> datas = new List<cGetZoneActivebyId>();
            SqlCommand comm = new SqlCommand("spGetZoneActivebyid", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@zone_id", zone_id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetZoneActivebyId data = new cGetZoneActivebyId();
                data.zone_id = rdr["zone_id"].ToString();
                data.zone_desc = rdr["zone_desc"].ToString();
                data.isactive = rdr["isactive"].ToString();
                data.head_id = rdr["head_id"].ToString();
                data.head_name = rdr["head_name"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();

        }

        [WebMethod]
        public void GetSaleLists() {
            List<cGetSaleLists> datas = new List<cGetSaleLists>();
            SqlCommand comm = new SqlCommand("spGetZoneSaleLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetSaleLists data = new cGetSaleLists();
                data.emp_id = rdr["emp_id"].ToString();
                data.prefix = rdr["prefix"].ToString();
                data.fullname = rdr["fullname"].ToString();
                data.position = rdr["position"].ToString();
                data.urllink = rdr["urllink"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetZoneMemberLists(string zone_id)
        {
            List<cGetZoneMemberLists> datas = new List<cGetZoneMemberLists>();
            SqlCommand comm = new SqlCommand("spZoneMemberLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@zone_id", zone_id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetZoneMemberLists data = new cGetZoneMemberLists();
                data.zone_memid = rdr["zone_memid"].ToString();
                data.zone_id = rdr["zone_id"].ToString();
                data.emp_id = rdr["emp_id"].ToString();
                data.fullname = rdr["fullname"].ToString();
                data.position = rdr["position"].ToString();
                data.zone_desc = rdr["zone_desc"].ToString();
                data.isactive = rdr["isactive"].ToString();
                data.created_by = rdr["created_by"].ToString();
                data.create_date = rdr["create_date"].ToString();
                data.update_by = rdr["update_by"].ToString();
                data.update_date = rdr["update_date"].ToString();
                data.urltrash = rdr["urltrash"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();            
        }

        [WebMethod]
        public void GetZoneCateLists(string zone_id)
        {
            List<cGetZoneCateLists> datas = new List<cGetZoneCateLists>();
            SqlCommand comm = new SqlCommand("spZoneCateLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@zone_id", zone_id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetZoneCateLists data = new cGetZoneCateLists();
                data.zone_catid = rdr["zone_id"].ToString();
                data.zone_id = rdr["zone_id"].ToString();
                data.catecode = rdr["catecode"].ToString();
                data.catename = rdr["catename"].ToString();
                data.urllink = rdr["urllink"].ToString();              
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetZoneCategory(string zone_id)
        {
            List<cGetZoneCategory> datas = new List<cGetZoneCategory>();
            SqlCommand comm = new SqlCommand("spGetZoneCategory", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@zone_id", zone_id);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetZoneCategory data = new cGetZoneCategory();
                data.CateID = rdr["CateID"].ToString();
                data.CateCode = rdr["CateCode"].ToString();
                data.CateName = rdr["CateName"].ToString();
                data.CateNameEng = rdr["CateNameEng"].ToString();
                data.urllink = rdr["urllink"].ToString();
                datas.Add(data);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(datas));
            Context.Response.ContentType = "application/json";
            conn.CloseConn();
        }

        [WebMethod]
        public void GetZoneMemberSaveChanges(string trans_id, string zone_memid, string zone_id, string emp_id, string fullname, 
                                            string position, string zone_desc, string isactive, string created_by, string create_date, string update_by, string update_date)
        {
            SqlCommand comm = new SqlCommand("spZoneMemberSaveChanges", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@trans_id", trans_id);
            comm.Parameters.AddWithValue("@zone_memid", zone_memid);
            comm.Parameters.AddWithValue("@zone_id", zone_id);
            comm.Parameters.AddWithValue("@emp_id", emp_id);
            comm.Parameters.AddWithValue("@fullname", fullname);
            comm.Parameters.AddWithValue("@position", position);
            comm.Parameters.AddWithValue("@zone_desc", zone_desc);
            comm.Parameters.AddWithValue("@isactive", isactive);
            comm.Parameters.AddWithValue("@created_by", created_by);
            comm.Parameters.AddWithValue("@create_date", create_date);
            comm.Parameters.AddWithValue("@update_by", update_by);
            comm.Parameters.AddWithValue("@update_date", update_date);
            comm.ExecuteNonQuery();
            conn.CloseConn();

        }

        [WebMethod]
        public void GetZoneCateSaveChanges(string trans_id, string zone_catid, string zone_id, string catecode, string catename, 
                                            string zone_desc, string isactive, string created_by, string create_date, string update_by, string update_date)
        {
            SqlCommand comm = new SqlCommand("spZoneCateSaveChanges", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@trans_id", trans_id);
            comm.Parameters.AddWithValue("@zone_catid", zone_catid);
            comm.Parameters.AddWithValue("@zone_id", zone_id);
            comm.Parameters.AddWithValue("@catecode", catecode);
            comm.Parameters.AddWithValue("@catename", catename);
            comm.Parameters.AddWithValue("@zone_desc", zone_desc);
            comm.Parameters.AddWithValue("@isactive", isactive);
            comm.Parameters.AddWithValue("@created_by", created_by);
            comm.Parameters.AddWithValue("@create_date", create_date);
            comm.Parameters.AddWithValue("@update_by", update_by);
            comm.Parameters.AddWithValue("@update_date", update_date);
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
    }
}
