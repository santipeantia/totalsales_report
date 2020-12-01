using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Data;
using System.ComponentModel;
using System.Threading;

namespace totalsale_report.xreporting
{
    public partial class strategic_marketing : System.Web.UI.Page
    {
        dbConnection dbConn = new dbConnection();
        SqlConnection Conn = new SqlConnection();
        SqlCommand Comm = new SqlCommand();

        public string strTblDetail = "";
        public string strTblDetailSOS = "";

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

        protected void btnReport_click(object sender, EventArgs e)
        {

            string sdate = Request.Form["datepickerstart"];
            string edate = Request.Form["datepickerend"];

            if (sdate == "" || edate == "")
            {
                return;
            }
            else
            {
                getStrategicReport(sdate, edate);
                getStrategicReportSOS(sdate, edate);
            }
        }


        protected void getStrategicReport(string sdate, string edate)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spRptReportStrategic1", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.CommandTimeout = 1200;

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
                        else
                        {
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
                        if (id == "1" || id == "12" || id == "13" || id == "22" || id == "25" || id == "39" || id == "40" || id == "45")
                        {
                            sclass = "style=\"font-weight: bold; text-decoration: underline;\"";
                        }

                        string gclass = "";
                        if (!string.IsNullOrEmpty(growth))
                        {
                            if (double.Parse(growth) < 0)
                            {
                                gclass = "class=\"text-red\"";
                            }
                            else if (double.Parse(growth) > 0)
                            {
                                gclass = "class=\"text-blue\"";
                            }
                            else { gclass = ""; }
                        }


                        string gclasspr = "";
                        if (string.IsNullOrEmpty(yrcompr))
                        {
                            gclasspr = "";
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(yrcompr))
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
                           
                        }

                        string xcurrent;
                        if (!string.IsNullOrEmpty(current_amount))
                        {
                            xcurrent = double.Parse(current_amount).ToString("#,###.#");
                        }
                        else {
                            xcurrent = "";
                        }
                        
                        string xprevious;
                        if (!string.IsNullOrEmpty(previous_amount))
                        {
                            xprevious = double.Parse(previous_amount).ToString("#,###.#");
                        }
                        else
                        {
                            xprevious = "";
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
                                                "<td class=\"hidden\" style=\"text-align:right;\">" + target_month + "</td>" +
                                                "<td style=\"text-align:right;\">" + xtarget_amount + "</td>" +
                                                "<td class=\"hidden\">" + current_month + "</td>" +
                                                "<td style=\"text-align:right;\">" + xcurrent + "</td>" +
                                                "<td class=\"hidden\">" + previous_month + "</td>" +
                                                "<td style=\"text-align:right;\"><span>" + xprevious + "</span></td>" +
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
                else
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('data find not found..!');", true);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "emptyMessage();", true);
                    

                }
            }
            catch (Exception ex)
            {
                string strmsg = "";
                strmsg = ex.Message;
            }

        }

        protected void getStrategicReportSOS(string sdate, string edate)
        {
            try
            {
                Conn = new SqlConnection();
                Conn = dbConn.OpenConn();

                Comm = new SqlCommand("spRptReportStrategicSOS", Conn);
                Comm.CommandType = CommandType.StoredProcedure;
                Comm.CommandTimeout = 1200;

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
                        string rid = dt.Rows[i]["rid"].ToString();

                        string xtarget_year = "";
                        if (string.IsNullOrEmpty(target_year))
                        {
                            xtarget_year = "";
                        }
                        else
                        {
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
                        if (id == "1" || id == "12" || id == "13" || id == "22" || id == "25" || id == "39" || id == "40")
                        {
                            sclass = "style=\"font-weight: bold; text-decoration: underline;\"";
                        }

                        string gclass = "";
                        if (!string.IsNullOrEmpty(growth))
                        {
                            if (double.Parse(growth) < 0)
                            {
                                gclass = "class=\"text-red\"";
                            }
                            else if (double.Parse(growth) > 0)
                            {
                                gclass = "class=\"text-blue\"";
                            }
                            else { gclass = ""; }
                        }


                        string gclasspr = "";
                        if (string.IsNullOrEmpty(yrcompr))
                        {
                            gclasspr = "";
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(yrcompr))
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

                        }

                        string xcurrent;
                        if (!string.IsNullOrEmpty(current_amount))
                        {
                            xcurrent = double.Parse(current_amount).ToString("#,###.#");
                        }
                        else
                        {
                            xcurrent = "";
                        }

                        string xprevious;
                        if (!string.IsNullOrEmpty(previous_amount))
                        {
                            xprevious = double.Parse(previous_amount).ToString("#,###.#");
                        }
                        else
                        {
                            xprevious = "";
                        }

                        strTblDetailSOS += "<tr " + sclass + ">" +
                                                "<td class=\"\">" + id + "</td>" +
                                                "<td >" + busgroup + "</td>" +
                                                "<td >" + sbus + "</td>" +
                                                "<td style=\"text-align:right;\">" + xtarget_year + "</td>" +
                                                "<td style=\"text-align:right;\">" + xytd_sales_year + "</td>" +
                                                "<td style=\"text-align:right;\">" + xytd_sales_previous + "</td>" +
                                                "<td " + gclasspr + "style =\"text-align:right;\">" + yrcompr + "</td>" +
                                                "<td style=\"text-align:right;\">" + ytd_target + "</td>" +
                                                "<td class=\"hidden\" style=\"text-align:right;\">" + target_month + "</td>" +
                                                "<td style=\"text-align:right;\">" + xtarget_amount + "</td>" +
                                                "<td class=\"hidden\">" + current_month + "</td>" +
                                                "<td style=\"text-align:right;\">" + xcurrent + "</td>" +
                                                "<td class=\"hidden\">" + previous_month + "</td>" +
                                                "<td style=\"text-align:right;\"><span>" + xprevious + "</span></td>" +
                                                "<td " + gclass + "style =\"text-align:right;\"><span>" + growth + "</span></td>" +
                                                "<td class=\"hidden\">" + xsdate + "</td>" +
                                                "<td class=\"hidden\">" + xedate + "</td>" +
                                                "<td ><center><span>" + summary + "</span></center></td>" +
                                                "<td ><center><span><i class=\"pointer fa fa-edit text-orange\" title=\"Edit\"></i></span></center></td>" +
                                                "<td ><center><span><i class=\"pointer fa fa-trash text-red\" title=\"Trash\"></i></span></center></td>" +
                                                "<td class=\"hidden\">" + rid + "</td>" +
                                        "</tr> ";

                        ssdate = sdate;
                        eedate = edate;

                        current_name_year = Convert.ToDateTime(edate).ToString("yyyy");
                        current_name_month = Convert.ToDateTime(edate).ToString("MMM-yyyy");

                        previouse_name_year = Convert.ToDateTime(edate).AddYears(-1).ToString("yyyy");
                        previouse_name_month = Convert.ToDateTime(edate).AddYears(-1).ToString("MMM-yyyy");


                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SOS", "updSos();", true);
                    }
                }
                else
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('data find not found..!');", true);
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "emptyMessage();", true);


                }
            }
            catch (Exception ex)
            {
                string strmsg = "";
                strmsg = ex.Message;
            }

        }

        protected void btnSavenew_Click(object sender, EventArgs e) {
            Conn = new SqlConnection();
            Conn = dbConn.OpenConn();

            string id = Request.Form["txtid"];
            string busgroup = Request.Form["txtbusgroup"];
            string sbus = Request.Form["txtsbus"];
            string target_year = Request.Form["txttargetyear"].Replace(",", ""); 
            string ytd_sales_year = Request.Form["txtytdsalesyear"].Replace(",", ""); 
            string ytd_sales_previous = Request.Form["txtytdsalesprevious"].Replace(",", ""); 
            string yrcompr = Request.Form["txtyrcompr"].Replace(",", "");
            string ytd_target = Request.Form["txtytdtarget"].Replace(",", "");
            string target_month = Request.Form["txttargetmonth"].Replace(",", "");
            string target_amount = Request.Form["txttargetamount"].Replace(",", "");
            string current_month = Request.Form["txtcurrentmonth"].Replace(",", "");
            string current_amount = Request.Form["txtcurrentamount"].Replace(",", "");
            string previous_month = Request.Form["txtpreviousmonth"].Replace(",", "");
            string previous_amount = Request.Form["txtpreviousamount"].Replace(",", "");
            string growth = Request.Form["txtgrowth"].Replace(",", "");
            string sdate = Request.Form["datepickerstart"];
            string edate = Request.Form["datepickerend"];
            string summary = Request.Form["txtsummary"];
            string rid = Request.Form["txtrid"];
            string trn = Request.Form["txttrn"];

            Comm = new SqlCommand("spRptReportStrategicSaleSpec", Conn);
            Comm.CommandType = CommandType.StoredProcedure;
            Comm.CommandTimeout = 1200;

            Comm.Parameters.AddWithValue("@id", id);
            Comm.Parameters.AddWithValue("@busgroup", busgroup);
            Comm.Parameters.AddWithValue("@sbus", sbus);
            Comm.Parameters.AddWithValue("@target_year", target_year);
            Comm.Parameters.AddWithValue("@ytd_sales_year", ytd_sales_year);
            Comm.Parameters.AddWithValue("@ytd_sales_previous", ytd_sales_previous);
            Comm.Parameters.AddWithValue("@yrcompr", yrcompr);
            Comm.Parameters.AddWithValue("@ytd_target", ytd_target);
            Comm.Parameters.AddWithValue("@target_month", target_month);
            Comm.Parameters.AddWithValue("@target_amount", target_amount);
            Comm.Parameters.AddWithValue("@current_month", current_month);
            Comm.Parameters.AddWithValue("@current_amount", current_amount);
            Comm.Parameters.AddWithValue("@previous_month", previous_month);
            Comm.Parameters.AddWithValue("@previous_amount", previous_amount);
            Comm.Parameters.AddWithValue("@growth", growth);
            Comm.Parameters.AddWithValue("@sdate", sdate);
            Comm.Parameters.AddWithValue("@edate", edate);
            Comm.Parameters.AddWithValue("@summary", summary);
            Comm.Parameters.AddWithValue("@rid", rid);
            Comm.Parameters.AddWithValue("@trn", trn);
            Comm.ExecuteNonQuery();

            getStrategicReport(sdate, edate);
            getStrategicReportSOS(sdate, edate);

            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SOS", "updSos();", true);

        }
    }
}