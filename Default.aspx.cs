using System;
using System.Web.UI.WebControls;

namespace MetricsDashboard
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var yesterDay = !Page.IsPostBack ? DateTime.Now.AddDays(-1) : 
            //    DateTime.Parse(filterDateTextBox.Text);

            var yesterDay = DateTime.Now.AddDays(-1);

            var queue = !Page.IsPostBack ? "'%TAC%' and `assignment_group` <> 'TAC Network L1' " :
            //var queue = !Page.IsPostBack ? "'%TAC%'" :
                "'" + queueDropDownList.SelectedItem + "'";
            
            var dailyDate = string.Format("{0:yyyy-MM-dd}", yesterDay);
            var mtdDate = string.Format("{0:yyyy-MM}", yesterDay);
            var endDate = DateTime.Now.AddDays(-1);
            var startDate = DateTime.Now.AddDays(-31);
            var startString = string.Format("{0:yyyy-MM-dd}", startDate);
            var endString = string.Format("{0:yyyy-MM-dd}", endDate);

            var sqlquery1 = "select a.*, if(b.INCMade is null, 0, b.INCMade) as INCMade , if(c.INCmissed is null, 0, c.INCmissed) as INCmissed, concat(floor((if(b.INCMade is null, 0, b.INCMade)/(if(b.INCMade is null, 0, b.INCMade) + if(c.INCmissed is null, 0, c.INCmissed))) * 100), '%') as INCSLA , if(g.INCReopen is null, 0, g.INCReopen) as INCReopen, " +
                                "if(d.RITMMade is null, 0, d.RITMMade) as RITMMade, if(e.RITMMissed is null, 0, e.RITMMissed) as RITMMissed, concat(floor((if(d.RITMMade is null, 0, d.RITMMade)/(if(d.RITMMade is null, 0, d.RITMMade) + if(e.RITMmissed is null, 0, e.RITMmissed))) * 100), '%') as RITMSLA, if(f.RITMReopen is null, 0, f.RITMReopen) as RITMReopen from " +
                                "(select distinct(mid(Resolved,1,11)) as Date from " +
                                "(" +
                                "    SELECT" +
                                "    `servicenow_sla2`.`resolved_at` as Resolved" +
                                "    FROM `dsbpws01`.`servicenow_sla2` " +
                                "    where `resolved_at` like  '" + dailyDate + "%'" +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                ") as datetable order by Resolved" +
                                ") as a " +
                                "left join " +
                                "(" +
                                "    select mid(`resolved_at`,1,11) as Date, count(mid(`resolved_at`,1,11)) as INCMade from servicenow_sla2 where " +
                                "    `type` = 'INC' and `has_breached` = 'FALSE'" +
                                "    and `resolved_at` <> '' and `resolved_at` like '" + dailyDate + "%' " +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                "    group by mid(`resolved_at`,1,11),`has_breached`" +
                                ") as b on a.date=b.date " +
                                "left join " +
                                "(" +
                                "    select mid(`resolved_at`,1,11) as Date, count(mid(`resolved_at`,1,11)) as INCMissed from servicenow_sla2 where " +
                                "    `type` = 'INC' and `has_breached` = 'TRUE'" +
                                "    and `resolved_at` <> '' and `resolved_at` like  '" + dailyDate + "%'  " +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                "    group by mid(`resolved_at`,1,11),`has_breached`" +
                                ") as c on a.date=c.date " +
                                "left join " +
                                "(" +
                                "    select mid(`resolved_at`,1,11) as Date, count(mid(`resolved_at`,1,11)) as RITMMade " +
                                "    from servicenow_sla2 where `type` = 'RIT' and Has_breached = 'FALSE'" +
                                "    and `resolved_at` <> '' and `resolved_at` like  '" + dailyDate + "%'" +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                "    group by mid(`resolved_at`,1,11),`has_breached`" +
                                ") as d on a.date=d.date " +
                                "left join " +
                                "(" +
                                "    select mid(`resolved_at`,1,11) as Date, count(mid(`resolved_at`,1,11)) as RITMMissed " +
                                "    from servicenow_sla2 where `type` = 'RIT' and Has_breached = 'TRUE'" +
                                "    and `resolved_at` <> '' and `resolved_at` like  '" + dailyDate + "%'" +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                "    group by mid(`resolved_at`,1,11),`has_breached`" +
                                ") as e on a.date=e.date " +
                                "left join " +
                                "(" +
                                "    select mid(`resolved_at`,1,11) as Date, count(mid(`resolved_at`,1,11)) as RITMReopen" +
                                "    from servicenow_sla2 where `type` = 'RIT' and `resolved_at` <> '' and `resolved_at` like  '" + dailyDate + "%'" +
                                "    and  `reopen_count` >= 1" +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                "    group by mid(`resolved_at`,1,11)" +
                                ")  as f on a.date=f.date " +
                                "left join " +
                                "(" +
                                "    select mid(`resolved_at`,1,11) as Date, count(mid(`resolved_at`,1,11)) as INCReopen" +
                                "    from servicenow_sla2 where `type` = 'INC' and `resolved_at` <> '' and `resolved_at` like  '" + dailyDate + "%'" +
                                "    and  `reopen_count` >= 1" +
                                " and `assignment_group` like " + queue +
                                " and `close_code` not like '%cancelled%' " +
                                "    group by mid(`resolved_at`,1,11)" +
                                ")  as g on a.date=g.date " +
                                "order by date ";


            var sqlquery2 = "select a.*, b.TotalMissed, concat(floor((a.TotalMade / (a.TotalMade + b.TotalMissed)) * 100), '%') as TotalSLA, c.TotalReopen from " +
                            "(select '" + mtdDate + "' as Date, if(count(number) is null, 0, count(number)) as TotalMade from  " +
                            "        `servicenow_sla2` where `resolved_at` like '" + mtdDate + "%' " +
                            "            and `assignment_group` like " + queue +
	                        "    and `type` in ('inc','rit') and has_breached = 'false') as a " +
                            "left join  " +
                            "(select '2015-10' as Date, if(count(number) is null, 0, count(number)) as TotalMissed from  " +
                            "        `servicenow_sla2` where `resolved_at` like '" + mtdDate + "%' " +
                            "            and `assignment_group` like " + queue +
	                        "    and `type` in ('inc','rit') and has_breached = 'true') as b on a.date = b.date " +
                            "left join " +
                            "(select '2015-10' as Date, if(count(number) is null, 0, count(number)) as TotalReopen from  " +
                            "        `servicenow_sla2` where `resolved_at` like '" + mtdDate + "%' " +
                            "            and `assignment_group` like " + queue +
	                        "    and `type` in ('inc','rit') and reopen_count > 0) as c on a.date = c.date";

            var sqlquery3 = "select a.AgedTicket, round(a.Aver,1) as Aver, b.ToBeWorked, round(b.ToBeWorked / Aver,1) as DaysWork from " +
                               " (select 'AgedTicket' as AgedTicket, count(`number`)/30 as Aver from `servicenow_sla2` where " +
                               " (`resolved_at` >= '" + startString + " 00:00:00' and `resolved_at` <= '" + endString + " 23:59:59' " +
                               "and `type` = 'r%' and `assignment_group` like " + queue +
                               " and `close_code` not like '%cancelled%' " + ") or" +
                               " (`resolved_at` >= '" + startString + " 00:00:00' and `resolved_at` <= '" + endString + " 23:59:59'" +
                               " and `assignment_group` like " + queue +
                               " and `close_code` not like '%cancelled%' " + ")) as a" +
                               " join" +
                               " (select 'AgedTicket' as AgedTicket, count(`number`) as ToBeWorked from `servicenow_sla2` where " +
                               " (`resolved_at` = '' and `type` = 'RIT'" + " and `assignment_group` like " + queue +
                               " and `close_code` not like '%cancelled%' " + ") or" +
                               " (`resolved_at` = '' and `type` = 'INC'" + " and `assignment_group` like " + queue +
                               " and `close_code` not like '%cancelled%' " + ")) as b" +
                               " on a.AgedTicket = b.AgedTicket";

            var sqlquery4 = "select a.*, b.`4-7`, c.`8-15`, d.`16-30`, e.`> 31` from  " +
                                     " ( " +
                                     "     select 'Counts' as counts, count(`number`) as '< 3' from ( " +
                                     "         SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "         FROM `servicenow_sla2` where (`resolved_at` = '' and `type` = 'INC'" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ") or " +
                                     "         (`resolved_at` = '' and `type` in ('inc','rit')" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ") " +
                                     "     ) as agedtickcouont where days < 4 " +
                                     " ) as a " +
                                     " join " +
                                     " ( " +
                                     "     select 'Counts' as counts, count(`number`) as '4-7' from ( " +
                                     "         SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "         FROM `servicenow_sla2` where (`resolved_at` = '' and `type` = 'INC'" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ") or " +
                                     "         (`resolved_at` = '' and `type` in ('inc','rit')" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ")  " +
                                     "     ) as agedtickcouont where days >= 4 and days <= 7 " +
                                     " ) as b on a.counts = b.counts " +
                                     " join " +
                                     " ( " +
                                     "     select 'Counts' as counts, count(`number`) as '8-15' from ( " +
                                     "         SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "         FROM `servicenow_sla2` where (`resolved_at` = '' and `type` = 'INC'" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ") or " +
                                     "         (`resolved_at` = '' and `type` in ('inc','rit')" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ") " +
                                     "     ) as agedtickcouont where days >= 8 and days <= 15 " +
                                     " ) as c on a.counts = c.counts " +
                                     " join " +
                                     " ( " +
                                     "     select 'Counts' as counts, count(`number`) as '16-30' from ( " +
                                     "         SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "         FROM `servicenow_sla2` where (`resolved_at` = '' and `type` = 'INC'" + " and `assignment_group` like " + queue +  ") or " +
                                     "         (`resolved_at` = '' and `type` in ('inc','rit')" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ") " +
                                     "     ) as agedtickcouont where days >= 16 and days <= 30 " +
                                     " ) as d on a.counts = d.counts " +
                                     " join " +
                                     " ( " +
                                     "     select 'Counts' as counts, count(`number`) as '> 31' from ( " +
                                     "         SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "         FROM `servicenow_sla2` where (`resolved_at` = '' and `type` = 'INC'" + " and `assignment_group` like " + queue +  ") or " +
                                     "         (`resolved_at` = '' and `type` in ('inc','rit')" + " and `assignment_group` like " + queue +
                                     " and `close_code` not like '%cancelled%' " + ")  " +
                                     "     ) as agedtickcouont where days >= 31  " +
                                     " ) as e on a.counts = e.counts";

            var sqlquery5 = "select `state`, `priority`, count(`state`) as Tally from servicenow_sla2 where `type` like 'c%' and " +
                                     "`start_date` like concat(date_format(now(), '%Y-%m-%d'),'%') and `state` not like 'Closed%' " +
                                     " and `assignment_group` like " + queue + 
                                     "group by `state`, `priority`";

            var sqlquery6 = "select `state`, count(`state`) as Tally from servicenow_sla2 where `resolved_at` like " +
                                     " concat(date_format(DATE_SUB(now(),INTERVAL 1 DAY), '%Y-%m-%d'),'%') and `state` like 'Closed%' " +
                                     " and `assignment_group` like " + queue +  "group by `state`";

            var sqlquery7 = "select a.*, b.`4-7`, c.`8-15`, d.`16-30`, e.`> 31` from  " +
                                     "( " +
                                     "    select 'Counts' as counts, count(`number`) as '< 3' from ( " +
                                     "        SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "        FROM `servicenow_sla2` where " +
                                     "        (`resolved_at` = '' and `type` like 'C%'" + " and `assignment_group` like " + queue +  ") " +
                                     "    ) as agedtickcouont where days < 4 " +
                                     ") as a " +
                                     "join " +
                                     "( " +
                                     "    select 'Counts' as counts, count(`number`) as '4-7' from ( " +
                                     "        SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "        FROM `servicenow_sla2` where " +
                                     "        (`resolved_at` = '' and `type` like 'C%'" + " and `assignment_group` like " + queue +  ")  " +
                                     "    ) as agedtickcouont where days >= 4 and days <= 7 " +
                                     ") as b on a.counts = b.counts " +
                                     "join " +
                                     "( " +
                                     "    select 'Counts' as counts, count(`number`) as '8-15' from ( " +
                                     "        SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "        FROM `servicenow_sla2` where " +
                                     "        (`resolved_at` = '' and `type` like 'C%'" + " and `assignment_group` like " + queue +  ") " +
                                     "    ) as agedtickcouont where days >= 8 and days <= 15 " +
                                     ") as c on a.counts = c.counts " +
                                     "join " +
                                     "( " +
                                     "    select 'Counts' as counts, count(`number`) as '16-30' from ( " +
                                     "        SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "        FROM `servicenow_sla2` where  " +
                                     "        (`resolved_at` = '' and `type` like 'C%'" + " and `assignment_group` like " + queue +  ") " +
                                     "    ) as agedtickcouont where days >= 16 and days <= 30 " +
                                     ") as d on a.counts = d.counts " +
                                     "join " +
                                     "( " +
                                     "    select 'Counts' as counts, count(`number`) as '> 31' from ( " +
                                     "        SELECT `number`, DATEDIFF(CURDATE(),`opened_at`) AS DAYS " +
                                     "        FROM `servicenow_sla2` where  " +
                                     "        (`resolved_at` = '' and `type` like 'C%'" + " and `assignment_group` like " + queue +  ")  " +
                                     "    ) as agedtickcouont where days >= 31  " +
                                     ") as e on a.counts = e.counts;"; 

            SqlDataSource1.SelectCommand = sqlquery1;
            SqlDataSource1.DataBind();
            GridView1.DataBind();

            SqlDataSource2.SelectCommand = sqlquery2;
            SqlDataSource2.DataBind();
            GridView2.DataBind();

            SqlDataSource3.SelectCommand = sqlquery3;
            SqlDataSource3.DataBind();
            GridView3.DataBind();

            SqlDataSource4.SelectCommand = sqlquery4;
            SqlDataSource4.DataBind();
            GridView4.DataBind();

            SqlDataSource5.SelectCommand = sqlquery5;
            SqlDataSource5.DataBind();
            GridView5.DataBind();

            SqlDataSource6.SelectCommand = sqlquery6;
            SqlDataSource6.DataBind();
            GridView6.DataBind();

            SqlDataSource7.SelectCommand = sqlquery7;
            SqlDataSource7.DataBind();
            GridView7.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var percentage = e.Row.Cells[3].Text.Replace("%", "");
                if (percentage == "&nbsp;") percentage = "0";
                var severity = int.Parse(percentage);
                if (severity >= 97)
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Green;
                }
                else if (severity <= 95)
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                }
                else if (severity == 0)
                {
                    
                }
                else
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Yellow;
                }


                percentage = e.Row.Cells[7].Text.Replace("%", "");
                if (percentage == "&nbsp;") percentage = "0";
                severity = int.Parse(percentage);
                if (severity >= 97)
                {
                    e.Row.Cells[7].BackColor = System.Drawing.Color.Green;
                }
                else if (severity <= 95)
                {
                    e.Row.Cells[7].BackColor = System.Drawing.Color.Red;
                }
                else if (severity == 0)
                {

                }
                else
                {
                    e.Row.Cells[7].BackColor = System.Drawing.Color.Yellow;
                }
            }
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var percentage = e.Row.Cells[3].Text.Replace("%", "");
                if (percentage == "&nbsp;") percentage = "0";
                var severity = int.Parse(percentage);

                if (severity >= 97)
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Green;
                }
                else if (severity <= 95)
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                }
                else if (severity == 0)
                {

                }
                else
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Yellow;
                }
            }
        }
    }
}