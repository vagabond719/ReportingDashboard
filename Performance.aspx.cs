using System;
using System.Drawing;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace MetricsDashboard
{
    public partial class WebFormPerformance : System.Web.UI.Page
    {
        protected void searchButton_Click(object sender, EventArgs e)
        {
            var group = groupDropDownList.SelectedValue;
            if (group == "") group = "%TAC%' and `assignment_group` <> 'TAC Network L1";
            var dateRange = " between ";
            var groupquery = " and `assignment_group` like '" + group + "'";

            var hours = hoursDropDownList.SelectedValue;
            string start;
            string end;
            if (hours == "07:00 - 06:59")
            {
                start = "07:00:00";
                end = "06:59:59";
            }
            else
            {
                start = "00:00:00";
                end = "23:59:59";
            }

            if (startDateTextBox.Text != "Start Date:")
            {
                dateRange = dateRange + "'" + string.Format("{0:yyyy-MM-dd}", Convert.ToDateTime(startDateTextBox.Text)) + " " + start + "' and ";
            }
            else
            {
                if (start == "00:00:00")
                {
                    dateRange = dateRange + "'" + string.Format("{0:yyyy-MM-dd}", DateTime.Now.Date) + " " + start + "' and ";
                }
                else
                {
                    dateRange = dateRange + "'" + string.Format("{0:yyyy-MM-dd}", DateTime.Now.Date.AddDays(-1)) + " " + start + "' and ";
                }

            }
            if (endDateTextBox.Text != "End Date:")
            {
                dateRange = dateRange + "'" + string.Format("{0:yyyy-MM-dd}", Convert.ToDateTime(endDateTextBox.Text)) + " " + end + "' ";
            }
            else
            {
                dateRange = dateRange + "'" + string.Format("{0:yyyy-MM-dd}", DateTime.Now.Date) + " " + end + "' ";
            }

            var mySelectQuery = "Select distinct(`assigned_to`) from `servicenow_sla2` where `assigned_to` <> '' and " +
                "(`resolved_at` " + dateRange + ") and `stage` not in ('Cancelled','Rejected') " + groupquery + " order by `assigned_to`";

            var connStr = string.Format("server=AOAAPWP00109.nbcuni.ge.com;user id=dsbpws1usr; password=6$BpWslUs7jW;" +
                        "database=DSBPWS01; pooling=false; port=3347;");

            var caseQuery = "";
            var myConnection = new MySqlConnection(connStr);
            var myCommand = new MySqlCommand(mySelectQuery, myConnection);
            myConnection.Open();
            var myReader = myCommand.ExecuteReader();
            try
            {
                while (myReader.Read())
                {
                    var newString = myReader.GetString(0).Replace("'", @"\'");
                        caseQuery += " SUM(CASE `assigned_to` WHEN '" + newString +
                        "' THEN tally ELSE 0 END) AS '" + newString + "',";  
                }
            }
            finally
            {
                myReader.Close();
                myConnection.Close();
            }

            var query = "select Date," + caseQuery +
            " SUM( tally ) AS Total from" +
            " (" +
            " Select mid(`resolved_at`,1,13) as date, `assigned_to`,  " +
            " count(mid(`resolved_at`,1,13)) as Tally" +
            " from `servicenow_sla2` where" +
            " (`resolved_at` " + dateRange + groupquery + ") " +
            " and `stage` not in ('Cancelled','Rejected') group by date, `assigned_to` " +
            " order by date" +
            " ) as mytable " +
            " GROUP BY date WITH ROLLUP; ";

            SqlDataSource1.SelectCommand = query;
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                if (e.Row.Cells[i].Text == "0")
                {
                    e.Row.Cells[i].ForeColor = ColorTranslator.FromHtml("#FFFFFF");   
                }
            }
        }
    }
}