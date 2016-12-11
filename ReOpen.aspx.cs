using System;

namespace MetricsDashboard
{
    public partial class ReOpen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string queue;
            if (DropDownList1.SelectedValue == "")
            {
                GridView1.Visible = false;
                GridView2.Visible = false;
                queue = "'%TAC%' and `assignment_group` <> 'TAC Network L1' ";
            }
            else
            {
                queue = "'" + DropDownList1.SelectedValue + "'";
            }
            var query = "select `Number`, `assigned_to` as Owner,  `state` as Stage,  " +
                        "`short_description` as Desciption, `sys_updated_on` as Updated, " +
                        "`close_code` as State, `reopen_count` as ReOpen " +
                        "from servicenow_sla2 where `type` = 'inc' and " +
                        "`resolved_at` >= concat(CURDATE() - INTERVAL 30 DAY, ' 00:00:00') " +
                        "and `assignment_group` like " + queue + " and `reopen_count` <> '0' " +
                        "and `close_code` not like '%cancelled%' order by `sys_updated_on` desc;";
            SqlDataSource1.SelectCommand = query;
            SqlDataSource1.DataBind();
            GridView1.DataBind();

            query = "select `Number`, `assigned_to` as Owner,  `state` as Stage,  " +
                    "`short_description` as Desciption, `sys_updated_on` as Updated, " +
                    "`close_code` as State, `reopen_count` as ReOpen " +
                    "from servicenow_sla2 where `type` = 'rit' and " +
                    "`resolved_at` >= concat(CURDATE() - INTERVAL 30 DAY, ' 00:00:00') " +
                    "and `assignment_group` like " + queue + " and `reopen_count` <> '' " +
                    "and `close_code` not like '%cancelled%' order by `sys_updated_on` desc;";
            SqlDataSource2.SelectCommand = query;
            SqlDataSource2.DataBind();
            GridView2.DataBind();
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var type = RadioButtonList1.SelectedValue;
            if (type == "INC")
            {
                GridView1.Visible = true;
                GridView2.Visible = false;
            }
            else if (type == "RITM")
            {
                GridView1.Visible = false;
                GridView2.Visible = true;
            }
        }
    }
}