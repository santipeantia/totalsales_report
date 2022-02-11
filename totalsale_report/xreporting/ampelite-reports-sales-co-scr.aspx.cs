using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Text;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using OfficeOpenXml.FormulaParsing.Excel.Functions.DateTime;

namespace totalsale_report.xreporting
{
    public partial class ampelite_reports_sales_co_scr : System.Web.UI.Page
    {
        dbConnection conn = new dbConnection();
        ExcelPackage excel = new ExcelPackage();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void msgOKonly(string Message)
        {
            string strScript = "<script language = JavaScript > ";
            strScript += "alert(\"" + Message + "\");";
            strScript += "</script>";
            if ((!Page.IsStartupScriptRegistered("clientScript")))
                Page.RegisterStartupScript("clientScript", strScript);
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                string sdate = Request.Form["hidsdate"];
                string edate = Request.Form["hidedate"];
                string soption = Request.Form["hidoption"];
                string stype = Request.Form["hidtype"];
                string ssearch = Request.Form["hidsearch"];

                string gdate = DateTime.Now.ToString("yyyyMMddhhmmss");


                SqlCommand comm = new SqlCommand("sp_DataGolden_SaleCo_Report_Scr", conn.OpenConn());
                comm.Parameters.AddWithValue("@sdate", sdate);
                comm.Parameters.AddWithValue("@edate", edate);
                comm.Parameters.AddWithValue("@soption", soption);
                comm.Parameters.AddWithValue("@stype", stype);
                comm.Parameters.AddWithValue("@search", ssearch);
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandTimeout = 1200;

                SqlDataAdapter da = new SqlDataAdapter();
                DataTable dt = new DataTable();
                da.SelectCommand = comm;
                da.Fill(dt);
                conn.CloseConn();

                if (dt != null && dt.Rows.Count > 0)
                {
                    if (soption == "true" && ssearch == "")
                    {
                        // create object for the StringBuilder class
                        StringBuilder sb = new StringBuilder();

                        // Get name of columns from datatable and assigned to the string array
                        string[] columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName).ToArray();

                        // Create comma sprated column name based on the items contains string array columnNames
                        sb.AppendLine(string.Join(",", columnNames));

                        // Fatch rows from datatable and append values as comma saprated to the object of StringBuilder class 
                        foreach (DataRow row in dt.Rows)
                        {
                            IEnumerable<string> fields = row.ItemArray.Select(field => string.Concat("\"", field.ToString().Replace("\"", "\"\""), "\""));
                            sb.AppendLine(string.Join(",", fields));
                        }

                        // save the file
                        File.WriteAllText(@"D:\AmpelScrew" + gdate + ".csv", sb.ToString(), Encoding.Unicode);

                        msgOKonly("please check your data on D:\\\\AmpelScrew" + gdate + ".csv");
                    }
                    else
                    {

                        var workSheet = excel.Workbook.Worksheets.Add("AmpelReportSalesCo_" + ssearch);
                        var totalCols = dt.Columns.Count;
                        var totalrows = dt.Rows.Count;

                        workSheet.Cells[1, 1, 1, 40].Merge = true;
                        workSheet.Cells[1, 1, 1, 40].Value = "Ampel Report Suppurt Sales-Co";
                        workSheet.Cells[1, 1, 1, 40].Style.Font.Size = 20;
                        workSheet.Cells[1, 1, 1, 40].Style.Font.Name = "TH SarabunPSK";
                        workSheet.Cells[1, 1, 1, 40].Style.Font.Bold = true;

                        workSheet.Cells[2, 1, 2, 40].Merge = true;
                        workSheet.Cells[2, 1, 2, 40].Value = "รายงานการสั่งขายสินค้า จากวันที่ " + sdate + " ถึง " + edate + " คำค้นหา: " + ssearch;
                        workSheet.Cells[2, 1, 2, 40].Style.Font.Size = 16;
                        workSheet.Cells[2, 1, 2, 40].Style.Font.Name = "TH SarabunPSK";
                        workSheet.Cells[2, 1, 2, 40].Style.Font.Bold = true;

                        for (int cols = 0; cols < dt.Columns.Count; cols++)
                        {
                            workSheet.Cells[3, cols + 1].Style.Font.Size = 16;
                            workSheet.Cells[3, cols + 1].Style.Font.Name = "TH SarabunPSK";
                            workSheet.Cells[3, cols + 1].Style.Font.Bold = true;
                            workSheet.Cells[3, cols + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                            workSheet.Cells[3, cols + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                            workSheet.Cells[3, cols + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                            workSheet.Cells[3, cols + 1].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                            workSheet.Cells[3, cols + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        }

                        workSheet.Cells[3, 1, 3, 1].Value = dt.Columns[0].ColumnName;
                        workSheet.Cells[3, 2, 3, 2].Value = dt.Columns[1].ColumnName;
                        workSheet.Cells[3, 3, 3, 3].Value = dt.Columns[2].ColumnName;
                        workSheet.Cells[3, 4, 3, 4].Value = dt.Columns[3].ColumnName;
                        workSheet.Cells[3, 5, 3, 5].Value = dt.Columns[4].ColumnName;
                        workSheet.Cells[3, 6, 3, 6].Value = dt.Columns[5].ColumnName;
                        workSheet.Cells[3, 7, 3, 7].Value = dt.Columns[6].ColumnName;
                        workSheet.Cells[3, 8, 3, 8].Value = dt.Columns[7].ColumnName;
                        workSheet.Cells[3, 9, 3, 9].Value = dt.Columns[8].ColumnName;
                        workSheet.Cells[3, 10, 3, 10].Value = dt.Columns[9].ColumnName;
                        workSheet.Cells[3, 11, 3, 11].Value = dt.Columns[10].ColumnName;
                        workSheet.Cells[3, 12, 3, 12].Value = dt.Columns[11].ColumnName;
                        workSheet.Cells[3, 13, 3, 13].Value = dt.Columns[12].ColumnName;
                        workSheet.Cells[3, 14, 3, 14].Value = dt.Columns[13].ColumnName;
                        workSheet.Cells[3, 15, 3, 15].Value = dt.Columns[14].ColumnName;
                        workSheet.Cells[3, 16, 3, 16].Value = dt.Columns[15].ColumnName;
                        workSheet.Cells[3, 17, 3, 17].Value = dt.Columns[16].ColumnName;
                        workSheet.Cells[3, 18, 3, 18].Value = dt.Columns[17].ColumnName;
                        workSheet.Cells[3, 19, 3, 19].Value = dt.Columns[18].ColumnName;
                        workSheet.Cells[3, 20, 3, 20].Value = dt.Columns[19].ColumnName;
                        workSheet.Cells[3, 21, 3, 21].Value = dt.Columns[20].ColumnName;
                        workSheet.Cells[3, 22, 3, 22].Value = dt.Columns[21].ColumnName;
                        workSheet.Cells[3, 23, 3, 23].Value = dt.Columns[22].ColumnName;
                        workSheet.Cells[3, 24, 3, 24].Value = dt.Columns[23].ColumnName;
                        workSheet.Cells[3, 25, 3, 25].Value = dt.Columns[24].ColumnName;
                        workSheet.Cells[3, 26, 3, 26].Value = dt.Columns[25].ColumnName;
                        workSheet.Cells[3, 27, 3, 27].Value = dt.Columns[26].ColumnName;
                        workSheet.Cells[3, 28, 3, 28].Value = dt.Columns[27].ColumnName;
                        workSheet.Cells[3, 29, 3, 29].Value = dt.Columns[28].ColumnName;
                        workSheet.Cells[3, 30, 3, 30].Value = dt.Columns[29].ColumnName;
                        workSheet.Cells[3, 31, 3, 31].Value = dt.Columns[30].ColumnName;
                        workSheet.Cells[3, 32, 3, 32].Value = dt.Columns[31].ColumnName;
                        workSheet.Cells[3, 33, 3, 33].Value = dt.Columns[32].ColumnName;
                        workSheet.Cells[3, 34, 3, 34].Value = dt.Columns[33].ColumnName;
                        workSheet.Cells[3, 35, 3, 35].Value = dt.Columns[34].ColumnName;
                        workSheet.Cells[3, 36, 3, 36].Value = dt.Columns[35].ColumnName;
                        workSheet.Cells[3, 37, 3, 37].Value = dt.Columns[36].ColumnName;
                        workSheet.Cells[3, 38, 3, 38].Value = dt.Columns[37].ColumnName;
                        workSheet.Cells[3, 39, 3, 39].Value = dt.Columns[38].ColumnName;
                        workSheet.Cells[3, 40, 3, 40].Value = dt.Columns[39].ColumnName;


                        for (int rows = 0; rows < totalrows; rows++) // Loop Data
                        {
                            for (int cols = 0; cols < totalCols; cols++)
                            {

                                //if (Dt.Rows[rows][cols].Equals(0) == 0){vartmp = "";}
                                //else{vartmp = Convert.ToDouble(Dt.Rows[rows][cols]);}
                                //workSheet.Cells[rows + 5, cols + 1].Value = Dt.Rows[rows][cols].ToString();
                                //workSheet.Cells[rows + 5, cols + 1].Value = vartmp;
                                workSheet.Cells[rows + 4, cols + 1].Value = dt.Rows[rows][cols];

                                workSheet.Column(cols + 1).Width = CountLenghtString(dt, cols, dt.Rows[rows][cols].ToString());

                                workSheet.Cells[rows + 4, cols + 1].Style.Font.Size = 16;
                                workSheet.Cells[rows + 4, cols + 1].Style.Font.Name = "TH SarabunPSK";
                                workSheet.Cells[rows + 4, cols + 1].Style.Font.Bold = false;
                                workSheet.Cells[rows + 4, cols + 1].Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                                workSheet.Cells[rows + 4, cols + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                workSheet.Cells[rows + 4, cols + 1].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                                workSheet.Cells[rows + 4, cols + 1].Style.Border.Right.Style = ExcelBorderStyle.Thin;
                                workSheet.Cells[rows + 4, cols + 1].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                                //if (cols + 1 == 1)
                                //{
                                //    workSheet.Column(cols + 1).Width = CountLenghtString(dt, cols, dt.Rows[rows][cols].ToString());
                                //}


                            }
                        }


                        byte[] bin = excel.GetAsByteArray();

                        //clear the buffer stream
                        Response.ClearHeaders();
                        Response.Clear();
                        Response.Buffer = true;

                        //set the correct contenttype
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                        //set the correct length of the data being send
                        Response.AddHeader("content-length", bin.Length.ToString());

                        //set the filename for the excel package
                        Response.AddHeader("content-disposition", "attachment; filename=\"AmpelScrewSalesCo_" + sdate + ".xlsx\"");

                        //send the byte array to the browser
                        Response.OutputStream.Write(bin, 0, bin.Length);

                        //cleanup
                        Response.Flush();
                        HttpContext.Current.ApplicationInstance.CompleteRequest();

                        Response.End();
                    }
                }
            }
            catch (Exception ex)
            {

            }

        }

        static int CountLenghtString(DataTable Dt, int cols, string header)
        {
            int countChar = header.Length;
            int counter = Dt.Rows.Count;


            for (int i = 0; i <= counter - 1; i++)
            {
                string CustCode = Dt.Rows[i][cols].ToString();
                if (countChar < CustCode.Length) { countChar = CustCode.Length; }
            }

            return countChar;

        }
    }
}