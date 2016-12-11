using System;
using System.Web.UI.WebControls;

namespace MetricsDashboard
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string _start;
        private string _end;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                _start = string.Format("{0:yyyy-MM-dd}", DateTime.Now.AddDays(-8).Date) + " 00:00:00";
                _end = string.Format("{0:yyyy-MM-dd}", DateTime.Now.AddDays(-1).Date) + " 23:59:59";

                DrawObjects();
            }
            else
            {
                _start = startDateTextBox.Text + " 00:00:00";
                _end = endDateTextBox.Text + " 23:59:59";
            }
            //using (var conn = new MySqlConnection("Server=AOAAPWP00109.nbcuni.ge.com;Port=3347;user id=dsbpws1usr;password=6$BpWslUs7jW;database=DSBPWS01"))
            //using (var command = new MySqlCommand("trendingreport", conn)
            //{
            //    CommandType = CommandType.StoredProcedure
            //})
            //{
            //    conn.Open();
            //    command.ExecuteNonQuery();
            //    conn.Close();
            //}
        }


        private void DrawObjects()
        {
            Chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;

            Chart2.ChartAreas["ChartArea1"].AxisX.Interval = 1;
            
            var sqlString = "select distinct(alerttype), count(alerttype) from Alerts where date >= '" + _start + "' and date <= '" + _end +
                "' group by alerttype order by alerttype desc";
            SqlDataSource1.SelectCommand = sqlString;
            SqlDataSource1.DataBind();
            Chart1.DataBind();

            Chart1.Series["Series1"].Points.AddY(20);
            Chart1.Series["Series1"].ChartArea = "ChartArea1";
            Chart1.Series["Series1"].XValueMember = "alerttype";
            Chart1.Series["Series1"].YValueMembers = "count(alerttype)";

            sqlString = "select device, count(device) as alerts, alerttype, description from Alerts where date >= '" + _start + "' and date <= '" + _end +
                 "' group by device having count(device) > 20 order by count(device) desc";
            SqlDataSource2.SelectCommand = sqlString;
            SqlDataSource2.DataBind();
            GridView1.DataBind();

            sqlString = "select mid(date,1,10) as ShortDate, count(mid(date,1,10)) as Tally from alerts where date >= '" + _start + "' and date <= '" + _end + "' group by mid(date,1,10)";
            SqlDataSource3.SelectCommand = sqlString;
            SqlDataSource3.DataBind();
            Chart2.DataBind();

            sqlString = "select alerttype, description, count(*) as tally from alerts where date >= '" + _start + "' and date <= '" + _end +
                "' group by alerttype, description order by tally desc, alerttype, description";
            SqlDataSource4.SelectCommand = sqlString;
            SqlDataSource4.DataBind();
            GridView2.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DrawObjects();
        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var percentage = e.Row.Cells[2].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
                }
                percentage = e.Row.Cells[3].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;
                }
                percentage = e.Row.Cells[4].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[4].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
                }
                percentage = e.Row.Cells[5].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[5].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
                }
                percentage = e.Row.Cells[6].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[6].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[6].ForeColor = System.Drawing.Color.Red;
                }
                percentage = e.Row.Cells[7].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[7].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;
                }
                percentage = e.Row.Cells[8].Text;
                if (percentage != "&nbsp;")
                {
                    e.Row.Cells[8].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[8].ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}