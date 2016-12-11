using System;
using System.Web;
using System.Web.UI.WebControls;
using System.DirectoryServices.AccountManagement;

namespace MetricsDashboard
{
    public partial class Misses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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
            else
            {
                GridView1.Visible = false;
                GridView2.Visible = false;   
            }
            //if (IsPostBack) return;
            //var userName = HttpContext.Current.User.Identity.Name;
            ////var ctx = new PrincipalContext(ContextType.Domain, "TFAYD");
            ////var usr = UserPrincipal.FindByIdentity(ctx, userName);
            //var query = "select `group` from sn_groups where userid = '" + userName.Replace("TFAYD\\","") + "';";
            //SqlDataSource5.SelectCommand = query;
            //SqlDataSource5.DataBind();
            //DropDownList1.DataBind();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var row = GridView1.Rows[e.RowIndex];
            TextBox lblAdjSlaTextBox = (TextBox)row.FindControl("ADJ_CommentTextBox");
            Label numberLabel = (Label)row.FindControl("NumberLabel");
            var slaList = (DropDownList)row.FindControl("SLA_List");

            var userName = HttpContext.Current.User.Identity.Name;
            var ctx = new PrincipalContext(ContextType.Domain, "TFAYD");
            var usr = UserPrincipal.FindByIdentity(ctx, userName);

            SqlDataSource1.UpdateCommand = "update servicenow_sla set ADJ_SLA = '" + slaList.SelectedValue + "', ADJ_Comment = '" + lblAdjSlaTextBox.Text +
                "', `Modified By` = '" + usr +
                "' where `task.number` = '" + numberLabel.Text + "';";
            SqlDataSource1.Update();

        }
    }
}