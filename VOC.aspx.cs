using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MetricsDashboard
{
    public partial class Voc : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string queue;
            if (DropDownList1.SelectedValue == "") 
            {
                queue = "'%TAC%' and u_group <> 'TAC Network L1' ";
            }
            else
            {
                queue = "'" + DropDownList1.SelectedValue + "'"; 
            }
            var query = "select * from SN_VOC where u_group like " + queue + " and sys_created_on >= concat(CURRENT_DATE() - INTERVAL 31 DAY, \" 00:00:00\")" +
                " order by sys_created_on desc";
            SqlDataSource1.SelectCommand = query;
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].ToolTip = "Ticket Number";
                e.Row.Cells[1].ToolTip = "Ticket Owner";
                e.Row.Cells[2].ToolTip = "Fulfilled/Resolved";
                e.Row.Cells[3].ToolTip = "First Time Right";
                e.Row.Cells[4].ToolTip = "Free To Contact";
                e.Row.Cells[5].ToolTip = "Client Satisfaction";
                e.Row.Cells[6].ToolTip = "Communication Experience";
                e.Row.Cells[7].ToolTip = "Communication Status";
                e.Row.Cells[8].ToolTip = "Knowledge and Preparedness";
                e.Row.Cells[9].ToolTip = "Professionalism";
                e.Row.Cells[10].ToolTip = "Timeliness";
               //e.Row.Cells[11].ToolTip = "";
               //e.Row.Cells[12].ToolTip = "";
               //e.Row.Cells[13].ToolTip = "";
               //e.Row.Cells[14].ToolTip = "";
               //e.Row.Cells[15].ToolTip = "";
               //e.Row.Cells[16].ToolTip = "";
               //e.Row.Cells[17].ToolTip = "";
               //e.Row.Cells[18].ToolTip = "";        
            }
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            if (e.Row.Cells[11].Text.Length >= 80)
            {
                e.Row.Cells[11].ToolTip = e.Row.Cells[11].Text;
                e.Row.Cells[11].Text = "Comments truncated please hover over this cell to review.";

                //e.Row.Cells[11].Text =
                //    "<a id=\"" + e.Row.Cells[0].Text + "\" href=\"#\" class=\"btn btn-link\" data-content='" + e.Row.Cells[11].Text + "' data-placement=\"bottom\">" +
                //    "Comments truncated please click here to review.</a><script>$('#" + e.Row.Cells[0].Text + "').popover()</script>";
            }

            if (e.Row.Cells[0].Text.Contains("INC"))
            {
                e.Row.Cells[0].Text = "<a href=\"https://nbcu.service-now.com/do/incident.do?sysparm_query=number=" + e.Row.Cells[0].Text +
                                      "\" target=\"_blank\">" + e.Row.Cells[0].Text + "</a>";
            }
            if (e.Row.Cells[0].Text.Contains("REQ"))
            {
                e.Row.Cells[0].Text = "<a href=\"https://nbcu.service-now.com/do/sc_request.do?sysparm_query=number=" + e.Row.Cells[0].Text +
                                      "\" target=\"_blank\">" + e.Row.Cells[0].Text + "</a>";
            }
            e.Row.Cells[5].BackColor = ColorTranslator.FromHtml(SetColor(e.Row.Cells[5].Text));
            e.Row.Cells[6].BackColor = ColorTranslator.FromHtml(SetColor(e.Row.Cells[6].Text));
            e.Row.Cells[7].BackColor = ColorTranslator.FromHtml(SetColor(e.Row.Cells[7].Text));
            e.Row.Cells[8].BackColor = ColorTranslator.FromHtml(SetColor(e.Row.Cells[8].Text));
            e.Row.Cells[9].BackColor = ColorTranslator.FromHtml(SetColor(e.Row.Cells[9].Text));
            e.Row.Cells[10].BackColor = ColorTranslator.FromHtml(SetColor(e.Row.Cells[10].Text));            
        }

        private static string SetColor(string str)
        {
            switch (str)
            {
                case "1":
                    return "#E42222";
                case "2":
                    return "#FE8C00";
                case "3":
                    return "#FEF100";
                case "4":
                    return "#006EFE";
                case "5":
                    return "#00FE04";
                default:
                    return "#FFFFFF";
            }
        }
    }
}