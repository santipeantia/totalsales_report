using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace totalsale_report.xtransaction
{
    public partial class projectspecial : System.Web.UI.Page
    {

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
    }
}