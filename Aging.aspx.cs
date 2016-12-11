using System;
using System.Drawing;
using System.Web.UI.WebControls;

namespace MetricsDashboard
{
    public partial class Aging : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string queue;
            if (queueDropDownList.SelectedValue == "") 
            {
                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.Visible = false;
                queue = "'%TAC%' and `assignment_group` <> 'TAC Network L1' ";
            }
            else
            {
                queue = "'" + queueDropDownList.SelectedValue + "'";
            }
            
            var type = RadioButtonList1.SelectedValue;

            string query;
            string query2;
            string nameFilter = "";

            if (nameFilterDropDownList.SelectedValue == "All")
            {
                nameFilter = "";
            }
            else
            {
                nameFilter = " `assigned_to` = '" + nameFilterDropDownList.SelectedValue + "' and ";
            }
                

            if (type != "")
            {
                query =
                    "select `number` as Number, `assigned_to` as Owner, `state` as State, DATEDIFF(CURDATE(),`opened_at`) AS Age, SEC_TO_TIME(time_remaining) as time_remaining, " +
                    "`short_description` as Desciption, `sys_updated_on` as Updated, `end_date` as EndDate  from `servicenow_sla2` where " + nameFilter +
                    "`state` not like 'Closed%' and `assignment_group` like " +
                    queue + " and `state` not in ('Resolved','Fulfilled') and `type` = '" + type.Substring(0, 3) +
                    "' order by DATEDIFF(CURDATE(),`opened_at`) desc";

                query2 =
                    "select distinct(assigned_to) from servicenow_sla2 where `state` not in ('Resolved','Fulfilled') and `assignment_group` like " +
                    queue;
            }
            else
            {
                query = "";
                query2 = "";
            }

            if (type == "CTASK")
            {
                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.Visible = true;
                
                SqlDataSource1.SelectCommand = query;
                SqlDataSource1.DataBind();
                GridView4.DataBind();
            }
            else if (type == "CHG")
            {
                GridView1.Visible = false;
                GridView2.Visible = false;
                GridView3.Visible = true;
                GridView4.Visible = false;

                SqlDataSource1.SelectCommand = query;
                SqlDataSource1.DataBind();
                GridView3.DataBind();
            }
            else if (type == "INC")
            {
                GridView1.Visible = true;
                GridView2.Visible = false;
                GridView3.Visible = false;
                GridView4.Visible = false;

                SqlDataSource1.SelectCommand = query;
                SqlDataSource1.DataBind();
                GridView1.DataBind();
            }
            else if (type == "RITM")
            {
                GridView1.Visible = false;
                GridView2.Visible = true;
                GridView3.Visible = false;
                GridView4.Visible = false;
                
                SqlDataSource1.SelectCommand = query;
                SqlDataSource1.DataBind();
                GridView2.DataBind();
            }
            if (type == "")
            {
                nameFilterDropDownList.Visible = false;
                Label1.Visible = false;
            }
            else
            {
                nameFilterDropDownList.Visible = true;
                Label1.Visible = true;
                SqlDataSource2.SelectCommand = query2;
                SqlDataSource2.DataBind();
                nameFilterDropDownList.DataBind();
            }
        }

        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            e.Row.Cells[3].BackColor = ColorTranslator.FromHtml(SetColor(int.Parse((e.Row.Cells[3].Text))));

            if (e.Row.Cells.Count == 6) return;
            if (e.Row.Cells[6].Text == "&nbsp;") return;
            if (RadioButtonList1.SelectedValue == "INC" || RadioButtonList1.SelectedValue == "RITM") return;
            if (DateTime.Compare(DateTime.Now, DateTime.Parse(e.Row.Cells[6].Text)) <= 0) return;
            e.Row.Cells[6].BackColor = ColorTranslator.FromHtml("#E42222");

        }

        private static string SetColor(int daysOld)
        {
            if (daysOld >= 31)
            {
                return "#E42222";
            }
            else if (daysOld >= 16 && daysOld <= 30)
            {
                return "#FE8C00";
            }
            else if (daysOld >= 8 && daysOld <= 15)
            {
                return "#FEF100";
            }
            else if (daysOld >= 4 && daysOld <= 7)
            {
                return "#006EFE";
            }
            else if (daysOld >= 0 && daysOld <= 3)
            {
                return "#00FE04";
            }
            else
            {
                return "#FFFFFF";
            }
        }
    }
}