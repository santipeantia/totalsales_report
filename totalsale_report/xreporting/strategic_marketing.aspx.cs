using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Data;

namespace totalsale_report.xreporting
{
    public partial class strategic_marketing : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();

        public string strTblDetail = "";
        public string ssdate = "";
        public string eedate = "";

        public string current_name_month = "current_month";
        public string current_name_year = "Year";
        public string previouse_name_year = "Year";
        public string previouse_name_month = "previouse_month";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["emp_id"] != null)
                {
                    //todo something......
                }
                else
                {
                    Response.Redirect("../signin.aspx");
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnReport_click(object sender, EventArgs e) {

            string sdate = Request.Form["datepickerstart"];
            string edate = Request.Form["datepickerend"];

            if (sdate == "" || edate == "")
            {
                return;
            }
            else
            {
                getStrategicReport(sdate, edate);
            }
        }

        protected void getStrategicReport(string sdate, string edate)
        {

            Conn = new SqlConnection();
            Conn = dbConn.OpenConn();

            Comm = new SqlCommand("spRptReportStrategic", Conn);
            Comm.CommandType = CommandType.StoredProcedure;

            SqlParameter param1 = new SqlParameter() { ParameterName = "@sdate", Value = sdate };
            SqlParameter param2 = new SqlParameter() { ParameterName = "@edate", Value = edate };
            Comm.Parameters.Add(param1);
            Comm.Parameters.Add(param2);
            Comm.ExecuteNonQuery();

            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = Comm;
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    string id = dt.Rows[i]["id"].ToString();
                    string busgroup = dt.Rows[i]["busgroup"].ToString();
                    string sbus = dt.Rows[i]["sbus"].ToString();
                    string target_year = dt.Rows[i]["target_year"].ToString();
                    string ytd_sales_year = dt.Rows[i]["ytd_sales_year"].ToString();
                    string ytd_sales_previous = dt.Rows[i]["ytd_sales_previous"].ToString();
                    string yrcompr = dt.Rows[i]["yrcompr"].ToString();
                    string ytd_target = dt.Rows[i]["ytd_target"].ToString();
                    string target_month = dt.Rows[i]["target_month"].ToString();
                    string target_amount = dt.Rows[i]["target_amount"].ToString();
                    string current_month = dt.Rows[i]["current_month"].ToString();
                    string current_amount = dt.Rows[i]["current_amount"].ToString();
                    string previous_month = dt.Rows[i]["previous_month"].ToString();
                    string previous_amount = dt.Rows[i]["previous_amount"].ToString();
                    string growth = dt.Rows[i]["growth"].ToString();
                    string xsdate = dt.Rows[i]["sdate"].ToString();
                    string xedate = dt.Rows[i]["edate"].ToString();
                    string summary = dt.Rows[i]["summary"].ToString();

                    string xtarget_year = "";
                    if (string.IsNullOrEmpty(target_year))
                    {
                        xtarget_year = "";
                    }
                    else {
                        xtarget_year = double.Parse(target_year).ToString("#,###.#");
                    }

                    string xtarget_amount = "";
                    if (string.IsNullOrEmpty(target_amount))
                    {
                        xtarget_amount = "";
                    }
                    else
                    {
                        xtarget_amount = double.Parse(target_amount).ToString("#,###.#");
                    }

                    string xytd_sales_year = "";
                    if (string.IsNullOrEmpty(ytd_sales_year))
                    {
                        xytd_sales_year = "";
                    }
                    else
                    {
                        xytd_sales_year = double.Parse(ytd_sales_year).ToString("#,###.#");
                    }

                    string xytd_sales_previous = "";
                    if (string.IsNullOrEmpty(ytd_sales_previous))
                    {
                        xytd_sales_previous = "";
                    }
                    else
                    {
                        xytd_sales_previous = double.Parse(ytd_sales_previous).ToString("#,###.#");
                    }

                    string sclass = "";  
                    if (id == "1" || id == "12" || id == "13" || id == "22" || id == "28" || id == "39" || id == "40") {
                        sclass = "style=\"font-weight: bold; text-decoration: underline;\"";
                    }

                    string gclass = "";
                    if (double.Parse(growth) < 0)
                    {
                        gclass = "class=\"text-red\"";
                    }
                    else if (double.Parse(growth) > 0)
                    {
                        gclass = "class=\"text-blue\"";
                    }
                    else { gclass = ""; }

                    string gclasspr = "";
                    if (string.IsNullOrEmpty(yrcompr))
                    {
                        gclasspr = "";
                    }
                    else
                    {
                        if (double.Parse(yrcompr) < 0)
                        {
                            gclasspr = "class=\"text-red\"";
                        }
                        else if (double.Parse(yrcompr) > 0)
                        {
                            gclasspr = "class=\"text-blue\"";
                        }
                        else { gclasspr = ""; }
                    }

                    strTblDetail += "<tr " + sclass + ">" +
                                            "<td class=\"\">" + id + "</td>" +
                                            "<td >" + busgroup + "</td>" +
                                            "<td >" + sbus + "</td>" +
                                            "<td style=\"text-align:right;\">" + xtarget_year + "</td>" +
                                            "<td style=\"text-align:right;\">" + xytd_sales_year + "</td>" +
                                            "<td style=\"text-align:right;\">" + xytd_sales_previous + "</td>" +
                                            "<td " + gclasspr + "style =\"text-align:right;\">" + yrcompr + "</td>" +
                                            "<td style=\"text-align:right;\">" + ytd_target + "</td>" +
                                            "<td class=\"hidden\" style=\"text-align:right;\"" + target_month + "</td>" +
                                            "<td style=\"text-align:right;\">" + xtarget_amount + "</td>" +
                                            "<td class=\"hidden\">" + current_month + "</td>" +
                                            "<td style=\"text-align:right;\">" + double.Parse(current_amount).ToString("#,###.#") + "</td>" +
                                            "<td class=\"hidden\">>" + previous_month + "</td>" +
                                            "<td style=\"text-align:right;\"><span>" + double.Parse(previous_amount).ToString("#,###.#") + "</span></td>" +
                                            "<td " + gclass + "style =\"text-align:right;\"><span>" + growth + "</span></td>" +
                                            "<td class=\"hidden\">" + xsdate + "</td>" +
                                            "<td class=\"hidden\">" + xedate + "</td>" +
                                            "<td ><center><span>" + summary + "</span></center></td>" +
                                    "</tr> ";

                    ssdate = sdate;
                    eedate = edate;

                    current_name_year = Convert.ToDateTime(edate).ToString("yyyy");
                    current_name_month = Convert.ToDateTime(edate).ToString("MMM-yyyy");

                    previouse_name_year = Convert.ToDateTime(edate).AddYears(-1).ToString("yyyy");
                    previouse_name_month = Convert.ToDateTime(edate).AddYears(-1).ToString("MMM-yyyy");
                }
            }
        }
    }

   
}