<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TopDrivers.aspx.cs" Inherits="MetricsDashboard.TopDrivers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css"/>
    <link href="dropdown-menu.css" media="screen" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="auto-style2">
            <tr>
                <td style="width: 200px;">
                    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="select distinct(`assignment_group`) from servicenow_sla2"></asp:SqlDataSource>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Pics/Technology_logo_horz_bw.png" />
                </td>
                <td>
                    <ul id="drop-nav">
                        <li><a href="#">Additional Pages</a>
                              <ul>
                                <li><a href="Aging.aspx" target="_blank">Aging Ticket Report</a></li>
                                <li><a href="Performance.aspx" target="_blank">Analyst Performance</a></li>
                                <li><a href="Charts.aspx" target="_blank">Monitoring Statistics</a></li>
                                <li><a href="ReOpen.aspx" target="_blank">ReOpens</a></li>
                                <li><a href="Misses.aspx" target="_blank">SLA Misses</a></li>
                                <li><a href="TopDrivers.aspx" target="_blank">Top Drivers</a></li>
                                <li><a href="VOC.aspx" target="_blank">VOC</a></li>
                            </ul>
                          </li>
                    </ul>
                    <div class="LikeUL">
                        Search Queue 
                            <asp:DropDownList ID="queueDropDownList" runat="server" DataSourceID="SqlDataSource8" DataTextField="assignment_group" 
                                    DataValueField="assignment_group" AutoPostBack="True">
                            </asp:DropDownList>
                    </div>
                </td>
                <td style="width: 20px">
                </td>
            </tr>
        </table>
        <hr />
        <table class="auto-style2">
            <tr>
                <td>
                    <h2 class="label"><strong>Breakdown of tickets assigned in queue</strong></h2>
                    <hr />
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataSourceID="SqlDataSource1">
                        <AlternatingRowStyle BackColor="#EEEEEE" />
                        <Columns>
                            <asp:BoundField DataField="category" HeaderText="Category" />
                            <asp:BoundField DataField="sub_category" HeaderText="Sub Category" />
                            <asp:BoundField DataField="Last_Month" HeaderText="Last Month" />
                            <asp:BoundField DataField="Current_Month" HeaderText="Current Month" />
                            <asp:BoundField DataField="Ereyesterday" HeaderText="Ereyesterday" />
                            <asp:BoundField DataField="Yesterday" HeaderText="Yesterday" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
                <td>
                    <h2 class="label"><strong>Tickets created by team memebers</strong></h2>
                    <hr />
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" CssClass="mGrid">
                        <Columns>
                            <asp:BoundField DataField="assignment_group" HeaderText="Assignment Group" />
                            <asp:BoundField DataField="type" HeaderText="Type" />
                            <asp:BoundField DataField="Last_Month" HeaderText="Last Month" />
                            <asp:BoundField DataField="Current_Month" HeaderText="Current Month" />
                            <asp:BoundField DataField="Ereyesterday" HeaderText="Ereyesterday" />
                            <asp:BoundField DataField="Yesterday" HeaderText="Yesterday" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#EEEEEE" />
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" ></asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
