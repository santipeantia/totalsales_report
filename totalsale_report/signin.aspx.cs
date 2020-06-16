using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.IO;
using System.Text;

namespace totalsale_report
{
    public partial class signin : System.Web.UI.Page
    {
        totalsale_report.dbConnection dbConn = new totalsale_report.dbConnection();

        string ssql;
        DataTable dt = new DataTable();

        public static string strErorConn = "";

        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlTransaction transac;

        public string strMsgAlert = "";
        public string strTblDetail = "";
        public string strTblActive = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                strErorConn = "";
            }
        }

        protected void btnLogin_click (object sender, EventArgs e) {
            try
            {
                string strUserName = Request.Form["inpUserName"];
                string strPassWord = Request.Form["inpPassWord"];

                //string encassword = encryptpass(strPassWord);

                ssql = "exec spGetUserLogin '"+ strUserName + "', '"+ strPassWord + "' ";
                dt = new DataTable();
                dt = dbConn.GetDataTable(ssql);

                if (dt.Rows.Count != 0)
                {
                    Session["usr_id"] = dt.Rows[0]["usr_id"].ToString();
                    Session["emp_id"] = dt.Rows[0]["emp_id"].ToString();
                    Session["usr_name"] = dt.Rows[0]["usr_name"].ToString();
                    Session["usr_password"] = dt.Rows[0]["usr_password"].ToString();

                    Response.Redirect("default.aspx");                  
                }
                else
                {

                    //Session["isLogin"] = Convert.ToInt32(Session["isLogin"].ToString()) + 1;

                    //if (Convert.ToInt32(Session["isLogin"]) == 3)
                    //{
                    //    strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                    //            "   <strong>Warning!</strong><br />Password is wrong 3 times, this account is locked please contact administrator..!</div>";
                    //}
                    //else
                    //{
                    //    strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                    //            "   <strong>Warning!</strong><br />Incorrect username or password..!</div>";
                    //}

                    strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Find not found username or password please check..!</div> ";

                    //Response.Redirect("signin.aspx");

                    return;
                }
            }
            catch (Exception ex)
            {
                strErorConn = " <div class=\"fad fad-in alert alert-danger input-sm\"> " +
                                "   <strong>Warning!</strong><br />Incorrect username or password <br /> " + ex.Message + "</div> ";
                //divWraning.Visible = true;
            }
        }


    }
}