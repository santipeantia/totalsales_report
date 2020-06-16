using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Web.Script.Serialization;


namespace totalsale_report.xSetting
{
    /// <summary>
    /// Summary description for createmenupages_srv
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class createmenupages_srv : System.Web.Services.WebService
    {
        //string cs = "server=SANTI-IT;database=DB_TotalSalesReport;uid=sa;pwd=AmpelitE88;";
        dbConnection conn = new dbConnection();  // inherit class connection into webservice

        [WebMethod]
        public void GetInsertMenuPage(string mnu_type_id, string mnu_page, string mnu_title, string mnu_seqno, string isactive, string created_by, string create_date, string update_by, string update_date)
        {
            //List<GetInsertCompany> companies = new List<GetInsertCompany>();
            //using (SqlConnection conn = new SqlConnection(cs))
            //{
               //conn.OpenConn();
                SqlCommand comm = new SqlCommand("spInsertMenuPage", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;

                comm.Parameters.AddWithValue("@mnu_type_id", mnu_type_id);
                comm.Parameters.AddWithValue("@mnu_page", mnu_page);
                comm.Parameters.AddWithValue("@mnu_title", mnu_title);
                comm.Parameters.AddWithValue("@mnu_seqno", mnu_seqno);
                comm.Parameters.AddWithValue("@isactive", isactive);
                comm.Parameters.AddWithValue("@created_by", created_by);
                comm.Parameters.AddWithValue("@create_date", create_date);
                comm.Parameters.AddWithValue("@update_by", update_by);
                comm.Parameters.AddWithValue("@update_date", update_date);

                comm.ExecuteNonQuery();
                conn.CloseConn();
        //    }
        }

        [WebMethod]
        public void GetDataPageMenuAll()
        {
            List<cGetDataPageMenuAll> menus = new List<cGetDataPageMenuAll>();
            //using (SqlConnection conn = new SqlConnection(cs))
            //{
                SqlCommand comm = new SqlCommand("spGetDataMenuAll", conn.OpenConn());
                comm.CommandType = CommandType.StoredProcedure;
                //conn.Open();

                SqlDataReader rdr = comm.ExecuteReader();
                while (rdr.Read())
                {
                    cGetDataPageMenuAll menu = new cGetDataPageMenuAll();
                    menu.mnu_type_id = rdr["mnu_type_id"].ToString();
                    menu.mnu_type_name = rdr["mnu_type_name"].ToString();
                    menu.mnu_id = rdr["mnu_id"].ToString();
                    menu.mnu_page = rdr["mnu_page"].ToString();
                    menu.mnu_title = rdr["mnu_title"].ToString();
                    menu.mnu_seqno = rdr["mnu_seqno"].ToString();
                   
                    menus.Add(menu);
                }
            //}
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(menus));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataUserLists(string mnuid)
        {
            List<cGetDataUserLists> users = new List<cGetDataUserLists>();
            SqlCommand comm = new SqlCommand("spGetUserList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@mnuid", Value = mnuid };
            comm.Parameters.Add(param1);

            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetDataUserLists user = new cGetDataUserLists();
                user.empid = rdr["empid"].ToString();
                user.firstname = rdr["firstname"].ToString();
                user.lastname = rdr["lastname"].ToString();
                user.urllink = rdr["urllink"].ToString();
                users.Add(user);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(users));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDataMemberLists(int mnuid)
        {
            List<cGetDataMemberLists> members = new List<cGetDataMemberLists>();
            SqlCommand comm = new SqlCommand("spGetMemberList", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@mnuid", Value = mnuid };
            comm.Parameters.Add(param1);
          
            SqlDataReader rdr = comm.ExecuteReader();
            while (rdr.Read())
            {
                cGetDataMemberLists member = new cGetDataMemberLists();
                member.empid = rdr["empid"].ToString();
                member.firstname = rdr["firstname"].ToString();
                member.lastname = rdr["lastname"].ToString();
                member.urllink = rdr["urllink"].ToString();
                member.mnupage = rdr["mnupage"].ToString();
                members.Add(member);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(members));
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDeleteMemberLists(string mnuid, string empid)
        {
            SqlCommand comm = new SqlCommand("spDeleteMemberLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@mnuid", mnuid);
            comm.Parameters.AddWithValue("@empid", empid);

            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetSaveMemberLists(string mnuid, string empid, string isactive, string isdelete, string usrcreate)
        {
            SqlCommand comm = new SqlCommand("spSaveMemberLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;

            comm.Parameters.AddWithValue("@mnuid", mnuid);
            comm.Parameters.AddWithValue("@empid", empid);
            comm.Parameters.AddWithValue("@isactive", isactive);
            comm.Parameters.AddWithValue("@isdelete", isdelete);
            comm.Parameters.AddWithValue("@usrcreate", usrcreate);

            comm.ExecuteNonQuery();
            conn.CloseConn();
        }

        [WebMethod]
        public void GetDeleteMenuLists(string mnuid)
        {
            SqlCommand comm = new SqlCommand("spDeleteMenuLists", conn.OpenConn());
            comm.CommandType = CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@mnuid", mnuid);
     
            comm.ExecuteNonQuery();
            conn.CloseConn();
        }
    }
}
