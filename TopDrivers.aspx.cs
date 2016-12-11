using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MetricsDashboard
{
    public partial class TopDrivers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string queue;
            string queue2;
            if (queueDropDownList.SelectedValue == "")
            {
                queue = "`assignment_group` like '%TAC%' and `assignment_group` <> 'TAC Network L1' ";
                queue2 = "`group` like '%TAC%' and `group` <> 'TAC Network L1' ";
            }
            else
            {
                queue = "`assignment_group` = '" + queueDropDownList.SelectedValue + "' ";
                queue2 = "`group` = '" + queueDropDownList.SelectedValue + "' ";
            }

            var query =
                "select * from (select a.*, b.tally as Last_Month, c.tally as Current_Month, d.tally as Ereyesterday, e.tally as Yesterday, " +
                "(if(b.tally is null, 0, b.tally) + if(c.tally is null, 0, c.tally) + if(d.tally is null, 0, d.tally) + if(e.tally is null, 0, e.tally)) as Total " +
                "from(select `category`, `sub_category` from servicenow_sla2 where " + queue + " and " +
                "`opened_at` >= concat(date_format(CURRENT_DATE() - INTERVAL 1 month, '%Y-%m'), '-01 00:00:00') group by `category`, `sub_category`) as a left " +
                "join(select `category`, `sub_category`, count(`category`) as Tally from servicenow_sla2 where " + queue + " and " +
                "`opened_at` like concat(date_format(CURRENT_DATE() - INTERVAL 1 month, '%Y-%m'), '%') group by `category`, `sub_category` " +
                "order by count(`category`) desc) as b on a.category=b.category and a.sub_category=b.sub_category " +
                "left join(select `category`, `sub_category`, count(`category`) as Tally from servicenow_sla2 where " + queue + " and " +
                "`opened_at` like concat(date_format(CURRENT_DATE(), '%Y-%m'), '%') group by `category`, `sub_category` order by count(`category`) desc) as c " +
                "on a.category=c.category and a.sub_category=c.sub_category left join(select `category`, `sub_category`, count(`category`) as Tally from " +
                "servicenow_sla2 where " + queue + " and `opened_at` like concat(date_format(CURRENT_DATE() - INTERVAL 2 day, '%Y-%m-%d'), '%') " +
                "group by `category`, `sub_category` order by count(`category`) desc) as d on a.category=d.category and a.sub_category=d.sub_category " +
                "left join(select `category`, `sub_category`, count(`category`) as Tally from servicenow_sla2 where " + queue + " and " +
                "`opened_at` like concat(date_format(CURRENT_DATE() - INTERVAL 1 day, '%Y-%m-%d'), '%') group by `category`, `sub_category` order by " +
                "count(`category`) desc) as e on a.category=e.category and a.sub_category=e.sub_category) as temp order by total desc limit 10";

            var query2 =
                "select * from (select a.*, b.tally as Last_Month, c.tally as Current_Month, d.tally as Ereyesterday, e.tally as Yesterday, " +
                "(if(b.tally is null, 0, b.tally) + if(c.tally is null, 0, c.tally) + if(d.tally is null, 0, d.tally) + if(e.tally is null, 0, e.tally)) as Total " +
                "from " +
                "(select assignment_group, mid(number,1,3) as type from servicenow_sla2 where `ouser_id` in " +
                "(select `userid` from (select `userid` from sn_groups where " + queue2 + ") as tempb) " +
                "and `opened_at` >= concat(date_format(CURRENT_DATE() - INTERVAL 1 month, '%Y-%m'), '-01 00:00:00') group by assignment_group, mid(number,1,3)) as a " +
                "left join " +
                "(select assignment_group, mid(number,1,3) as type, count(assignment_group) as tally from servicenow_sla2 where `ouser_id` in " +
                "(select `userid` from (select `userid` from sn_groups where " + queue2 + ") as tempb) " +
                "and `opened_at` like concat(date_format(CURRENT_DATE() - INTERVAL 1 month, '%Y-%m'), '%') group by assignment_group, mid(number,1,3)) as b " +
                "on a.assignment_group=b.assignment_group and a.type=b.type " +
                "left join " +
                "(select assignment_group, mid(number,1,3) as type, count(assignment_group) as tally from servicenow_sla2 where `ouser_id` in " +
                "(select `userid` from (select `userid` from sn_groups where " + queue2 + ") as tempc) " +
                "and `opened_at` like concat(date_format(CURRENT_DATE(), '%Y-%m'), '%') group by assignment_group, mid(number,1,3)) as c " +
                "on a.assignment_group=c.assignment_group and a.type=c.type " +
                "left join " +
                "(select assignment_group, mid(number,1,3) as type, count(assignment_group) as tally from servicenow_sla2 where `ouser_id` in " +
                "(select `userid` from (select `userid` from sn_groups where " + queue2 + ") as tempc) " +
                "and `opened_at` like concat(date_format(CURRENT_DATE() - INTERVAL 2 day, '%Y-%m-%d'), '%') group by assignment_group, mid(number,1,3)) as d " +
                "on a.assignment_group=d.assignment_group and a.type=d.type " +
                "left join " +
                "(select assignment_group, mid(number,1,3) as type, count(assignment_group) as tally from servicenow_sla2 where `ouser_id` in " +
                "(select `userid` from (select `userid` from sn_groups where " + queue2 + ") as tempd) " +
                "and `opened_at` like concat(date_format(CURRENT_DATE() - INTERVAL 1 day, '%Y-%m-%d'), '%') group by assignment_group, mid(number,1,3) " +
                ") as e " +
                "on a.assignment_group=e.assignment_group and a.type=e.type) as temp order by total desc limit 10";

            SqlDataSource1.SelectCommand = query;
            SqlDataSource1.DataBind();
            GridView1.DataBind();

            SqlDataSource2.SelectCommand = query2;
            SqlDataSource2.DataBind();
            GridView2.DataBind();
        }
    }
}