using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace totalsale_report
{
    public class cGetInvoiceDetails
    {
        public string DocuNo { get; set; }
        public string DocuDate { get; set; }
        public string Product { get; set; }
        public string GoodCode { get; set; }
        public string Model { get; set; }
        public string Amount { get; set; }
        public string RentAmount { get; set; }
        public string TotalPrice { get; set; }
    }
}